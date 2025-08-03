#include "TrieformProverK5.h"

shared_ptr<Cache> TrieformProverK5::persistentCache =
    make_shared<PrefixCache>("P");
int TrieformProverK5::restartUntil = -1;

map<vector<int>, shared_ptr<Trieform>> TrieformProverK5::all_trieforms;
ProbationSolutionMemo TrieformProverK5::probationMemo;

shared_ptr<Trieform> TrieformFactory::makeTrieK5(
    const shared_ptr<Formula> &formula, shared_ptr<Trieform> trieParent) {
    shared_ptr<Trieform> trie = shared_ptr<Trieform>(new TrieformProverK5());
    trie->initialise(formula, trieParent);
    return trie;
}
shared_ptr<Trieform> TrieformFactory::makeTrieK5(
    const shared_ptr<Formula> &formula, const vector<int> &newModality,
    shared_ptr<Trieform> trieParent) {
    shared_ptr<Trieform> trie = shared_ptr<Trieform>(new TrieformProverK5());
    trie->initialise(formula, newModality, trieParent);
    return trie;
}
shared_ptr<Trieform> TrieformFactory::makeTrieK5(
    const vector<int> &newModality, shared_ptr<Trieform> trieParent) {
    shared_ptr<Trieform> trie = shared_ptr<Trieform>(new TrieformProverK5());
    trie->initialise(newModality, trieParent);
    return trie;
}

TrieformProverK5::TrieformProverK5() {}
TrieformProverK5::~TrieformProverK5() {}

shared_ptr<Trieform> TrieformProverK5::create(
    const shared_ptr<Formula> &formula) {
    return TrieformFactory::makeTrieK5(formula, shared_from_this());
}
shared_ptr<Trieform> TrieformProverK5::create(
    const shared_ptr<Formula> &formula, const vector<int> &newModality) {
    return TrieformFactory::makeTrieK5(formula, newModality);
}
shared_ptr<Trieform> TrieformProverK5::create(const vector<int> &newModality) {
    return TrieformFactory::makeTrieK5(newModality);
}

int TrieformProverK5::isInHistory(vector<pair<int, shared_ptr<Bitset>>> history,
                                  shared_ptr<Bitset> bitset) {
    for (unsigned i = history.size(); i-- > 0;) {
        if (history[i].second->contains(*bitset)) return history[i].first;
    }
    return -1;
}

shared_ptr<Bitset> TrieformProverK5::convertAssumptionsToBitset(
    literal_set literals) {
    shared_ptr<Bitset> bitset =
        shared_ptr<Bitset>(new Bitset(2 * assumptionsSize));
    for (Literal literal : literals) {
        bitset->set(2 * idMap[literal.getName()] + literal.getPolarity());
    }
    return bitset;
}

void TrieformProverK5::updateSolutionMemo(const shared_ptr<Bitset> &assumptions,
                                          Solution solution) {
    if (solution.satisfiable) {
        localMemo.insertSat(assumptions);
    } else {
        localMemo.insertUnsat(assumptions, solution.conflict);
    }
}

void TrieformProverK5::propagateEuclideaness() {
    for (const ModalClause &clause : clauses.getDiamondClauses()) {
        if (modality.size() == 0 ||
            clause.modality != modality[modality.size() - 1]) {
            formula_set newOr;
            newOr.insert(clause.left->negate());
            if (cache->inverseContains(clause.right)) {
                newOr.insert(Box::create(
                    clause.modality, 1,
                    Diamond::create(clause.modality, 1,
                                    cache->getInverseFormula(clause.right))));
            } else {
                newOr.insert(Box::create(
                    clause.modality, 1,
                    Diamond::create(clause.modality, 1, clause.right)));
            }

            propagateClauses(Or::create(newOr));
        }
    }
}

void TrieformProverK5::reflexiveHandleBoxClauses() {
    /*
  for (ModalClause modalClause : clauses.getBoxClauses()) {
    if (modalClause.modality == modality[modality.size() - 1]) {
      formula_set newOr;
      newOr.insert(Not::create(modalClause.left)->negatedNormalForm());
      newOr.insert(modalClause.right);
      clauses.addClause(Or::create(newOr));
    }
  }*/

    if (hasSubtrie(modality[modality.size() - 1])) {
        dynamic_cast<TrieformProverK5 *>(
            getSubtrie(modality[modality.size() - 1]).get())
            ->reflexiveHandleBoxClauses();
    }
}

void TrieformProverK5::reflexivepropagateLevels() {
    if (hasSubtrie(modality[modality.size() - 1])) {
        shared_ptr<TrieformProverK5> subtrie =
            dynamic_pointer_cast<TrieformProverK5>(
                getSubtrie(modality[modality.size() - 1]));
        subtrie->reflexivepropagateLevels();
        overShadow(subtrie, modality[modality.size() - 1]);
    }
}

void TrieformProverK5::pruneTrie() {
    if (hasSubtrie(modality[modality.size() - 1])) {
        TrieformProverK5 *subtrie = dynamic_cast<TrieformProverK5 *>(
            getSubtrie(modality[modality.size() - 1]).get());
        if (subtrie->hasSubtrie(modality[modality.size() - 1])) {
            subtrie->removeSubtrie(modality[modality.size() - 1]);
        }
    }
}

void TrieformProverK5::globallyAddClauses(const FormulaTriple &otherClauses) {
    clauses.extendClauses(otherClauses);
    for (auto modalSubtrie : subtrieMap) {
        dynamic_cast<TrieformProverK5 *>(modalSubtrie.second.get())
            ->globallyAddClauses(otherClauses);
    }
}

shared_ptr<modal_clause_set> TrieformProverK5::getAllBoxClauses5() {
    shared_ptr<modal_clause_set> res = make_shared<modal_clause_set>();
    res->insert(clauses.getBoxClauses().begin(), clauses.getBoxClauses().end());
    for (auto modalitySubtrie : subtrieMap) {
        shared_ptr<modal_clause_set> other =
            (dynamic_cast<TrieformProverK5 *>(modalitySubtrie.second.get()))
                ->getAllBoxClauses5();
        res->insert(other->begin(), other->end());
    }
    return res;
}

void TrieformProverK5::makePersistence() {
    shared_ptr<modal_clause_set> boxClauses = getAllBoxClauses5();

    FormulaTriple ft;

    for (ModalClause boxClause : *boxClauses) {
        shared_ptr<Formula> aux =
            persistentCache->getVariableOrCreate(boxClause.left);
        shared_ptr<Formula> naux = Not::create(aux)->negatedNormalForm();
        shared_ptr<Formula> nleft =
            Not::create(boxClause.left)->negatedNormalForm();

        ft.addBoxClause(boxClause);
        ft.addClause({Or::create({naux, boxClause.left})});
        ft.addBoxClause({boxClause.modality, naux, nleft});
        ft.addBoxClause({boxClause.modality, aux, aux});
        ft.addDiamondClause({boxClause.modality, aux, boxClause.left});
    }
    globallyAddClauses(ft);

    /*
  if (hasSubtrie(modality[modality.size() - 1])) {
    dynamic_cast<TrieformProverK5 *>(
        getSubtrie(modality[modality.size() - 1]).get())
        ->makePersistence();
  }

  modal_clause_set persistentBoxes;
  for (ModalClause boxClause : clauses.getBoxClauses()) {
    if (boxClause.modality == modality[modality.size() - 1]) {
      // For a=>[]b in our box clauses replace with.
      // a=>Pb
      // Pb=>[]Pb
      // [](Pb=>b)

      // Make persistence (Pb=>[]Pb). Don't need to add Pb=>Pb

      shared_ptr<Formula> persistent =
          persistentCache->getVariableOrCreate(boxClause.right);
      persistentBoxes.insert({boxClause.modality, persistent, persistent});
      persistentBoxes.insert(
          {boxClause.modality, persistent->negate(), persistent->negate()});

      // Add a=>Pb
      formula_set leftSet;
      leftSet.insert(Not::create(boxClause.left)->negatedNormalForm());
      leftSet.insert(persistent);
      clauses.addClause(Or::create(leftSet));

      // Add b=>Pb and [](b=>Pb) where appropriate
      formula_set rightSet;
      rightSet.insert(Not::create(persistent)->negatedNormalForm());
      rightSet.insert(boxClause.right);
      shared_ptr<Formula> rightOr = Or::create(rightSet);
      propagateClauses(rightOr);
      if (modality.size() == 1 ||
          (modality.size() > 1 &&
           modality[modality.size() - 1] != modality[modality.size() - 2])) {
        getSubtrieOrEmpty(boxClause.modality)->propagateClauses(rightOr);
      }
    } else {
      persistentBoxes.insert(boxClause);
    }
  }
  clauses.setBoxClauses(persistentBoxes);

  for (ModalClause persistentBox : persistentBoxes) {
    if (persistentBox.modality == modality[modality.size() - 1] &&
        (modality.size() == 1 ||
         (modality.size() > 1 &&
          modality[modality.size() - 1] != modality[modality.size() - 2]))) {
      getSubtrieOrEmpty(persistentBox.modality)
          ->clauses.addBoxClause(persistentBox);
    }
  }
  */
}

void TrieformProverK5::preprocess() {
    all_trieforms[modality] = shared_from_this();
    // propagateEuclideaness();

    if (modality.size() == 1 ||
        (modality.size() > 1 &&
         modality[modality.size() - 1] != modality[modality.size() - 2])) {
        reflexiveHandleBoxClauses();
        reflexivepropagateLevels();

        pruneTrie();
    }

    for (auto modalSubtrie : subtrieMap) {
        modalSubtrie.second->preprocess();
    }

    if (modality.size() == 0) makePersistence();
}

Solution TrieformProverK5::prove(literal_set assumptions) {
    return prove(0, assumptions);
}

void TrieformProverK5::prepareSAT(name_set extra) {
    for (string name : extra) {
        idMap[name] = assumptionsSize++;
    }
    modal_names_map modalExtras = prover->prepareSAT(clauses, extra);
    for (auto modalSubtrie : subtrieMap) {
        modalSubtrie.second->prepareSAT(modalExtras[modalSubtrie.first]);
    }
}

shared_ptr<Bitset> TrieformProverK5::fleshedOutAssumptionBitset(
    literal_set model) {
    shared_ptr<Bitset> bitset =
        shared_ptr<Bitset>(new Bitset(2 * assumptionsSize));
    for (auto x : idMap) {
        Literal lit = Literal{x.first, 0};
        bitset->set(2 * x.second + (model.find(lit) == model.end()));
    }
    return bitset;
}

Solution TrieformProverK5::prove(int depth, literal_set assumptions) {
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
    assumptionsBitset =
        convertAssumptionsToBitset(assumptions);

    memoResult =
        localMemo.getFromMemo(assumptionsBitset);

    if (memoResult.inSatMemo) {
        // if (memoResult.result.satisfiable) {

        //   cout << "MEMOSAT" << endl;
        // } else {
        //   cout << "MEMOUNSAT" << endl;
        // }
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
    
    assert (pastModels.empty() || pastModels[pastModels.size() - 1].first < depth);
    pastModels.push_back({depth, currentModel});
    for (auto modalityDiamonds : triggeredDiamonds) {
        // Handle each modality
        if (modalityDiamonds.second.size() == 0) {
            // If there are no triggered diamonds of a certain modality we can
            // skip it
            continue;
        }

        Solution childSolution;

        bool loop = subtrieMap.find(modalityDiamonds.first) == subtrieMap.end();
        // loop = (modality.size() > 1 &&
        //   modality[modality.size() - 1] == modalityDiamonds.first &&
        //   modality[modality.size() - 1] == modality[modality.size() - 2])
        TrieformProverK5 *childNode =
            loop ? this
                 : dynamic_cast<TrieformProverK5 *>(
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
                    goto restart;
                    //return prove(depth, assumptions);
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
            prover->addClause(learnClause);
            restartUntil =
                checkClauseAgainstPastModels(restartUntil, learnClause);
        }
        assert (restartUntil <= depth);

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
    // cout << "Just SAT" << endl;
    // If we reached here the solution is satisfiable under all modalities

    if (probationMemo.minimalRoot == -1) {
        // cout << "Depth :" << depth << " " << "Going straight to actual cache"
        // << endl; for (auto x : assumptions) cout << x.toString() << " "; cout
        // << endl;
        updateSolutionMemo(assumptionsBitset, solution);
    } else if (depth == probationMemo.minimalRoot) {
        // Move probation cache to actual cache
        for (auto x : probationMemo.getSatSols()) {
            auto trieform =
                dynamic_cast<TrieformProverK5 *>(all_trieforms[*x.first].get());
            trieform->localMemo.insertSat(x.second);
        }
        probationMemo.setState({-1, 0});
    } else if (depth > probationMemo.minimalRoot) {
        probationMemo.insertSat(make_shared<vector<int>>(modality),
                                assumptionsBitset);
    }
    return solution;
}

unsigned int TrieformProverK5::checkClauseAgainstPastModels(
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
