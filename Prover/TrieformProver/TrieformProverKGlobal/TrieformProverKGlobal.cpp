#include "TrieformProverKGlobal.h"

 unordered_map<literal_set, literal_set, LiteralSetHash, LiteralSetEqual> TrieformProverKGlobal::modelCache;
 unordered_map<literal_set, int, LiteralSetHash, LiteralSetEqual> TrieformProverKGlobal::vertexLabel;

shared_ptr<Cache> TrieformProverKGlobal::persistentCache =
    make_shared<PrefixCache>("P");

map<vector<int>, shared_ptr<Trieform>> TrieformProverKGlobal::all_trieforms;
ProbationSolutionMemo TrieformProverKGlobal::probationMemo;
int TrieformProverKGlobal::restartUntil = -1;

shared_ptr<Trieform> TrieformFactory::makeTrieKGlobal(
    const shared_ptr<Formula> &formula, shared_ptr<Trieform> trieParent) {
    shared_ptr<Trieform> trie =
        shared_ptr<Trieform>(new TrieformProverKGlobal());
    trie->initialise(formula, trieParent);
    return trie;
}
shared_ptr<Trieform> TrieformFactory::makeTrieKGlobal(
    const shared_ptr<Formula> &formula, const vector<int> &newModality,
    shared_ptr<Trieform> trieParent) {
    shared_ptr<Trieform> trie =
        shared_ptr<Trieform>(new TrieformProverKGlobal());
    trie->initialise(formula, newModality, trieParent);
    return trie;
}
shared_ptr<Trieform> TrieformFactory::makeTrieKGlobal(
    const vector<int> &newModality, shared_ptr<Trieform> trieParent) {
    shared_ptr<Trieform> trie =
        shared_ptr<Trieform>(new TrieformProverKGlobal());
    trie->initialise(newModality, trieParent);
    return trie;
}

TrieformProverKGlobal::TrieformProverKGlobal() {}
TrieformProverKGlobal::~TrieformProverKGlobal() {}

shared_ptr<Trieform> TrieformProverKGlobal::create(
    const shared_ptr<Formula> &formula) {
    return TrieformFactory::makeTrieKGlobal(formula, shared_from_this());
}
shared_ptr<Trieform> TrieformProverKGlobal::create(
    const shared_ptr<Formula> &formula, const vector<int> &newModality) {
    return TrieformFactory::makeTrieKGlobal(formula, newModality,
                                            shared_from_this());
}
shared_ptr<Trieform> TrieformProverKGlobal::create(
    const vector<int> &newModality) {
    shared_ptr<Trieform> test = shared_from_this();
    return TrieformFactory::makeTrieKGlobal(newModality, shared_from_this());
}

shared_ptr<Bitset> TrieformProverKGlobal::convertAssumptionsToBitset(
    literal_set literals) {
    shared_ptr<Bitset> bitset =
        shared_ptr<Bitset>(new Bitset(2 * assumptionsSize));
    for (Literal literal : literals) {
        bitset->set(2 * idMap[literal.getName()] + literal.getPolarity());
    }
    return bitset;
}

void TrieformProverKGlobal::updateSolutionMemo(
    const shared_ptr<Bitset> &assumptions, Solution solution) {
    if (solution.satisfiable) {
        localMemo.insertSat(assumptions);
    } else {
        localMemo.insertUnsat(assumptions, solution.conflict);
    }
}

void TrieformProverKGlobal::preprocess() {
    all_trieforms[modality] = shared_from_this();
    for (auto modalSubtrie : subtrieMap) {
        modalSubtrie.second->preprocess();
    }
}

void TrieformProverKGlobal::prepareSAT(name_set extra) {
    for (string name : extra) {
        idMap[name] = assumptionsSize++;
    }
    modal_names_map modalExtras = prover->prepareSAT(clauses, extra);
    name_set everything;
    for (auto x : modalExtras) {
        everything.insert(x.second.begin(), x.second.end());
    }
    for (auto modalSubtrie : subtrieMap) {
        modalSubtrie.second->prepareSAT(everything);//modalExtras[modalSubtrie.first]);
    }
}


/*
void TrieformProverKGlobal::prepareSAT(name_set extra) {
    vector<shared_ptr<Trieform>> sorted = getTopSort();
    for (auto trieform : sorted) {
        name_set incoming;
        if (!trieform->modality.empty()) {
            for (auto parent : trieform->parents) {      
                // print savedModalExtras, modality.back()

                name_set parentModalExtras = parent->savedModalExtras[trieform->modality.back()];
                incoming.insert(parentModalExtras.begin(),
                                parentModalExtras.end());
            }
        }  else {
            incoming.insert(extra.begin(), extra.end());
        }
        for (string name : incoming) {
            dynamic_cast<TrieformProverKGlobal *>(trieform.get())->idMap[name] = 
                dynamic_cast<TrieformProverKGlobal *>(trieform.get())->assumptionsSize++;
        }
        trieform->savedModalExtras = trieform->getProver()->prepareSAT(trieform->clauses, incoming);
    }

    // run dfs
    
}
*/

shared_ptr<Bitset> TrieformProverKGlobal::fleshedOutAssumptionBitset(
    literal_set model) {
    shared_ptr<Bitset> bitset =
        shared_ptr<Bitset>(new Bitset(2 * assumptionsSize));
    for (auto x : idMap) {
        Literal lit = Literal{x.first, 0};
        bitset->set(2 * x.second + (model.find(lit) == model.end()));
    }
    return bitset;
}

int TrieformProverKGlobal::isInHistory(
    vector<pair<int, shared_ptr<Bitset>>> history, shared_ptr<Bitset> bitset) {
    for (unsigned i = history.size(); i-- > 0;) {
        if (history[i].second->contains(*bitset)) {return history[i].first;}
    }
    return -1;
}


Solution TrieformProverKGlobal::prove(literal_set assumptions) {
    return prove(0, assumptions).first;
}

pair<Solution, int> TrieformProverKGlobal::prove(int depth, literal_set assumptions) {
    /*
    if (vertexLabel.find(assumptions) == vertexLabel.end()) {
        vertexLabel[assumptions] = vertexLabel.size() + 1;
    }
    */

    if (assumptions.find(Literal("$root", true)) != assumptions.end()) {
        literal_set newAssumptions = assumptions;
        newAssumptions.erase(Literal("$root", true));
        auto x =  prove(depth, newAssumptions);
        if (!x.first.satisfiable) {
            return x;
        }
    }
    occ[assumptions]++;
    ProbationSolutionMemoState probationState;
    shared_ptr<Bitset> assumptionsBitset;
    shared_ptr<Bitset> fullAssumptionsBitset;
    LocalSolutionMemoResult memoResult;
    Solution solution;
    literal_set currentModel;
    modal_literal_map triggeredDiamonds;
    modal_literal_map triggeredBoxes;
    ProbationSolutionMemoResult probationMemoResult;
    int usedMinimalRoot;


    // Check solution memo
    assumptionsBitset =
        convertAssumptionsToBitset(assumptions);
    memoResult =
        localMemo.getFromMemo(assumptionsBitset);

    if (memoResult.inSatMemo) {
        return {memoResult.result, depth};
    }

    probationMemoResult = probationMemo.getFromMemo(
        make_shared<vector<int>>(modality), assumptionsBitset);

    if (probationMemoResult.inSatMemo) {
        //cout << "Depth :" << depth << " " << "sat from probation: " <<
        //probationMemo.minimalRoot << endl;
        return {probationMemoResult.result, probationMemo.minimalRoot};
    }
    int inHistory = isInHistory(history, assumptionsBitset);
    if (inHistory != -1) {
        //cout << depth << " SAT FROM HISTORY: " << inHistory << endl;
        probationMemo.updateMinimalRoot(inHistory);
        return {{true, literal_set()}, inHistory};
    }
    if (occ.find(assumptions) != occ.end()) {
        //cout << litsetString(assumptions) << endl;
        //cout << "DEPTH: " << depth << " SEEN: "<< occ[assumptions] << endl;
    }
    
    restart:
    usedMinimalRoot = depth;
    probationState = probationMemo.getState();
    // Solve locally

    if (false && modelCache.find(assumptions) != modelCache.end()) {
        //cout << "DEPTH: " << depth << " USING PREVIOUS" << endl ;
    currentModel = modelCache[assumptions];
    } else {
    solution = prover->solveReduced(assumptions);
    //solution = prover->solve(assumptions);
    //cout << endl;

    if (!solution.satisfiable) {
        //prover->reduce_conflict(solution.conflict);
        probationMemo.setState(probationState);
        updateSolutionMemo(assumptionsBitset, solution);
        return {solution, depth};
    }
    //cout << "IS SAT" << endl;

    currentModel = prover->getModel();
    //modelCache[assumptions] = currentModel;
    }
    assumptionsBitset = fleshedOutAssumptionBitset(currentModel);

    prover->calculateTriggeredDiamondsClauses(currentModel);
    triggeredDiamonds = prover->getTriggeredDiamondClauses();
    prover->calculateTriggeredBoxClauses(currentModel);
    triggeredBoxes = prover->getTriggeredBoxClauses();
    
    pastModels.push_back({depth, currentModel});


    //probationMemo.updateMinimalRoot(depth);
    //probationMemo.insertSat(make_shared<vector<int>>(modality), assumptionsBitset);

    for (auto modalityDiamonds : triggeredDiamonds) {
        // Handle each modality
        if (modalityDiamonds.second.size() == 0) {
            // If there are no triggered diamonds of a certain modality we can
            // skip it
            continue;
        }
    
        Solution childSolution;

        TrieformProverKGlobal *childNode =
            (subtrieMap.find(modalityDiamonds.first) == subtrieMap.end())
                ? this
                : dynamic_cast<TrieformProverKGlobal *>(
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
        
            // We do not want to run into this again (bit of a hack)
            prover->updateLastFail(diamond);
            //prover->addToFail(diamond, 1);

            literal_set childAssumptions =
                literal_set(triggeredBoxes[modalityDiamonds.first]);
            childAssumptions.insert(diamond);

            /*
        if (vertexLabel.find(childAssumptions) == vertexLabel.end()) {
            vertexLabel[childAssumptions] = vertexLabel.size() + 1;
        }
        */
        //cout << vertexLabel[assumptions] << " -> " << vertexLabel[childAssumptions] << endl;


            // Run the solver for the next level
            history.push_back({depth, assumptionsBitset});
            //cout << "-" << endl;
            //cout << litsetString(assumptions) << endl;
            //cout << "SPAWNING: " << diamond.toString() << " -> " <<  litsetString(childAssumptions) << endl;
            //cout << "CHILD: " << diamondPriority.size() + 1 << endl;
            auto result =childNode->prove(depth + 1, childAssumptions); 
            childSolution = result.first;
            usedMinimalRoot = min(usedMinimalRoot, result.second);
            //cout << depth << ": NEW USED: " << usedMinimalRoot << endl;

            history.pop_back();

            // Clause propagation
            /*
            for (literal_set learnClause : prover->getClauses(
                     modalityDiamonds.first,
                     prover->negatedClauses(childNode->allConflicts))) {
                //cout << "CLAUSE PROP" << endl;
                //allConflicts.push_back(learnClause);
                //prover->addClause(learnClause);

                //restartUntil =
                   // checkClauseAgainstPastModels(restartUntil, learnClause);
            }
            childNode->allConflicts.clear();

            if (restartUntil != -1) {
                pastModels.pop_back();
                probationMemo.setState(probationState);
                if (restartUntil == depth) {
                    // restart current node
                    restartUntil = -1;
                    modelCache.erase(assumptions);
                    goto restart;
                } else {
                    // Keep backtracking until we should restart
                    return childSolution;
                }
            }
            */

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
            //prover->updateLastFail(diamond);
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

        if (restartUntil != -1) {
            pastModels.pop_back();
            probationMemo.setState(probationState);
            if (restartUntil == depth) {
                // restart current node
                //cout << "RESTART UNTI HERE" << endl;
                //cout << "RESTART" << endl;
                restartUntil = -1;
                modelCache.erase(assumptions);
                goto restart;
                //return prove(depth, assumptions);
            } else {
                // Keep backtracking until we should restart
                //cout << "RESTART UNTIL" << endl;
                return {childSolution, 0};
            }
        }
    }
    pastModels.pop_back();
    //cout << "RETURNING SAT: " << depth << " " << usedMinimalRoot << endl;

    // If we reached here the solution is satisfiable under all modalities
    if (probationMemo.minimalRoot == -1) {
        //cout << "NORMAL" << endl;
        updateSolutionMemo(assumptionsBitset, solution);
    } else if (depth == probationMemo.minimalRoot) {
        //cout << "ALL PROBATION" << endl;
        // Move probation cache to actual cache
        for (auto x : probationMemo.getSatSols()) {
            auto trieform = dynamic_cast<TrieformProverKGlobal *>(
                all_trieforms[*x.first].get());
            trieform->localMemo.insertSat(x.second);
            //modelCache.erase(*x.second.second);
        }
        probationMemo.setState({-1, 0});
    } else if (depth == usedMinimalRoot) {
        //cout << "ADDING TO ENCLOSED CACHE" << endl;
        // Move part of the probation cache to the actual cache
        auto toAdd = probationMemo.getSatSols();
        for (auto i = probationState.second; i < toAdd.size(); i++){
            auto trieform = dynamic_cast<TrieformProverKGlobal *>(
                all_trieforms[*toAdd[i].first].get());
            trieform->localMemo.insertSat(toAdd[i].second);
        } 
        probationMemo.setState(probationState);
        localMemo.insertSat(assumptionsBitset);
    }else if (depth > probationMemo.minimalRoot) {
        //cout << "ADDING TO PROBATION: " << probationMemo.minimalRoot << endl;
        //cout << "ADD: " << litsetString(assumptions) << " " << litsetString(currentModel) << endl;
        probationMemo.insertSat(make_shared<vector<int>>(modality),
                                assumptionsBitset);
        //probationMemo.addPastModel(make_shared<literal_set> (currentModel));
    }
    return {solution, usedMinimalRoot};
}

unsigned int TrieformProverKGlobal::checkClauseAgainstPastModels(
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

/******************************************************************************
 *                                                                            *
 *                               GLOBAL REDUCTIONS                            *
 *                                                                            *
 * ***************************************************************************/

void TrieformProverKGlobal::globallyAddClauses(const FormulaTriple &otherClauses) {
    clauses.extendClauses(otherClauses);
    for (auto modalSubtrie : subtrieMap) {
        dynamic_cast<TrieformProverKGlobal *>(modalSubtrie.second.get())
            ->globallyAddClauses(otherClauses);
    }
}

shared_ptr<modal_clause_set> TrieformProverKGlobal::getAllBoxClauses5() {
    shared_ptr<modal_clause_set> res = make_shared<modal_clause_set>();
    res->insert(clauses.getBoxClauses().begin(), clauses.getBoxClauses().end());
    for (auto modalitySubtrie : subtrieMap) {
        shared_ptr<modal_clause_set> other =
            (dynamic_cast<TrieformProverKGlobal *>(modalitySubtrie.second.get()))
                ->getAllBoxClauses5();
        res->insert(other->begin(), other->end());
    }
    return res;
}

void TrieformProverKGlobal::modalContextsT() {
    for (auto modalSubtrie : subtrieMap) {
        dynamic_cast<TrieformProverKGlobal *>(modalSubtrie.second.get())
            ->modalContextsT();
        overShadow(modalSubtrie.second, modalSubtrie.first);
    }
}
void TrieformProverKGlobal::globalReduction5() {
    // From local is best

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

    // Make everything global
    modalContextsT();
    forwardProp();
    /*
    shared_ptr<FormulaTriple> nft = shared_ptr<FormulaTriple> (new FormulaTriple());
    getAllClauses(nft);
    globallyAddClauses(*nft.get());
    */

}

void TrieformProverKGlobal::globalReduction4() {
    persistentBoxes4();
    propagateLevels4();
}

void TrieformProverKGlobal::persistentBoxes4() {
    for (auto modalSubtrie : subtrieMap) {
        dynamic_cast<TrieformProverKGlobal *>(modalSubtrie.second.get())
            ->persistentBoxes4();
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

    /*
  for (ModalClause persistentBox : persistentBoxes) {
    subtrieMap[persistentBox.modality]->clauses.addBoxClause(persistentBox);
  }
  */
}

void TrieformProverKGlobal::propagateLevels4() {
    for (auto modalSubtrie : subtrieMap) {
        modalSubtrie.second->overShadow(shared_from_this(), modalSubtrie.first);
        dynamic_cast<TrieformProverKGlobal *>(modalSubtrie.second.get())
            ->propagateLevels4();
    }
}

void TrieformProverKGlobal::forwardProp() {
    for (auto modalSubtrie : subtrieMap) {
        modalSubtrie.second->clauses.extendClauses(clauses);
        dynamic_cast<TrieformProverKGlobal *>(modalSubtrie.second.get())->forwardProp();
    }
}

void TrieformProverKGlobal::addGlobalAssumptions(shared_ptr<Trieform> globalAssumptions) {
    for (auto modalSubtrie : subtrieMap) {
        dynamic_cast<TrieformProverKGlobal *>(modalSubtrie.second.get())
            ->addGlobalAssumptions(globalAssumptions);
    }
    //overShadow(globalAssumptions, 0);
    compose(globalAssumptions, 0, false);
}


void TrieformProverKGlobal::cutReflexiveLeaves(shared_ptr<Trieform> globalAssumptions) {
    // Leaves are handled as reflexive in the proof procedure, so delete cyclic
    // references here
    vector<int> toRemove;
    for (auto modalSubtrie : subtrieMap) {
        // check if successor == this
        if (modalSubtrie.second == shared_from_this()) {
            toRemove.push_back(modalSubtrie.first);
        } else {
        dynamic_cast<TrieformProverKGlobal *>(modalSubtrie.second.get())
            ->cutReflexiveLeaves(globalAssumptions);
        }
    }
    for (auto x : toRemove) {
        subtrieMap.erase(x);
    }
}
