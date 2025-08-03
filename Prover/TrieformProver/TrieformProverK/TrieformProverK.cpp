#include "TrieformProverK.h"

shared_ptr<Cache> TrieformProverK::persistentCache =
    make_shared<PrefixCache>("P");

shared_ptr<Trieform> TrieformFactory::makeTrieK(
    const shared_ptr<Formula> &formula, shared_ptr<Trieform> trieParent) {
    shared_ptr<Trieform> trie = shared_ptr<Trieform>(new TrieformProverK());
    trie->initialise(formula, trieParent);
    return trie;
}
shared_ptr<Trieform> TrieformFactory::makeTrieK(
    const shared_ptr<Formula> &formula, const vector<int> &newModality,
    shared_ptr<Trieform> trieParent) {
    shared_ptr<Trieform> trie = shared_ptr<Trieform>(new TrieformProverK());
    trie->initialise(formula, newModality, trieParent);
    return trie;
}
shared_ptr<Trieform> TrieformFactory::makeTrieK(
    const vector<int> &newModality, shared_ptr<Trieform> trieParent) {
    shared_ptr<Trieform> trie = shared_ptr<Trieform>(new TrieformProverK());
    trie->initialise(newModality, trieParent);
    return trie;
}

TrieformProverK::TrieformProverK() {}
TrieformProverK::~TrieformProverK() {}

shared_ptr<Trieform> TrieformProverK::create(
    const shared_ptr<Formula> &formula) {
    return TrieformFactory::makeTrieK(formula, shared_from_this());
}
shared_ptr<Trieform> TrieformProverK::create(const shared_ptr<Formula> &formula,
                                             const vector<int> &newModality) {
    return TrieformFactory::makeTrieK(formula, newModality, shared_from_this());
}
shared_ptr<Trieform> TrieformProverK::create(const vector<int> &newModality) {
    shared_ptr<Trieform> test = shared_from_this();
    return TrieformFactory::makeTrieK(newModality, shared_from_this());
}

shared_ptr<Bitset> TrieformProverK::convertAssumptionsToBitset(
    literal_set literals) {
    shared_ptr<Bitset> bitset =
        shared_ptr<Bitset>(new Bitset(2 * assumptionsSize));
    for (Literal literal : literals) {
        bitset->set(2 * idMap[literal.getName()] + literal.getPolarity());
    }
    return bitset;
}

void TrieformProverK::updateSolutionMemo(const literal_set &assumptions, const shared_ptr<Bitset> &assumptionsBitset,
                                         Solution solution) {
    if (solution.satisfiable) {
        (isExact) ? exactMemo.insertSat(assumptions) : localMemo.insertSat(assumptionsBitset);
    } /*else {
        localMemo.insertUnsat(assumptions, solution.conflict);
    }*/
}

void TrieformProverK::preprocess() {}

void TrieformProverK::prepareSAT(name_set extra) {
    for (string name : extra) {
        idMap[name] = assumptionsSize++;
    }
    modal_names_map modalExtras = prover->prepareSAT(clauses, extra);
    for (auto modalSubtrie : subtrieMap) {
        modalSubtrie.second->prepareSAT(modalExtras[modalSubtrie.first]);
    }
}

shared_ptr<Bitset> TrieformProverK::fleshedOutAssumptionBitset(
    literal_set model) {
    shared_ptr<Bitset> bitset =
        shared_ptr<Bitset>(new Bitset(2 * assumptionsSize));
    for (auto x : idMap) {
        Literal lit = Literal{x.first, 0};
        bitset->set(2 * x.second + (model.find(lit) == model.end()));
    }
    return bitset;
}

Solution TrieformProverK::prove(literal_set assumptions) {
    return prove(0, assumptions);
}

Solution TrieformProverK::prove(int depth, literal_set assumptions) {
    // Check solution memo
    shared_ptr<Bitset> assumptionsBitset;
    shared_ptr<Bitset> fullAssumptionsBitset;
    LocalSolutionMemoResult memoResult;
    Solution solution;
    literal_set currentModel;
    modal_literal_map triggeredDiamonds;
    modal_literal_map triggeredBoxes;

    

    assumptionsBitset = isExact ? nullptr : convertAssumptionsToBitset(assumptions);

    memoResult =
        isExact ? exactMemo.getFromMemo(assumptions) : localMemo.getFromMemo(assumptionsBitset);

    if (memoResult.inSatMemo) {
        return memoResult.result;
    }
    
    restart:

    // Solve locally
    solution = prover->solve(assumptions);

    if (!solution.satisfiable) {
        // prover->reduce_conflict(solution.conflict);
        updateSolutionMemo(assumptions, assumptionsBitset, solution);
        return solution;
    }
    
    currentModel = prover->getModel();
    

    prover->calculateTriggeredDiamondsClauses();
    triggeredDiamonds = prover->getTriggeredDiamondClauses();
    prover->calculateTriggeredBoxClauses();
    triggeredBoxes = prover->getTriggeredBoxClauses();

    for (auto modalitySubtrie : subtrieMap) {
        // Handle each modality
        if (triggeredDiamonds[modalitySubtrie.first].size() == 0) {
            // If there are no triggered diamonds of a certain modality we can
            // skip it
            continue;
        }

        Solution childSolution;
        TrieformProverK *childNode =
            dynamic_cast<TrieformProverK *>(modalitySubtrie.second.get());

        // The fired diamonds are not a subset of the fired boxes, we need to
        // create one world for each diamond clause
        bool diamondFailed = false;

        diamond_queue diamondPriority = prover->getPrioritisedTriggeredDiamonds(
            modalitySubtrie.first, triggeredBoxes[modalitySubtrie.first],
            triggeredDiamonds[modalitySubtrie.first]);

        while (!diamondPriority.empty()) {
            // Create a world for each diamond
            Literal diamond = diamondPriority.top().literal;
            diamondPriority.pop();

            literal_set childAssumptions =
                literal_set(triggeredBoxes[modalitySubtrie.first]);
            childAssumptions.insert(diamond);

            // Run the solver for the next level
            childSolution = childNode->prove(depth + 1, childAssumptions);

            // Clause propagation
            bool shouldRestart = false;
            for (literal_set learnClause :
            prover->getClauses(modalitySubtrie.first,
            prover->negatedClauses(childNode->allConflicts))) {//prover->filterPropagatedConflicts(childNode->allConflicts)))) { 
                //cout << "CLAUSE PROP" << endl;
                //allConflicts.push_back(learnClause);
                //prover->addClause(learnClause);
            }
            childNode->allConflicts.clear();

            if (shouldRestart) {
                return prove(assumptions);
            }

            // If it is satisfiable create the next world
            if (childSolution.satisfiable) {
                // Don't check any more if we only required one
                if (isSubsetOf(triggeredDiamonds[modalitySubtrie.first],
                               triggeredBoxes[modalitySubtrie.first]))
                    break;
                else
                    continue;
            }
            //prover->updateLastFail(diamond);
            diamondFailed = true;
            break;
        }

        if (!diamondFailed) continue;

        for (literal_set learnClause : prover->getClauses(
                 modalitySubtrie.first, childSolution.conflict)) {
            allConflicts.push_back(learnClause);
            //cout << "Learn: ";
            //for (auto x : learnClause) cout << x.toString() << " ";
            //cout << endl;
            prover->addClause(learnClause);
        }
        goto restart;
        //return prove(depth, assumptions);
    }
    
    // If we reached here the solution is satisfiable under all modalities
    if (!isExact) fullAssumptionsBitset = fleshedOutAssumptionBitset(currentModel);
    updateSolutionMemo(assumptions, fullAssumptionsBitset, solution);

    //cout << "Solve: " << depth << " = " << litsetString(assumptions) << endl;

    return solution;
}

bool TrieformProverK::clauseConflictsWithModel(literal_set clause,
                                               literal_set model) {
    bool contains = false;
    for (Literal x : clause) {
        if (model.find(x) != model.end()) {
            contains = true;
            break;
        }
    }
    if (contains) {
        return false;
    }
    return true;
}

/******************************************************************************
 *                                                                            *
 *                               LOCAL REDUCTIONS                             *
 *                                                                            *
 * ***************************************************************************/

void TrieformProverK::boxClausesT() {
    for (ModalClause modalClause : clauses.getBoxClauses()) {
        formula_set newOr;
        newOr.insert(Not::create(modalClause.left)->negatedNormalForm());
        newOr.insert(modalClause.right);
        clauses.addClause(Or::create(newOr));
    }
    for (auto modalSubtrie : subtrieMap) {
        dynamic_cast<TrieformProverK *>(modalSubtrie.second.get())
            ->boxClausesT();
    }
}

void TrieformProverK::modalContextsT() {
    for (auto modalSubtrie : subtrieMap) {
        dynamic_cast<TrieformProverK *>(modalSubtrie.second.get())
            ->modalContextsT();
        overShadow(modalSubtrie.second, modalSubtrie.first);
    }
}

void TrieformProverK::localReductionT() {
    boxClausesT();
    modalContextsT();
}

void TrieformProverK::localReductionD() {
    for (auto modalitySubtrie : subtrieMap) {
        propagateClauses(
            Diamond::create(modalitySubtrie.first, 1, True::create()));
        dynamic_cast<TrieformProverK *>(modalitySubtrie.second.get())
            ->localReductionD();
    }
}

shared_ptr<modal_clause_set> TrieformProverK::getAllBoxClauses5() {
    shared_ptr<modal_clause_set> res = make_shared<modal_clause_set>();
    res->insert(clauses.getBoxClauses().begin(), clauses.getBoxClauses().end());
    for (auto modalitySubtrie : subtrieMap) {
        shared_ptr<modal_clause_set> other =
            (dynamic_cast<TrieformProverK *>(modalitySubtrie.second.get()))
                ->getAllBoxClauses5();
        res->insert(other->begin(), other->end());
    }
    return res;
}


void TrieformProverK::getAllClauses(shared_ptr<FormulaTriple> formulaTriple) {

    formulaTriple->extendClauses(clauses);
    for (auto modalSubtrie : subtrieMap) {
        dynamic_cast<TrieformProverK *>(modalSubtrie.second.get())
            ->getAllClauses(formulaTriple);
    }
}


modal_clause_set TrieformProverK::presistentBoxes5() {
  modal_clause_set succPresistentBoxes;

  for (auto modalSubtrie : subtrieMap) {
    modal_clause_set boxes = dynamic_cast<TrieformProverK*>(modalSubtrie.second.get())
        ->presistentBoxes5();
    succPresistentBoxes.insert(boxes.begin(), boxes.end());
  }

  clauses.extendBoxClauses(succPresistentBoxes);

  modal_clause_set presistentBoxes;
  for (ModalClause boxClause : clauses.getBoxClauses()) {
    // For a=>[]b in our box clauses add 
    // ~a => [] ~a  (aka a => [-] a)

    // Make persistence
    presistentBoxes.insert({boxClause.modality, boxClause.left, boxClause.left});
  }
  return presistentBoxes;
}

modal_clause_set TrieformProverK::uniqueBoxLHS5() {
    modal_clause_set allBoxes;
    for (auto modalSubtrie : subtrieMap) {
        modal_clause_set newBoxes = dynamic_cast<TrieformProverK *>(modalSubtrie.second.get())
            ->uniqueBoxLHS5();
        allBoxes.insert(newBoxes.begin(), newBoxes.end());
    }

    modal_clause_set toReturn;

    for (ModalClause boxClause : clauses.getBoxClauses()) {
        // For a=>[]b in our box clauses replace with
        // a=>Ua
        // UA => [] b
        // 
        // And put ~UA => [] ~UA in all ancestors

        // Make persistence
        shared_ptr<Formula> lhs =
            persistentCache->getVariableOrCreate(boxClause.left);

        shared_ptr<Formula> negLhs = Not::create(lhs)->negatedNormalForm();

        toReturn.insert({boxClause.modality, negLhs, negLhs});
        allBoxes.insert({boxClause.modality, negLhs, negLhs});
        allBoxes.insert({boxClause.modality, lhs, boxClause.right});

        formula_set leftSet;
        leftSet.insert(Not::create(boxClause.left)->negatedNormalForm());
        leftSet.insert(lhs);
        clauses.addClause(Or::create(leftSet));
    }
    clauses.setBoxClauses(allBoxes);
    return toReturn;
}


modal_clause_set TrieformProverK::uniqueDiamondLHS5() {
    modal_clause_set allBoxes;
    for (auto modalSubtrie : subtrieMap) {
        modal_clause_set newBoxes = dynamic_cast<TrieformProverK *>(modalSubtrie.second.get())
            ->uniqueDiamondLHS5();
        allBoxes.insert(newBoxes.begin(), newBoxes.end());
    }

    modal_clause_set toReturn;
    modal_clause_set newDiamonds;

    for (ModalClause diamondClause : clauses.getDiamondClauses()) {
        // For a=><>b in our box clauses replace with
        // a=>Ua
        // UA => <> b
        // 
        // And put ~UA => [] ~UA in all ancestors

        // Make persistence
        shared_ptr<Formula> lhs =
            persistentCache->getVariableOrCreate(diamondClause.left);

        shared_ptr<Formula> negLhs = Not::create(lhs)->negatedNormalForm();

        toReturn.insert({diamondClause.modality, negLhs, negLhs});
        allBoxes.insert({diamondClause.modality, negLhs, negLhs});
        newDiamonds.insert({diamondClause.modality, lhs, diamondClause.right});

        formula_set leftSet;
        leftSet.insert(Not::create(diamondClause.left)->negatedNormalForm());
        leftSet.insert(lhs);
        clauses.addClause(Or::create(leftSet));
    }
    clauses.setDiamondClauses(newDiamonds);
    clauses.extendBoxClauses(allBoxes);
    return toReturn;
}

void TrieformProverK::localReduction5() {
    // Collect all box clauses
    uniqueBoxLHS5();
    uniqueDiamondLHS5();
    modalContextsT();
}

void TrieformProverK::globallyAddClauses(const FormulaTriple &otherClauses) {
    clauses.extendClauses(otherClauses);
    for (auto modalSubtrie : subtrieMap) {
        dynamic_cast<TrieformProverK *>(modalSubtrie.second.get())
            ->globallyAddClauses(otherClauses);
    }
}

void TrieformProverK::forwardProp() {
    for (auto modalSubtrie : subtrieMap) {
        modalSubtrie.second->clauses.extendClauses(clauses);
        dynamic_cast<TrieformProverK *>(modalSubtrie.second.get())->forwardProp();
    }
}
void TrieformProverK::localReductionB() {
    propagateSymmetry();
    propagateSymmetricBoxes();
}

void TrieformProverK::propagateSymmetry() {
    for (auto modalitySubtrie : subtrieMap) {
        dynamic_cast<TrieformProverK *>(modalitySubtrie.second.get())
            ->propagateSymmetry();
    }
    for (auto modalitySubtrie : subtrieMap) {
        if (modalitySubtrie.second->hasSubtrie(modalitySubtrie.first)) {
            shared_ptr<Trieform> future =
                modalitySubtrie.second->getSubtrie(modalitySubtrie.first);
            overShadow(future);
        }
    }
}

void TrieformProverK::propagateSymmetricBoxes() {
    //cout << "SYMMETRY?" << endl;
    for (auto modalitySubtrie : subtrieMap) {
        dynamic_cast<TrieformProverK *>(modalitySubtrie.second.get())
            ->propagateSymmetricBoxes();
    }
    for (auto modalitySubtrie : subtrieMap) {
        for (const ModalClause &boxClause :
             modalitySubtrie.second->getClauses().getBoxClauses()) {
            if (modalitySubtrie.first == boxClause.modality) {
                clauses.addBoxClause(boxClause.modality,
                                     boxClause.right->negate(),
                                     boxClause.left->negate());
            }
        }
    }
}

void TrieformProverK::localReduction4(FormulaDetails formulaDetails) {
    persistentBoxes4();
    propagateLevels4();

    int bound = 2 + formulaDetails.maxLevelDia +
                (formulaDetails.diffDia.size() * formulaDetails.diffBox.size());

    cout << "MAX LEVEL DIA: " << formulaDetails.maxLevelDia << endl;
    cout << "NUM DIF DIA: " << formulaDetails.diffDia.size() << endl;
    cout << "NUM DIF BOX: " << formulaDetails.diffBox.size() << endl;
    cout << "FINAL BOUND: " << bound << endl;
    // Subtract 1 as 0 is a world
    globalToLocal(bound - 1);
}

void TrieformProverK::persistentBoxes4() {
  for (auto modalSubtrie : subtrieMap) {
    dynamic_cast<TrieformProverK*>(modalSubtrie.second.get())
        ->persistentBoxes4();
  }

  modal_clause_set persistentBoxes;
  for (ModalClause boxClause : clauses.getBoxClauses()) {
    // For a=>[]b in our box clauses add 
    // a => [] a

    // Make persistence
    persistentBoxes.insert({boxClause.modality, boxClause.left, boxClause.left});
  }
  clauses.extendBoxClauses(persistentBoxes);

    /*
  for (ModalClause persistentBox : persistentBoxes) {
    subtrieMap[persistentBox.modality]->clauses.addBoxClause(persistentBox);
  }
  */
}

void TrieformProverK::propagateLevels4() {
    for (auto modalSubtrie : subtrieMap) {
        modalSubtrie.second->overShadow(shared_from_this(), modalSubtrie.first);
        dynamic_cast<TrieformProverK *>(modalSubtrie.second.get())
            ->propagateLevels4();
    }
}

void TrieformProverK::globalToLocal(int depth) {
    if (depth == 0) {
        clauses.eraseBoxClauses();
        clauses.eraseDiamondClauses();
    } else {
        for (ModalClause diaClause : clauses.getDiamondClauses()) {
            if (!hasSubtrie(diaClause.modality)) {
                getSubtrieOrEmpty(diaClause.modality);
                subtrieMap[diaClause.modality]->overShadow(shared_from_this(),
                                                           diaClause.modality);
            }
        }
        for (auto subtrie : subtrieMap) {
            dynamic_cast<TrieformProverK *>(subtrie.second.get())
                ->globalToLocal(depth - 1);
        }
    }
    // cout << clauses.getDiamondClauses().size() << endl;
    // cout << clauses.getBoxClauses().size() << endl;
}



void TrieformProverK::localReductionTense() {
  for (auto modalSubtrie : subtrieMap) {
    dynamic_cast<TrieformProverK *>(modalSubtrie.second.get())->localReductionTense();
    if (modalSubtrie.second->hasSubtrie(-modalSubtrie.first)) {
      shared_ptr<Trieform> future =
          modalSubtrie.second->getSubtrie(-modalSubtrie.first);
        compose(future);//, modalSubtrie.first);
    }

    for (ModalClause futureModalClause :
         modalSubtrie.second->getClauses().getBoxClauses()) {
      if (futureModalClause.modality == -modalSubtrie.first) {
        clauses.addBoxClause({modalSubtrie.first,
                              futureModalClause.right->negate(),
                              futureModalClause.left->negate()});
      }
    }
  }

}


