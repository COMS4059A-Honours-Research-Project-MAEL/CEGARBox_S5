#include "Prover.h"

Prover::Prover() {}
Prover::~Prover() {}

unordered_map<Literal, Literal, LiteralHash, LiteralEqual> Prover::eventualityToLit = {};

unordered_map<Literal, Literal, LiteralHash, LiteralEqual> Prover::litToEventuality = {};

void Prover::createModalImplication(int modality, Literal left, Literal right,
        modal_lit_implication &modalLits,
        modal_lit_implication &modalFromRight) {
    modalLits[modality][left].insert(right);
    modalFromRight[modality][right].insert(left);
}

string Prover::getPrimitiveName(shared_ptr<Formula> formula) {
    if (formula->getType() == FAtom) {
        return dynamic_cast<Atom *>(formula.get())->getName();
    } else if (formula->getType() == FNot) {
        return dynamic_cast<Atom *>(
                dynamic_cast<Not *>(formula.get())->getSubformula().get())
            ->getName();
    }
    throw invalid_argument("Expected Atom or Not but got " + formula->toString());
}

Literal Prover::toLiteral(shared_ptr<Formula> formula) {
    if (formula->getType() == FAtom) {
        return Literal(dynamic_cast<Atom *>(formula.get())->getName(), true);
    } else if (formula->getType() == FNot) {
        return Literal(
                dynamic_cast<Atom *>(
                    dynamic_cast<Not *>(formula.get())->getSubformula().get())
                ->getName(),
                false);
    }
    throw invalid_argument("Expected Atom or Not but got " + formula->toString());
}

void Prover::calculateTriggeredModalClauses(modal_lit_implication &modalLits,
        modal_literal_map &triggered) {
    triggered.clear();
    for (auto modalityLitImplication : modalLits) {
        for (auto literalImplication : modalityLitImplication.second) {
            if (modelSatisfiesAssump(literalImplication.first)) {
                triggered[modalityLitImplication.first].insert(
                        literalImplication.second.begin(), literalImplication.second.end());
            }
        }
    }
}

void Prover::calculateTriggeredModalClauses(modal_lit_implication &modalLits,
        modal_literal_map &triggered, literal_set& model) {
    triggered.clear();
    for (auto modalityLitImplication : modalLits) {
        for (auto literalImplication : modalityLitImplication.second) {
            if (model.find(literalImplication.first) != model.end()) {
                triggered[modalityLitImplication.first].insert(
                        literalImplication.second.begin(), literalImplication.second.end());
            }
        }
    }
}

string clauseToString(literal_set clause) {
    string result = "";
    for (auto literal : clause) {
        result += literal.toString() + " ";
    }
    return result;
}

bool Prover::modelSatisfiesAssumps(literal_set assumptions) {
    for (Literal assump : assumptions) {
        if (!modelSatisfiesAssump(assump)) {
            return false;
        }
    }
    return true;
}
modal_literal_map
Prover::getTriggeredModalClauses(modal_lit_implication &modalLits) {
    modal_literal_map triggered;
    for (auto modalityLitImplication : modalLits) {
        cout << "Checking modality " << modalityLitImplication.first << endl;
        for (auto literalImplication : modalityLitImplication.second) {
            cout << "Checking " << literalImplication.first.toString() << " -> " << (*literalImplication.second.begin()).toString() << endl;
            if (modelSatisfiesAssump(literalImplication.first)) {
                triggered[modalityLitImplication.first].insert(
                        literalImplication.second.begin(), literalImplication.second.end());
            }
        }
    }
    return triggered;
}

void Prover::calculateTriggeredBoxClauses() {
    calculateTriggeredModalClauses(boxLits, triggeredBoxes);
}

void Prover::calculateTriggeredDiamondsClauses() {
    calculateTriggeredModalClauses(diamondLits, triggeredDiamonds);
}


void Prover::calculateTriggeredBoxClauses(literal_set& model) {
    calculateTriggeredModalClauses(boxLits, triggeredBoxes);
}

void Prover::calculateTriggeredDiamondsClauses(literal_set& model) {
    calculateTriggeredModalClauses(diamondLits, triggeredDiamonds);
}

modal_literal_map Prover::getTriggeredBoxClauses() { return triggeredBoxes; }
modal_literal_map Prover::getTriggeredDiamondClauses() {
    return triggeredDiamonds;
}
literal_set Prover::getNotAllDiamondLeft(int modality) {
    literal_set notAllDiamondLeft;
    for (auto literalImplication : diamondLits[modality]) {
        notAllDiamondLeft.insert(~literalImplication.first);
    }
    return notAllDiamondLeft;
}


literal_set Prover::rememberTriggeredImplications() {
    // Required for Tense where we might reuse SAT solvers inbetween calculating the conflict
    literal_set triggeredImplications;
    for (auto x : boxLits) {
        for (auto literalImplication : x.second) {
            if (modelSatisfiesAssump(literalImplication.first)) {
                triggeredImplications.insert(literalImplication.first);
            }
        }
    }
    for (auto x : diamondLits) {
        for (auto literalImplication : x.second) {
            if (modelSatisfiesAssump(literalImplication.first)) {
                triggeredImplications.insert(literalImplication.first);
            }
        }
    }
    return triggeredImplications;
}

vector<literal_set> Prover::getNotProblemBoxClauses(int modality,
        literal_set conflicts, literal_set& triggeredImplications) {
    vector<literal_set> notProblemBoxClauses;
    for (Literal conflict : conflicts) {
        literal_set problemLeft;
        for (auto literalImplication : boxLits[modality]) {
            if ((triggeredImplications.find(literalImplication.first) != triggeredImplications.end()) &&
                    (literalImplication.second.find(conflict) !=
                     literalImplication.second.end())) {
                problemLeft.insert(~literalImplication.first);
            }
        }
        if (problemLeft.size() > 0) {
            notProblemBoxClauses.push_back(problemLeft);
        }
    }
    return notProblemBoxClauses;
};
vector<literal_set> Prover::getNotProblemBoxClauses(int modality,
        literal_set conflicts) {
    vector<literal_set> notProblemBoxClauses;
    for (Literal conflict : conflicts) {
        literal_set problemLeft;
        for (auto literalImplication : boxLits[modality]) {
            if (modelSatisfiesAssump(literalImplication.first) &&
                    literalImplication.second.find(conflict) !=
                    literalImplication.second.end()) {
                problemLeft.insert(~literalImplication.first);
            }
        }
        if (problemLeft.size() > 0) {
            notProblemBoxClauses.push_back(problemLeft);
        }
    }
    return notProblemBoxClauses;
};

literal_set Prover::getNotDiamondLeft(int modality, Literal diamond, literal_set& triggeredImplications) {
    literal_set notDiamondLeft;
    for (auto literalImplication : diamondLits[modality]) {
        if ((triggeredImplications.find(literalImplication.first) != triggeredImplications.end()) &&
                (literalImplication.second.find(diamond) !=
                 literalImplication.second.end())) {
            notDiamondLeft.insert(~literalImplication.first);
        }
    }
    return notDiamondLeft;
}
literal_set Prover::getNotDiamondLeft(int modality, Literal diamond) {
    literal_set notDiamondLeft;
    for (auto literalImplication : diamondLits[modality]) {
        if (modelSatisfiesAssump(literalImplication.first) &&
                literalImplication.second.find(diamond) !=
                literalImplication.second.end()) {
            notDiamondLeft.insert(~literalImplication.first);
        }
    }
    return notDiamondLeft;
}

void Prover::updateLastFail(Literal clause) {lastFail[clause]=++failCount;}
void Prover::addToFail(Literal clause, int delta) {lastFail[clause]+=delta;}// = ++failCount; }

diamond_queue Prover::getPrioritisedTriggeredDiamonds(int modality) {
    // Note MUST avoid box clauses
    diamond_queue prioritisedTriggeredDiamonds;
    literal_set triggeredBoxes = getTriggeredBoxClauses()[modality];
    literal_set triggeredDiamonds = getTriggeredDiamondClauses()[modality];
    for (Literal diamond : triggeredDiamonds) {
        if (triggeredBoxes.find(diamond) == triggeredBoxes.end()) {
            prioritisedTriggeredDiamonds.push({diamond, lastFail[diamond]});
        }
    }

    // If we have no triggered diamonds, we are in D \subset B case
    // We create one world
    if (prioritisedTriggeredDiamonds.size() == 0) {
        Literal diamond = *triggeredDiamonds.begin();
        prioritisedTriggeredDiamonds.push({diamond, lastFail[diamond]});
    }

    return prioritisedTriggeredDiamonds;
}


diamond_queue Prover::getPrioritisedTriggeredDiamonds(int modality, literal_set& triggeredBoxes, literal_set& triggeredDiamonds) {
    // Note MUST avoid box clauses
    diamond_queue prioritisedTriggeredDiamonds;
    for (Literal diamond : triggeredDiamonds) {
        if (triggeredBoxes.find(diamond) == triggeredBoxes.end()) {
            prioritisedTriggeredDiamonds.push({diamond, lastFail[diamond]});
        }
    }
    // If we have no triggered diamonds, we are in D \subset B case
    // We create one world
    if (prioritisedTriggeredDiamonds.size() == 0) {
        Literal diamond = *triggeredDiamonds.begin();
        prioritisedTriggeredDiamonds.push({diamond, lastFail[diamond]});
    }
    return prioritisedTriggeredDiamonds;
}


vector<literal_set> Prover::createConflictGroups(int modality, literal_set nextModalContextConflict) {
    vector<literal_set> conflictGroups;
    for (auto lit : nextModalContextConflict) {
        literal_set currentGroup;
        if (boxFromRight[modality].find(lit) != boxFromRight[modality].end()) {
            currentGroup.insert(boxFromRight[modality][lit].begin(), boxFromRight[modality][lit].end());

        }

        if (diamondFromRight[modality].find(lit) != diamondFromRight[modality].end()) {
            currentGroup.insert(diamondFromRight[modality][lit].begin(), diamondFromRight[modality][lit].end());

        }
        if (currentGroup.size() == 0) {
            return {};
        } else {
            conflictGroups.push_back(currentGroup);
        }
    }
    return conflictGroups;
}

vector<literal_set>
Prover::generateClauses(vector<literal_set> literalCombinations) {
    vector<literal_set> clauses;
    if (literalCombinations.size() == 0) {
        return clauses;
    }
    literal_set levelLiterals = literalCombinations.back();

    if (literalCombinations.size() == 1) {
        for (Literal literal : levelLiterals) {
            literal_set single;
            single.insert(literal);
            clauses.push_back(single);
        }
        return clauses;
    }

    literalCombinations.pop_back();
    vector<literal_set> futureClauses = generateClauses(literalCombinations);
    for (Literal literal : levelLiterals) {
        for (literal_set futureClause : futureClauses) {
            literal_set copy = literal_set(futureClause);
            copy.insert(literal);
            clauses.push_back(copy);
        }
    }
    return clauses;
}

vector<literal_set> cartesianProduct(const vector<vector<literal_set>>& arr, size_t index = 0) {
    vector<literal_set> result;

    if (index == arr.size() - 1) {
        for (const literal_set& element : arr[index]) {
            result.push_back(element);
        }
        return result;
    }

    // Recursive case: combine the current vector with the next vectors
    vector<literal_set> subResult = cartesianProduct(arr, index + 1);
    for (const literal_set& element : arr[index]) {
        for (const literal_set& subElement : subResult) {
            // Combine the current element with each element from the sub-result
            literal_set combinedSet = element;
            combinedSet.insert(subElement.begin(), subElement.end());
            result.push_back(combinedSet);
        }
    }

    return result;
}

bool contains(literal_set &superset, literal_set &subset) {
    for (auto lit : subset) {
        if (superset.find(lit) == superset.end()) return false;
    }
    return true;
}

vector<literal_set> Prover::checkClauses(int modality, vector<literal_set> clauses, literal_set badClause) {
    // return clauses which only have one diamond
    // or if they have none, duplicate that clause with all diamonds
    vector<literal_set> validClauses;
    for (auto clause : clauses) {
        literal_set boxLiterals;
        literal_set diamondLiterals;
        for (auto literal : clause) {
            for (Literal boxLit : boxLits[modality][literal]) boxLiterals.insert(boxLit);
            for (Literal diamondLit : diamondLits[modality][literal]) diamondLiterals.insert(diamondLit);
        }
        //cout << "Box lits: ";
        //for (auto x: boxLiterals) cout << x.toString() << " "; cout << endl;
        //for (auto x: diamondLiterals) cout << x.toString() << " "; cout << endl;
        for (auto diamondLiteral : diamondLiterals) {
            if (boxLiterals.find(diamondLiteral) == boxLiterals.end()) {
                boxLiterals.insert(diamondLiteral);
                if (contains(boxLiterals, badClause)) {
                    validClauses.push_back(clause);
                    boxLiterals.erase(boxLiterals.find(diamondLiteral));
                    break;
                }
                boxLiterals.erase(boxLiterals.find(diamondLiteral));
            }
        }
        if (contains(boxLiterals, badClause)) {
            vector<literal_set> newCombination;
            for (Literal literal : clause) {
                literal_set single;
                single.insert(literal);
                newCombination.push_back(single);
            }

            //cout << "Creating ALL BAD BOX" << endl;
            literal_set diamonds;
            for (auto diamond : diamondLits[modality]) {
                if (diamond.second.empty()) continue;
                diamonds.insert(diamond.first);
                //cout << diamond.first.toString() << " ";
            }
            //cout << endl;
            newCombination.push_back(diamonds);
            if (!diamonds.empty()) for (auto clause : generateClauses(newCombination)) validClauses.push_back(clause);

        }
    }
    return validClauses;
}

vector<literal_set> Prover::filterPropagatedConflicts(vector<literal_set> clauses) {
    // Only propagate clauses with size 2 (otherwise it can blow up)
    vector<literal_set> result;
    for (literal_set clause : clauses) {
        if (clause.size() > 2) continue;
        result.push_back(clause);
    }
    return result;
}
vector<literal_set> Prover::negatedClauses(vector<literal_set> clauses) {
    vector<literal_set> result;
    for (literal_set clause : clauses) {
        literal_set negatedClause;
        for (Literal lit : clause) {
            negatedClause.insert(~lit);
        }
        result.push_back(negatedClause);
    }
    return result;
}

vector<literal_set> Prover::getClauses(int modality, literal_set conflict) {
    if (conflict.size() != 0) {
        return negatedClauses(checkClauses(modality, generateClauses(createConflictGroups(modality, conflict)), conflict));
    }else {
        vector<literal_set> clauses;
        for (auto x : diamondLits[modality]) {
            if (x.second.empty()) continue;
            literal_set litset;
            litset.insert(~x.first);
            //cout << (~x.first).toString() << " "; 
            clauses.push_back(litset);
        } //                                   cout << endl;
        return clauses;
    }
}

vector<literal_set> Prover::getClauses(int modality, vector<literal_set> conflicts) {
    vector<literal_set> result;
    for (auto conflict : conflicts) {
        auto newConflicts = getClauses(modality, conflict);
        result.insert(result.end(), newConflicts.begin(), newConflicts.end());
    }

    // Remove duplicates
    vector<literal_set> pure;
    std::sort(result.begin(), result.end(), [&](const literal_set & a, const literal_set & b){ return a.size() < b.size(); });

    for (literal_set conflict : result) {
        bool isPure = true;
        for (literal_set done : pure) {
            bool contains = true;
            for (Literal x : done) {
                if (conflict.find(x) == conflict.end()) {
                    contains = false;
                    break;
                }
            }
            if (contains) {
                isPure = false;
                break;
            }
        }

        if (isPure) pure.push_back(conflict);
    }
    return pure;
}
