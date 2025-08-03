#include "TrieformProverKB.h"

shared_ptr<Trieform> TrieformFactory::makeTrieKB(
    const shared_ptr<Formula> &formula, shared_ptr<Trieform> trieParent) {
    shared_ptr<Trieform> trie = shared_ptr<Trieform>(new TrieformProverKB());
    trie->initialise(formula, trieParent);
    return trie;
}
shared_ptr<Trieform> TrieformFactory::makeTrieKB(
    const shared_ptr<Formula> &formula, const vector<int> &newModality,
    shared_ptr<Trieform> trieParent) {
    shared_ptr<Trieform> trie = shared_ptr<Trieform>(new TrieformProverKB());
    trie->initialise(formula, newModality, trieParent);
    return trie;
}
shared_ptr<Trieform> TrieformFactory::makeTrieKB(
    const vector<int> &newModality, shared_ptr<Trieform> trieParent) {
    shared_ptr<Trieform> trie = shared_ptr<Trieform>(new TrieformProverKB());
    trie->initialise(newModality, trieParent);
    return trie;
}

TrieformProverKB::TrieformProverKB() {}
TrieformProverKB::~TrieformProverKB() {}

shared_ptr<Trieform> TrieformProverKB::create(
    const shared_ptr<Formula> &formula) {
    return TrieformFactory::makeTrieKB(formula, shared_from_this());
}
shared_ptr<Trieform> TrieformProverKB::create(
    const shared_ptr<Formula> &formula, const vector<int> &newModality) {
    return TrieformFactory::makeTrieKB(formula, newModality,
                                       shared_from_this());
}
shared_ptr<Trieform> TrieformProverKB::create(const vector<int> &newModality) {
    shared_ptr<Trieform> test = shared_from_this();
    return TrieformFactory::makeTrieKB(newModality, shared_from_this());
}

shared_ptr<Bitset> TrieformProverKB::convertAssumptionsToBitset(
    literal_set literals) {
    shared_ptr<Bitset> bitset =
        shared_ptr<Bitset>(new Bitset(2 * assumptionsSize));
    for (Literal literal : literals) {
        bitset->set(2 * idMap[literal.getName()] + literal.getPolarity());
    }
    return bitset;
}

void TrieformProverKB::updateSolutionMemo(const shared_ptr<Bitset> &assumptions,
                                          Solution solution) {
    if (solution.satisfiable) {
        localMemo.insertSat(assumptions);
    } else {
        localMemo.insertUnsat(assumptions, solution.conflict);
    }
}

void TrieformProverKB::prepareSAT(name_set extra) {
    for (string name : extra) {
        idMap[name] = assumptionsSize++;
    }

    /*
    for (auto modalSubtrie : subtrieMap) {
        for (ModalClause clause :
             modalSubtrie.second->getClauses().getDiamondClauses()) {
            if (clause.modality == modalSubtrie.first) {
                // Only relevant when the modalities are equal
                extra.insert(prover->getPrimitiveName(clause.right));
            }
        }
    }
    */

    modal_names_map modalExtras = prover->prepareSAT(clauses, extra);
    for (auto modalSubtrie : subtrieMap) {
        modalSubtrie.second->prepareSAT(modalExtras[modalSubtrie.first]);
    }
}

shared_ptr<Bitset> TrieformProverKB::fleshedOutAssumptionBitset(
    literal_set model) {
    shared_ptr<Bitset> bitset =
        shared_ptr<Bitset>(new Bitset(2 * assumptionsSize));
    for (auto x : idMap) {
        Literal lit = Literal{x.first, 0};
        bitset->set(2 * x.second + (model.find(lit) == model.end()));
    }
    return bitset;
}

Solution TrieformProverKB::prove(literal_set assumptions) {
    return prove(0, assumptions);
}

Solution TrieformProverKB::prove(int depth, literal_set assumptions) {
    // Check solution memo

    shared_ptr<Bitset> assumptionsBitset;
    shared_ptr<Bitset> fullAssumptionsBitset;
    LocalSolutionMemoResult memoResult;
    Solution solution;
    literal_set currentModel;
    modal_literal_map triggeredDiamonds;
    modal_literal_map triggeredBoxes;

    assumptionsBitset =
        convertAssumptionsToBitset(assumptions);
    memoResult =
        localMemo.getFromMemo(assumptionsBitset);

    if (memoResult.inSatMemo) {
        return memoResult.result;
    }

    // Solve locally
    restart:
    solution = prover->solve(assumptions);

    if (!solution.satisfiable) {
        // prover->reduce_conflict(solution.conflict);
        updateSolutionMemo(assumptionsBitset, solution);
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
        TrieformProverKB *childNode =
            dynamic_cast<TrieformProverKB *>(modalitySubtrie.second.get());

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

            if (modality.size() > 0 &&
                modality[modality.size() - 1] == modalitySubtrie.first &&
                parentSatisfiesAssump(diamond)) {
                continue;
            }

            literal_set childAssumptions =
                literal_set(triggeredBoxes[modalitySubtrie.first]);
            childAssumptions.insert(diamond);

            // Run the solver for the next level
            childSolution = childNode->prove(depth + 1, childAssumptions);

            // Clause propagation
            bool shouldRestart = false;

            /*
            for (literal_set learnClause :
            prover->getClauses(modalitySubtrie.first,
            prover->negatedClauses(prover->filterPropagatedConflicts(childNode->allConflicts))))
            { cout << "DEPTH: " << depth << "BONUS CLAUSE: " << endl; for (auto
            x : learnClause) cout << x.toString() << " "; cout << endl;
                allConflicts.push_back(learnClause);
                prover->addClause(learnClause);
            }
            */
            // cout << "FINISHED LEARNING BONUS CLAUSES: " << shouldRestart <<
            // endl; cout << "MODEL: "; for (auto x : currentModel) cout <<
            // x.toString() << " "; cout << endl;
            // childNode->allConflicts.clear();

            // If it is satisfiable create the next world
            if (childSolution.satisfiable) {
                // Don't check any more if we only required one
                if (isSubsetOf(triggeredDiamonds[modalitySubtrie.first],
                               triggeredBoxes[modalitySubtrie.first]))
                    break;
                else
                    continue;
            }
            diamondFailed = true;
            break;
        }

        if (!diamondFailed) continue;

        for (literal_set learnClause : prover->getClauses(
                 modalitySubtrie.first, childSolution.conflict)) {
            // allConflicts.push_back(learnClause);

            // Add clause to current node (i) and i-2, i-4, etc...
            int i = modality.size() - 1;
            auto cur = this;
            cur->prover->addClause(learnClause);
            while ((i - 1 >= 0) && (modality[i] == modality[i - 1])) {
                cur = dynamic_cast<TrieformProverKB *>(
                    cur->getParent()->getParent().get());
                i -= 2;
                cur->prover->addClause(learnClause);
            }
        }
        goto restart;
        //return prove(depth, assumptions);
    }
    // If we reached here the solution is satisfiable under all modalities
    assumptionsBitset = fleshedOutAssumptionBitset(currentModel);
    updateSolutionMemo(assumptionsBitset, solution);
    return solution;
}

/******************************************************************************
 *                                                                            *
 *                                 PREPROCESSING                              *
 *                                                                            *
 * ***************************************************************************/

void TrieformProverKB::preprocess() {
    propagateSymmetry();
    propagateSymmetricBoxes();
}

void TrieformProverKB::propagateSymmetry() {
    for (auto modalitySubtrie : subtrieMap) {
        dynamic_cast<TrieformProverKB *>(modalitySubtrie.second.get())
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

void TrieformProverKB::propagateSymmetricBoxes() {
    for (auto modalitySubtrie : subtrieMap) {
        dynamic_cast<TrieformProverKB *>(modalitySubtrie.second.get())
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

