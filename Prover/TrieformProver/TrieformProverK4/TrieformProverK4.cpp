#include "TrieformProverK4.h"

shared_ptr<Cache> TrieformProverK4::persistentCache = make_shared<PrefixCache>("P");
map<vector<int>, shared_ptr<Trieform>> TrieformProverK4::all_trieforms;
ProbationSolutionMemo TrieformProverK4::probationMemo;
int TrieformProverK4::restartUntil = -1;

shared_ptr<Trieform>
TrieformFactory::makeTrieK4(const shared_ptr<Formula> &formula,
                            shared_ptr<Trieform> trieParent) {
  shared_ptr<Trieform> trie = shared_ptr<Trieform>(new TrieformProverK4());
  trie->initialise(formula, trieParent);
  return trie;
}
shared_ptr<Trieform>
TrieformFactory::makeTrieK4(const shared_ptr<Formula> &formula,
                            const vector<int> &newModality,
                            shared_ptr<Trieform> trieParent) {
  shared_ptr<Trieform> trie = shared_ptr<Trieform>(new TrieformProverK4());
  trie->initialise(formula, newModality, trieParent);
  return trie;
}
shared_ptr<Trieform>
TrieformFactory::makeTrieK4(const vector<int> &newModality,
                            shared_ptr<Trieform> trieParent) {
  shared_ptr<Trieform> trie = shared_ptr<Trieform>(new TrieformProverK4());
  trie->initialise(newModality, trieParent);
  return trie;
}

TrieformProverK4::TrieformProverK4() {}
TrieformProverK4::~TrieformProverK4() {}

shared_ptr<Trieform>
TrieformProverK4::create(const shared_ptr<Formula> &formula) {
  return TrieformFactory::makeTrieK4(formula, shared_from_this());
}
shared_ptr<Trieform>
TrieformProverK4::create(const shared_ptr<Formula> &formula,
                         const vector<int> &newModality) {
  return TrieformFactory::makeTrieK4(formula, newModality, shared_from_this());
}
shared_ptr<Trieform> TrieformProverK4::create(const vector<int> &newModality) {
  shared_ptr<Trieform> test = shared_from_this();
  return TrieformFactory::makeTrieK4(newModality, shared_from_this());
}

shared_ptr<Bitset>
TrieformProverK4::convertAssumptionsToBitset(literal_set literals) {
  shared_ptr<Bitset> bitset =
      shared_ptr<Bitset>(new Bitset(2 * assumptionsSize));
  for (Literal literal : literals) {
    bitset->set(2 * idMap[literal.getName()] + literal.getPolarity());
  }
  return bitset;
}

void TrieformProverK4::updateSolutionMemo(const shared_ptr<Bitset> &assumptions,
                                          Solution solution) {
  if (solution.satisfiable) {

    localMemo.insertSat(assumptions);
    /*
            auto cur = this;
            while (cur->getParent() != nullptr) {
                cur = dynamic_cast<TrieformProverK4 *>(cur->getParent().get());
                if (cur->getParent()!=nullptr) {
                    cout << "LEARNING: ";
                    for (auto x : cur->modality) {
                        cout << x << " ";
                    }
                    cout << endl;
                    cur->localMemo.insertSat(assumptions);

                }
            }
            */

  } else {
    localMemo.insertUnsat(assumptions, solution.conflict);
  }
}

int TrieformProverK4::isInHistory(vector<pair<int, shared_ptr<Bitset>>> history, shared_ptr<Bitset> bitset) {
    for (unsigned i = history.size(); i-- > 0;) {
        if (history[i].second->contains(*bitset)) return history[i].first;
    }
    return -1;
}

void TrieformProverK4::makePersistence() {
    for (auto modalSubtrie : subtrieMap) {
        dynamic_cast<TrieformProverK4 *>(modalSubtrie.second.get())
            ->makePersistence();
    }

    modal_clause_set persistentBoxes;
    for (ModalClause boxClause : clauses.getBoxClauses()) {
        // For a=>[]b in our box clauses add
        // a => [] a

        // Make persistence
        persistentBoxes.insert(
            {boxClause.modality, boxClause.left, boxClause.left});
    }
    clauses.extendBoxClauses(persistentBoxes);
}

void TrieformProverK4::propagateLevels() {
    for (auto modalSubtrie : subtrieMap) {
        modalSubtrie.second->overShadow(shared_from_this(), modalSubtrie.first);
        dynamic_cast<TrieformProverK4 *>(modalSubtrie.second.get())
            ->propagateLevels();
    }
}

void TrieformProverK4::propLearnClause(literal_set learnClause) {
            prover->addClause(learnClause);
    for (auto modalSubtrie : subtrieMap) {
        dynamic_cast<TrieformProverK4 *>(modalSubtrie.second.get())
        ->propLearnClause(learnClause);
    }


}
void TrieformProverK4::fillTrieformMap() {
    all_trieforms[modality] = shared_from_this();
    for (auto modalSubtrie : subtrieMap) {
        modalSubtrie.second->preprocess();
    }
}
void TrieformProverK4::preprocess() {
  makePersistence();
  propagateLevels();

  fillTrieformMap();
}

void TrieformProverK4::prepareSAT(name_set extra) {
  for (string name : extra) {
    idMap[name] = assumptionsSize++;
  }
  modal_names_map modalExtras = prover->prepareSAT(clauses, extra);
  for (auto modalSubtrie : subtrieMap) {
    modalSubtrie.second->prepareSAT(modalExtras[modalSubtrie.first]);
  }
}


shared_ptr<Bitset> TrieformProverK4::fleshedOutAssumptionBitset(
    literal_set model) {
    shared_ptr<Bitset> bitset =
        shared_ptr<Bitset>(new Bitset(2 * assumptionsSize));
    for (auto x : idMap) {
        Literal lit = Literal{x.first, 0};
        bitset->set(2 * x.second + (model.find(lit) == model.end()));
    }
    return bitset;
}
Solution TrieformProverK4::prove(literal_set assumptions) {
    return prove(0, assumptions);
}

Solution TrieformProverK4::prove(int depth,
                                 literal_set assumptions) {

    ProbationSolutionMemoState probationState;
    shared_ptr<Bitset> assumptionsBitset;
    shared_ptr<Bitset> fullAssumptionsBitset;
    LocalSolutionMemoResult memoResult;
    Solution solution;
    literal_set currentModel;
    modal_literal_map triggeredDiamonds;
    modal_literal_map triggeredBoxes;
    ProbationSolutionMemoResult probationMemoResult;

    // Check solution memo
    /*
    cout << "Depth: " << depth << " Proving: ";
    for (auto x : assumptions) cout << x.toString() << " "; cout << endl;
    */
    assumptionsBitset =
        convertAssumptionsToBitset(assumptions);
    memoResult =
        localMemo.getFromMemo(assumptionsBitset);

    if (memoResult.inSatMemo) {
        return memoResult.result;
    }

    probationMemoResult = probationMemo.getFromMemo(
        make_shared<vector<int>>(modality), assumptionsBitset);

    if (probationMemoResult.inSatMemo) {
        // cout << "Depth :" << depth << " " << "sat from probation: " <<
        // probationMemo.minimalRoot << endl;
        return probationMemoResult.result;
    }

    int inHistory = isInHistory(history, assumptionsBitset);
    if (inHistory != -1) {
        probationMemo.updateMinimalRoot(inHistory);
        // cout << "Depth :" << depth << " " << "Using history: " << inHistory
        // << endl;
        return {true, literal_set()};
    }

    // Solve locally
    restart:
    probationState = probationMemo.getState();
    solution = prover->solve(assumptions);

    if (!solution.satisfiable) {
        // prover->reduce_conflict(solution.conflict);
        probationMemo.setState(probationState);
        updateSolutionMemo(assumptionsBitset, solution);
        return solution;
    }

    currentModel = prover->getModel();
    assumptionsBitset = fleshedOutAssumptionBitset(currentModel);

    prover->calculateTriggeredDiamondsClauses();
    triggeredDiamonds = prover->getTriggeredDiamondClauses();
    prover->calculateTriggeredBoxClauses();
    triggeredBoxes = prover->getTriggeredBoxClauses();
    
    pastModels.push_back({depth, currentModel});
    for (auto modalityDiamonds : triggeredDiamonds) {
        // Handle each modality
        if (modalityDiamonds.second.size() == 0) {
            // If there are no triggered diamonds of a certain modality we can
            // skip it
            continue;
        }

        Solution childSolution;

        TrieformProverK4 *childNode =
            (subtrieMap.find(modalityDiamonds.first) == subtrieMap.end())
                ? this
                : dynamic_cast<TrieformProverK4 *>(
                      subtrieMap[modalityDiamonds.first].get());

        // The fired diamonds are not a subset of the fired boxes, we need to
        // create one world for each diamond clause
        bool diamondFailed = false;

        diamond_queue diamondPriority = prover->getPrioritisedTriggeredDiamonds(
            modalityDiamonds.first, triggeredBoxes[modalityDiamonds.first],
            triggeredDiamonds[modalityDiamonds.first]);

        while (!diamondPriority.empty()) {
            // Create a world for each diamond
            Literal diamond = diamondPriority.top().literal;
            diamondPriority.pop();

            literal_set childAssumptions =
                literal_set(triggeredBoxes[modalityDiamonds.first]);
            childAssumptions.insert(diamond);

            // Run the solver for the next level
            history.push_back({depth, assumptionsBitset});
            childSolution = childNode->prove(depth + 1, childAssumptions);

            history.pop_back();

            // Clause propagation
            for (literal_set learnClause : prover->getClauses(
                     modalityDiamonds.first,
                     prover->negatedClauses(childNode->allConflicts))) {
                allConflicts.push_back(learnClause);
                prover->addClause(learnClause);

                restartUntil =
                    checkClauseAgainstPastModels(restartUntil, learnClause);
            }
            childNode->allConflicts.clear();

            if (restartUntil != -1) {
                pastModels.pop_back();
                probationMemo.setState(probationState);
                if (restartUntil == depth) {
                    // restart current node
                    restartUntil = -1;
                    return prove(depth, assumptions);
                } else {
                    // Keep backtracking until we should restart
                    return childSolution;
                }
            }

            // If it is satisfiable create the next world
            if (childSolution.satisfiable) {
                // Don't check any more if we only required one
                if (isSubsetOf(triggeredDiamonds[modalityDiamonds.first],
                               triggeredBoxes[modalityDiamonds.first]))
                    break;
                else
                    continue;
            }
            diamondFailed = true;
            break;
        }

        if (!diamondFailed) continue;

        for (literal_set learnClause : prover->getClauses(
                 modalityDiamonds.first, childSolution.conflict)) {
            allConflicts.push_back(learnClause);

            propLearnClause(learnClause);

            restartUntil =
                checkClauseAgainstPastModels(restartUntil, learnClause);
        }

        if (restartUntil != -1) {
            pastModels.pop_back();
            probationMemo.setState(probationState);
            if (restartUntil == depth) {
                // restart current node
                restartUntil = -1;
                goto restart;
                //return prove(depth, assumptions);
            } else {
                // Keep backtracking until we should restart
                return childSolution;
            }
        }
    }
    pastModels.pop_back();

    // If we reached here the solution is satisfiable under all modalities
    if (probationMemo.minimalRoot == -1) {
        updateSolutionMemo(assumptionsBitset, solution);
    } else if (depth == probationMemo.minimalRoot) {
        // Move probation cache to actual cache
        for (auto x : probationMemo.getSatSols()) {
            auto trieform = dynamic_cast<TrieformProverK4 *>(
                all_trieforms[*x.first].get());
            trieform->localMemo.insertSat(x.second);
        }
        probationMemo.setState({-1, 0});
    } else if (depth > probationMemo.minimalRoot) {
        probationMemo.insertSat(make_shared<vector<int>>(modality),
                                assumptionsBitset);
    }
    return solution;
}


unsigned int TrieformProverK4::checkClauseAgainstPastModels(
    int restartUntil, literal_set clause) {
    for (unsigned int i = 0; i < pastModels.size(); i++) {
        bool contains = false;
        for (Literal x : clause) {
            if (pastModels[i].second.find(x) != pastModels[i].second.end()) {
                contains = true;
                break;
            }
        }
        if (!contains) {
            if (restartUntil == -1) return pastModels[i].first;
            return min(pastModels[i].first, restartUntil);
        };
    }
    return restartUntil;
}
