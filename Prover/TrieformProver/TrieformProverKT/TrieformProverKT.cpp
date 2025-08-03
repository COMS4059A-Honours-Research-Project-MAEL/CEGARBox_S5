#include "TrieformProverKT.h"

// unsigned int TrieformProverKT::assumptionsSize = 0;

// unordered_map<string, unsigned int> TrieformProverKT::idMap =
//     unordered_map<string, unsigned int>();

shared_ptr<Trieform> TrieformFactory::makeTrieKT(
    const shared_ptr<Formula> &formula, shared_ptr<Trieform> trieParent) {
    shared_ptr<Trieform> trie = shared_ptr<Trieform>(new TrieformProverKT());
    trie->initialise(formula, trieParent);
    return trie;
}
shared_ptr<Trieform> TrieformFactory::makeTrieKT(
    const shared_ptr<Formula> &formula, const vector<int> &newModality,
    shared_ptr<Trieform> trieParent) {
    shared_ptr<Trieform> trie = shared_ptr<Trieform>(new TrieformProverKT());
    trie->initialise(formula, newModality, trieParent);
    return trie;
}
shared_ptr<Trieform> TrieformFactory::makeTrieKT(
    const vector<int> &newModality, shared_ptr<Trieform> trieParent) {
    shared_ptr<Trieform> trie = shared_ptr<Trieform>(new TrieformProverKT());
    trie->initialise(newModality, trieParent);
    return trie;
}

TrieformProverKT::TrieformProverKT() {}
TrieformProverKT::~TrieformProverKT() {}

shared_ptr<Trieform> TrieformProverKT::create(
    const shared_ptr<Formula> &formula) {
    return TrieformFactory::makeTrieKT(formula, shared_from_this());
}
shared_ptr<Trieform> TrieformProverKT::create(
    const shared_ptr<Formula> &formula, const vector<int> &newModality) {
    return TrieformFactory::makeTrieKT(formula, newModality,
                                       shared_from_this());
}
shared_ptr<Trieform> TrieformProverKT::create(const vector<int> &newModality) {
    shared_ptr<Trieform> test = shared_from_this();
    return TrieformFactory::makeTrieKT(newModality, shared_from_this());
}

shared_ptr<Bitset> TrieformProverKT::convertAssumptionsToBitset(
    literal_set literals) {
    shared_ptr<Bitset> bitset =
        shared_ptr<Bitset>(new Bitset(2 * assumptionsSize));
    for (Literal literal : literals) {
        bitset->set(2 * idMap[literal.getName()] + literal.getPolarity());
    }
    return bitset;
}

void TrieformProverKT::updateSolutionMemo(const shared_ptr<Bitset> &assumptions,
                                          Solution solution) {
    if (solution.satisfiable) {
        localMemo.insertSat(assumptions);
    } else {
        localMemo.insertUnsat(assumptions, solution.conflict);
    }
}

bool TrieformProverKT::isInHistory(vector<shared_ptr<Bitset>> history,
                                   shared_ptr<Bitset> bitset) {
    for (shared_ptr<Bitset> assump : history) {
        if (assump->contains(*bitset)) {
            return true;
        }
    }
    return false;
}

void TrieformProverKT::prepareSAT(name_set extra) {
    for (string name : extra) {
        idMap[name] = assumptionsSize++;
    }
    modal_names_map modalExtras = prover->prepareSAT(clauses, extra);
    for (auto modalSubtrie : subtrieMap) {
        modalSubtrie.second->prepareSAT(modalExtras[modalSubtrie.first]);
    }
}

shared_ptr<Bitset> TrieformProverKT::fleshedOutAssumptionBitset(
    literal_set model) {
    shared_ptr<Bitset> bitset =
        shared_ptr<Bitset>(new Bitset(2 * assumptionsSize));
    for (auto x : idMap) {
        Literal lit = Literal{x.first, 0};
        bitset->set(2 * x.second + (model.find(lit) == model.end()));
    }
    return bitset;
}

Solution TrieformProverKT::prove(literal_set assumptions) {
    return prove(0, assumptions);
}

Solution TrieformProverKT::prove(int depth,
                                 literal_set assumptions) {
	shared_ptr<Bitset> assumptionsBitset;	
    shared_ptr<Bitset> fullAssumptionsBitset;	
    LocalSolutionMemoResult memoResult;	
    Solution solution;	
    literal_set currentModel;	
    modal_literal_map triggeredDiamonds;	
    modal_literal_map triggeredBoxes;


    // Check solution memo

    assumptionsBitset =
        convertAssumptionsToBitset(assumptions);
    memoResult =
        localMemo.getFromMemo(assumptionsBitset);

    // INVESTIGATE THIS
    if (memoResult.inSatMemo) {
        return memoResult.result;
    }

    restart:
    // Solve locally
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
        TrieformProverKT *childNode =
            dynamic_cast<TrieformProverKT *>(modalitySubtrie.second.get());

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

            // If the diamond is already satisfied by reflexivity no need to
            // create a successor.
            if (currentModel.find(diamond) != currentModel.end()) {
                continue;
            }

            literal_set childAssumptions =
                literal_set(triggeredBoxes[modalitySubtrie.first]);
            childAssumptions.insert(diamond);

            // Run the solver for the next level
            childSolution = childNode->prove(depth+1, childAssumptions);

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
            // Add clause to all parents

            prover->addClause(learnClause);

            // Add clause to i-1, i-2, ... etc
            auto cur = this;
            while (cur->getParent() != nullptr) {
                cur = dynamic_cast<TrieformProverKT *>(cur->getParent().get());
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

void TrieformProverKT::preprocess() {
    boxClausesT();
    modalContextsT();
}

void TrieformProverKT::boxClausesT() {
    for (ModalClause modalClause : clauses.getBoxClauses()) {
        formula_set newOr;
        newOr.insert(Not::create(modalClause.left)->negatedNormalForm());
        newOr.insert(modalClause.right);
        clauses.addClause(Or::create(newOr));
    }
    for (auto modalSubtrie : subtrieMap) {
        dynamic_cast<TrieformProverKT *>(modalSubtrie.second.get())
            ->boxClausesT();
    }
}

void TrieformProverKT::modalContextsT() {
    for (auto modalSubtrie : subtrieMap) {
        dynamic_cast<TrieformProverKT *>(modalSubtrie.second.get())
            ->modalContextsT();
        overShadow(modalSubtrie.second, modalSubtrie.first);
    }
}
