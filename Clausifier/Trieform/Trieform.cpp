#include "Trieform.h"

#include <numeric>

bool Trieform::stringModalContexts = false;
bool Trieform::ensureUniqueModalClauseLhs = false;
shared_ptr<Cache> Trieform::cache = make_shared<PrefixCache>("x");
set<pair<vector<int>, vector<int>>> Trieform::composeCache;
set<shared_ptr<Trieform>> Trieform::visited;
vector<shared_ptr<Trieform>> Trieform::topSort;

bool Trieform::useOneSat = false;
shared_ptr<Prover> Trieform::globalProver = shared_ptr<Prover>(new MinisatProver(false));

Trieform::Trieform() {
    prover = shared_ptr<Prover>(new MinisatProver(useOneSat));
}

void Trieform::initialise(const shared_ptr<Formula> &formula,
                          shared_ptr<Trieform> parentTrie) {
    propagateClauses(formula);
    parent = parentTrie;
    parents.push_back(parentTrie);
}

void Trieform::initialise(const shared_ptr<Formula> &formula,
                          const vector<int> &newModality,
                          shared_ptr<Trieform> parentTrie) {
    modality = newModality;
    parent = parentTrie;
    parents.push_back(parentTrie);

    cout << "INITIALISING " << formula->toString() << endl;

    propagateClauses(formula);
}

void Trieform::initialise(const vector<int> &newModality,
                          shared_ptr<Trieform> parentTrie) {
    modality = newModality;
    parent = parentTrie;
    parents.push_back(parentTrie);
}

Trieform::~Trieform() {}

void Trieform::propagateClauses(const shared_ptr<Formula> &formula) {
    switch (formula->getType()) {
        case FTrue:
            clauses.addClause(formula);
            break;

        case FFalse:
            clauses.addClause(formula);
            break;

        case FAtom:
            clauses.addClause(formula);
            break;

        case FNot:
            // Negated Normal Form means this is guaranteed to be primative
            clauses.addClause(formula);
            break;

        case FAnd: {
            And *a = dynamic_cast<And *>(formula.get());
            for (shared_ptr<Formula> subformula : a->getSubformulas()) {
                propagateClauses(subformula);
            }
        } break;

        case FBox: {
            Box *b = dynamic_cast<Box *>(formula.get());
            if (!stringModalContexts) {
                shared_ptr<Trieform> subtrie =
                    getSubtrieOrEmpty(b->getModality());
                for (int i = 1; i < b->getPower(); i++) {
                    subtrie = subtrie->getSubtrieOrEmpty(b->getModality());
                }
                subtrie->propagateClauses(b->getSubformula());
            } else {
                if (b->getPower() == 1 && b->getSubformula()->isPrimitive()) {
                    clauses.addBoxClause(b->getModality(), True::create(),
                                         b->getSubformula());
                    ensureSubtrieExistence(b->getModality());
                } else {
                    shared_ptr<Formula> boxReduced = b->constructBoxReduced();
                    vector<int> newModality =
                        constructNewModality(b->getModality());

                    shared_ptr<Formula> repVariable;
                    if (!cache->contains(boxReduced, newModality)) {
                        repVariable =
                            cache->createVariableNoInsert(boxReduced, newModality);
                        getSubtrieOrEmpty(b->getModality())
                            ->sequenceClausify(boxReduced, repVariable);
                        cache->insertVariable(boxReduced, newModality, repVariable);
                    } else {
                        repVariable = cache->getVariableRepresenting(
                            boxReduced, newModality);
                    }
                    clauses.addBoxClause(b->getModality(), True::create(),
                                         repVariable);
                }
            }
        } break;

        case FDiamond: {
            Diamond *d = dynamic_cast<Diamond *>(formula.get());
            if (d->getPower() == 1 && d->getSubformula()->isPrimitive()) {
                clauses.addDiamondClause(d->getModality(), True::create(),
                                         d->getSubformula());
                ensureSubtrieExistence(d->getModality());
            } else {
                shared_ptr<Formula> diamondReduced =
                    d->constructDiamondReduced();
                vector<int> newModality =
                    constructNewModality(d->getModality());

                shared_ptr<Formula> repVariable;
                if (!cache->contains(diamondReduced, newModality)) {
                    repVariable =
                        cache->createVariableNoInsert(diamondReduced, newModality);
                    getSubtrieOrEmpty(d->getModality())
                        ->sequenceClausify(diamondReduced, repVariable);
                    cache->insertVariable(diamondReduced, newModality, repVariable);
                } else {
                    repVariable = cache->getVariableRepresenting(diamondReduced,
                                                                 newModality);
                }
                clauses.addDiamondClause(d->getModality(), True::create(),
                                         repVariable);
            }
        } break;

        case FOr: {
            Or *o = dynamic_cast<Or *>(formula.get());

            if (o->getLength() == 2) {
                vector<shared_ptr<Formula>> formulas;
                for (shared_ptr<Formula> subformula : o->getSubformulas()) {
                    // Code is incorrect as it might do x1 -> x1
                    // if (cache->contains(subformula, modality)) {
                    //    formulas.push_back(cache->getVariableRepresenting(subformula,
                    //    modality));
                    //}
                    // else {
                    formulas.push_back(subformula);
                    //}
                }
                if (ensureUniqueModalClauseLhs) {
                    propagateOr(formula);
                } else if (formulas[0]->getType() == FBox &&
                    formulas[1]->isPrimitive()) {
                    orBoxClausify(formulas[0], formulas[1]);
                } else if (formulas[0]->isPrimitive() &&
                           formulas[1]->getType() == FBox) {
                    orBoxClausify(formulas[1], formulas[0]);
                } else if (formulas[0]->getType() == FDiamond &&
                           formulas[1]->isPrimitive()) {
                    orDiamondClausify(formulas[0], formulas[1]);
                } else if (formulas[0]->isPrimitive() &&
                           formulas[1]->getType() == FDiamond) {
                    orDiamondClausify(formulas[1], formulas[0]);
                } else if (((formulas[0]->getType() == FDiamond) ||
                            (formulas[0]->getType() == FBox)) &&
                           (formulas[1]->getType() == FDiamond)) {
                    orDiamondClausify(formulas[1], nameFor(formulas[0]));
                } else if (((formulas[0]->getType() == FDiamond) ||
                            (formulas[0]->getType() == FBox)) &&
                           (formulas[1]->getType() == FBox)) {
                    orBoxClausify(formulas[1], nameFor(formulas[0]));
                } else {
                    propagateOr(formula);
                }
            } else {
                propagateOr(formula);
            }
        } break;
    }
}

void Trieform::propagateOr(const shared_ptr<Formula> &formula) {
    Or *o = dynamic_cast<Or *>(formula.get());
    formula_set newOrSet;
    for (shared_ptr<Formula> subformula : o->getSubformulas()) {
        shared_ptr<Formula> name = nameFor(subformula);
        newOrSet.insert(name);
    }
    clauses.addClause(Or::create(newOrSet));
}

shared_ptr<Formula> Trieform::nameFor(const shared_ptr<Formula> &formula) {
    switch (formula->getType()) {
        case FTrue:
        case FFalse:
        case FAtom:
        case FNot:
            return formula;
        case FAnd: {
            if (cache->contains(formula, modality)) {
                return cache->getVariableRepresenting(formula, modality);
            } else {
                shared_ptr<Formula> repVariable =
                    cache->createVariableFor(formula, modality);

                shared_ptr<Formula> left =
                    Not::create(repVariable)->negatedNormalForm();
                And *a = dynamic_cast<And *>(formula.get());
                for (shared_ptr<Formula> subformula : a->getSubformulas()) {
                    formula_set newOrSet;
                    newOrSet.insert(left);
                    newOrSet.insert(subformula);
                    propagateClauses(Or::create(newOrSet));
                }
                return repVariable;
            }
        } break;
        case FOr: {
            Or *o = dynamic_cast<Or *>(formula.get());
            formula_set newOrSet;
            for (shared_ptr<Formula> subformula : o->getSubformulas()) {
                newOrSet.insert(nameFor(subformula));
            }
            return Or::create(newOrSet);
        } break;
        case FBox: {
            Box *b = dynamic_cast<Box *>(formula.get());
            shared_ptr<Formula> boxReduced = b->constructBoxReduced();
            
            if (boxReduced->isPrimitive()) {
                shared_ptr<Formula> left =
                    cache->getVariableOrCreate(formula, modality);
                clauses.addBoxClause(b->getModality(), left, boxReduced);
                ensureSubtrieExistence(b->getModality());
                return left;
            } else {
                if (cache->contains(formula, modality)) {
                    return cache->getVariableRepresenting(formula, modality);
                } else {
                    shared_ptr<Formula> left =
                        cache->createVariableFor(formula, modality);

                    vector<int> newModality =
                        constructNewModality(b->getModality());

                    shared_ptr<Formula> middle;
                    if (cache->contains(boxReduced, newModality)) {
                        middle = cache->getVariableRepresenting(boxReduced,
                                                                newModality);
                    } else {
                        middle =
                            cache->createVariableNoInsert(boxReduced, newModality);
                        getSubtrieOrEmpty(b->getModality())
                            ->sequenceClausify(boxReduced, middle);
                        cache->insertVariable(boxReduced, newModality, middle);
                    }

                    clauses.addBoxClause(b->getModality(), left, middle);
                    return left;
                }
            }
        } break;
        case FDiamond: {
            Diamond *d = dynamic_cast<Diamond *>(formula.get());
            shared_ptr<Formula> diamondReduced = d->constructDiamondReduced();

            if (diamondReduced->isPrimitive()) {
                shared_ptr<Formula> left =
                    cache->getVariableOrCreate(formula, modality);
                clauses.addDiamondClause(d->getModality(), left,
                                         diamondReduced);
                ensureSubtrieExistence(d->getModality());
                return left;
            } else {
                if (cache->contains(formula, modality)) {
                    return cache->getVariableRepresenting(formula, modality);
                } else {
                    shared_ptr<Formula> left =
                        cache->createVariableFor(formula, modality);

                    vector<int> newModality =
                        constructNewModality(d->getModality());

                    shared_ptr<Formula> middle;
                    if (cache->contains(diamondReduced, newModality)) {
                        middle = cache->getVariableRepresenting(diamondReduced,
                                                                newModality);
                    } else {
                        middle = cache->createVariableNoInsert(diamondReduced,
                                                          newModality);
                        getSubtrieOrEmpty(d->getModality())
                            ->sequenceClausify(diamondReduced, middle);
                        cache->insertVariable(diamondReduced, newModality, middle);
                    }

                    clauses.addDiamondClause(d->getModality(), left, middle);
                    return left;
                }
            }
        } break;
    }
    throw runtime_error("nameFor did not properly generate name for" +
                        formula->toString());
}

void Trieform::orBoxClausify(const shared_ptr<Formula> &box,
                             const shared_ptr<Formula> &primitive) {
    Box *b = dynamic_cast<Box *>(box.get());
    shared_ptr<Formula> boxReduced = b->constructBoxReduced();

    shared_ptr<Formula> newPrimitive = primitive;

    if (boxReduced->isPrimitive()) {
        clauses.addBoxClause(b->getModality(),
                             Not::create(newPrimitive)->negatedNormalForm(),
                             boxReduced);
        ensureSubtrieExistence(b->getModality());
    } else {
        vector<int> newModality = constructNewModality(b->getModality());

        shared_ptr<Formula> repVariable;
        if (cache->contains(boxReduced, newModality)) {
            repVariable =
                cache->getVariableRepresenting(boxReduced, newModality);
        } else {
            repVariable = cache->createVariableFor(boxReduced, newModality);
            getSubtrieOrEmpty(b->getModality())
                ->sequenceClausify(boxReduced, repVariable);
        }
        clauses.addBoxClause(b->getModality(),
                             Not::create(newPrimitive)->negatedNormalForm(),
                             repVariable);
    }
}

void Trieform::orDiamondClausify(const shared_ptr<Formula> &diamond,
                                 const shared_ptr<Formula> &primitive) {
    Diamond *d = dynamic_cast<Diamond *>(diamond.get());
    shared_ptr<Formula> diamondReduced = d->constructDiamondReduced();

    
    shared_ptr<Formula> newPrimitive = primitive;
    

    if (diamondReduced->isPrimitive()) {
        clauses.addDiamondClause(d->getModality(),
                                 Not::create(newPrimitive)->negatedNormalForm(),
                                 diamondReduced);
        ensureSubtrieExistence(d->getModality());
    } else {
        vector<int> newModality = constructNewModality(d->getModality());

        shared_ptr<Formula> repVariable;
        if (cache->contains(diamondReduced, newModality)) {
            repVariable =
                cache->getVariableRepresenting(diamondReduced, newModality);
        } else {
            repVariable = cache->createVariableFor(diamondReduced, newModality);
            getSubtrieOrEmpty(d->getModality())
                ->sequenceClausify(diamondReduced, repVariable);
        }
        clauses.addDiamondClause(d->getModality(),
                                 Not::create(newPrimitive)->negatedNormalForm(),
                                 repVariable);
    }
}

void Trieform::sequenceClausify(const shared_ptr<Formula> &formula,
                                const shared_ptr<Formula> &left) {
    for (shared_ptr<Formula> f : removeAnds(formula)) {
        // If the formula is already an Or, the Or constructor will pop it out
        formula_set newOr;
        newOr.insert(f);
        newOr.insert(Not::create(left)->negatedNormalForm());
        propagateClauses(Or::create(newOr));
    }
}

formula_set Trieform::removeAnds(const shared_ptr<Formula> &formula) {
    if (formula->getType() == FAnd) {
        And *a = dynamic_cast<And *>(formula.get());
        return a->getSubformulas();
    }
    formula_set newSet;
    newSet.insert(formula);
    return newSet;
}

trie_map Trieform::getTrieMap() { return subtrieMap; }

unordered_set<int> Trieform::getFutureModalities() { return futureModalities; }

shared_ptr<Trieform> Trieform::getSubtrie(int subModality) {
    return subtrieMap[subModality];
}

shared_ptr<Trieform> Trieform::getSubtrieOrEmpty(int subModality) {
    if (hasSubtrie(subModality)) {
        return subtrieMap[subModality];
    }
    futureModalities.insert(subModality);

    vector<int> newModality = constructNewModality(subModality);

    shared_ptr<Trieform> subtrie = shared_ptr<Trieform>(create(newModality));
    subtrieMap[subModality] = subtrie;

    return subtrie;
}

void Trieform::ensureSubtrieExistence(int subModality) {
    if (!hasSubtrie(subModality)) {
        futureModalities.insert(subModality);

        vector<int> newModality = constructNewModality(subModality);
        subtrieMap[subModality] = shared_ptr<Trieform>(create(newModality));
    }
}

bool Trieform::hasSubtrie(int subModality) {
    return subtrieMap.find(subModality) != subtrieMap.end();
}

void Trieform::removeSubtrie(int subModality) {
    futureModalities.erase(subModality);
    subtrieMap.erase(subModality);
}

Cache &Trieform::getCache() { return *cache; }
const FormulaTriple &Trieform::getClauses() { return clauses; }
shared_ptr<Prover> &Trieform::getProver() { return prover; }
shared_ptr<Trieform> Trieform::getParent() { return parent; }

vector<int> Trieform::constructNewModality(int subModality) {
    vector<int> newModality(modality);
    newModality.push_back(subModality);
    return newModality;
}

string Trieform::toString() {
    vector<string> clauseComponents = clauses.toStringComponents();
    sort(clauseComponents.begin(), clauseComponents.end());

    string levelModality = "";
    int previousSeenModality = INT_MIN;
    int count = 0;
    for (int mod : modality) {
        if (mod != previousSeenModality) {
            if (count > 0) {
                levelModality += "[r" + to_string(previousSeenModality) + "]^" +
                                 to_string(count);
            }
            count = 1;
            previousSeenModality = mod;
        } else {
            count++;
        }
    }
    if (count > 0) {
        levelModality +=
            "[r" + to_string(previousSeenModality) + "]^" + to_string(count);
    }

    string trieString = "";
    for (unsigned int i = 1; i < clauseComponents.size(); i++) {
        if (modality.size() > 0) {
            trieString += levelModality + " " + clauseComponents[i - 1] + "\n";
        } else {
            trieString += clauseComponents[i - 1] + "\n";
        }
    }
    if (clauseComponents.size() > 0) {
        if (modality.size() > 0) {
            trieString += levelModality + " " +
                          clauseComponents[clauseComponents.size() - 1];
        } else {
            trieString += clauseComponents[clauseComponents.size() - 1];
        }
    }

    for (auto modTrie : subtrieMap) {
        if (modTrie.second == shared_from_this()) continue;
        if (trieString.size() > 0) {
            trieString += "\n" + modTrie.second->toString();
        } else {
            trieString = modTrie.second->toString();
        }
    }
    return trieString;
}

void Trieform::reduceClauses() {
    if (!ensureUniqueModalClauseLhs) {
        combineBoxLeft();
        combineBoxRight();
        combineDiamondRight();
    }
    for (auto modalityTrie : subtrieMap) {
        modalityTrie.second->reduceClauses();
    }
}

void Trieform::removeTrueAndFalse() {
    visited.clear();
    removeTrueAndFalseHelper();
}

void Trieform::removeTrueAndFalseHelper() {
    if (visited.find(shared_from_this()) != visited.end()) {
        return;
    }
    visited.insert(shared_from_this());
    clauses.removeTrueAndFalse();
    for (auto modTrie : subtrieMap) {
        modTrie.second->removeTrueAndFalseHelper();
    }
}

void Trieform::combineBoxRight() {
    common_modal_map sameBoxRight;
    for (ModalClause modalClause : clauses.getBoxClauses()) {
        sameBoxRight[{modalClause.modality, modalClause.right}].insert(
            modalClause.left);
    }
    clauses.eraseBoxClauses();

    for (auto value : sameBoxRight) {
        shared_ptr<Formula> formula = Or::create(value.second);
        if (formula->getType() != FOr) {
            clauses.addBoxClause(value.first.modality, formula,
                                 value.first.common);
        } else if (cache->contains(formula, modality)) {
            clauses.addBoxClause(
                value.first.modality,
                cache->getVariableRepresenting(formula, modality),
                value.first.common);
        } else {
            shared_ptr<Formula> repVariable =
                cache->createVariableFor(formula, modality);
            for (shared_ptr<Formula> sub :
                 (dynamic_cast<Or *>(formula.get()))->getSubformulas()) {
                formula_set newOrSet;
                newOrSet.insert(Not::create(sub)->negatedNormalForm());
                newOrSet.insert(repVariable);
                clauses.addClause(Or::create(newOrSet));
            }
            clauses.addBoxClause(value.first.modality, repVariable,
                                 value.first.common);
        }
    }
}

void Trieform::combineDiamondRight() {
    common_modal_map sameDiamondRight;
    for (ModalClause modalClause : clauses.getDiamondClauses()) {
        sameDiamondRight[{modalClause.modality, modalClause.right}].insert(
            modalClause.left);
    }
    clauses.eraseDiamondClauses();

    for (auto value : sameDiamondRight) {
        shared_ptr<Formula> formula = Or::create(value.second);
        if (formula->getType() != FOr) {
            clauses.addDiamondClause(value.first.modality, formula,
                                     value.first.common);
        } else if (cache->contains(formula, modality)) {
            clauses.addDiamondClause(
                value.first.modality,
                cache->getVariableRepresenting(formula, modality),
                value.first.common);
        } else {
            shared_ptr<Formula> repVariable =
                cache->createVariableFor(formula, modality);
            for (shared_ptr<Formula> sub :
                 (dynamic_cast<Or *>(formula.get()))->getSubformulas()) {
                formula_set newOrSet;
                newOrSet.insert(Not::create(sub)->negatedNormalForm());
                newOrSet.insert(repVariable);
                clauses.addClause(Or::create(newOrSet));
            }
            clauses.addDiamondClause(value.first.modality, repVariable,
                                     value.first.common);
        }
    }
}

void Trieform::combineBoxLeft() {
    common_modal_map sameBoxLeft;
    for (ModalClause modalClause : clauses.getBoxClauses()) {
        sameBoxLeft[{modalClause.modality, modalClause.left}].insert(
            modalClause.right);
    }
    clauses.eraseBoxClauses();

    for (auto value : sameBoxLeft) {
        shared_ptr<Formula> formula = And::create(value.second);
        if (formula->getType() == FTrue) {
        } else if (formula->getType() == FFalse) {
            clauses.addBoxClause(value.first.modality, value.first.common,
                                 formula);
        } else if (formula->getType() != FAnd) {
            clauses.addBoxClause(value.first.modality, value.first.common,
                                 *value.second.begin());
        } else {
            vector<int> newModality =
                constructNewModality(value.first.modality);
            if (cache->contains(formula, newModality)) {
                clauses.addBoxClause(
                    value.first.modality, value.first.common,
                    cache->getVariableRepresenting(formula, newModality));
            } else {
                shared_ptr<Formula> repVariable =
                    cache->createVariableFor(formula, newModality);
                shared_ptr<Trieform> subtrie =
                    getSubtrieOrEmpty(value.first.modality);
                for (shared_ptr<Formula> subformula :
                     (dynamic_cast<And *>(formula.get()))->getSubformulas()) {
                    formula_set newOrSet;
                    newOrSet.insert(subformula);
                    newOrSet.insert(
                        Not::create(repVariable)->negatedNormalForm());
                    subtrie->clauses.addClause(Or::create(newOrSet));
                }
                clauses.addBoxClause(value.first.modality, value.first.common,
                                     repVariable);
            }
        }
    }
}

vector<literal_set> Trieform::generateClauses(
    vector<literal_set> literalCombinations) {
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

void Trieform::oneNode() {
    // Combine all clauses into the root node
    for (auto modalitySubtrie : subtrieMap) {
        modalitySubtrie.second->oneNode();
        clauses.extendClauses(modalitySubtrie.second->getClauses());
    }
    for (auto c : clauses.getDiamondClauses()) {
        subtrieMap[c.modality] = shared_from_this();
        //c.modality
    }
    /*
    for (auto& modalitySubtrie : subtrieMap) {
        modalitySubtrie.second = shared_from_this();
    }
    */
}

// void Trieform::preprocessT() {
//   // Preprocess for reflexivity
//   for (auto modalitySubtrie : subtrieMap) {
//     modalitySubtrie.second->preprocessT();
//     const FormulaTriple subclauses =
//     modalitySubtrie.second->getClauses();
//     clauses.extendClauses(subclauses);
//   }
//   for (ModalClause modalClause : clauses.getBoxClauses()) {
//     formula_set newOr;
//     newOr.insert(Not::create(modalClause.left)->negatedNormalForm());
//     newOr.insert(modalClause.right);
//     clauses.addClause(Or::create(newOr));
//   }
// }

// void Trieform::preprocessD() {
//   for (auto modalitySubtrie : subtrieMap) {
//     propagateClauses(Diamond::create(modalitySubtrie.first, 1,
//     True::create())); modalitySubtrie.second->preprocessD();
//   }
// }

unsigned int Trieform::getLevel() { return modality.size(); }
// void Trieform::preprocessKB() {
//   for (auto modalitySubtrie : subtrieMap) {
//     modalitySubtrie.second->preprocessKB();

//     const FormulaTriple subclauses =
//         modalitySubtrie.second->getSubtrieOrEmpty(modalitySubtrie.first)
//             ->getClauses();
//     if (modality.size() > 0 &&
//         modality[modality.size() - 1] == modalitySubtrie.first) {
//       clauses.extendClauses(subclauses);
//     } else {
//       shared_ptr<Formula> deadend =
//           Box::create(modalitySubtrie.first, 1, False::create());
//       for (Clause clause : subclauses.getClauses()) {
//         formula_set newOr;
//         newOr.insert(deadend);
//         newOr.insert(clause.formula);
//         propagateClauses(Or::create(newOr));
//       }
//       for (ModalClause clause : subclauses.getBoxClauses()) {
//         formula_set newOr;
//         newOr.insert(deadend);
//         newOr.insert(Not::create(clause.left));
//         newOr.insert(Box::create(clause.modality, 1, clause.right));
//         propagateClauses(Or::create(newOr));
//       }
//       for (ModalClause clause : subclauses.getDiamondClauses()) {
//         formula_set newOr;
//         newOr.insert(deadend);
//         newOr.insert(Not::create(clause.left));
//         newOr.insert(Diamond::create(clause.modality, 1, clause.right));
//         propagateClauses(Or::create(newOr));
//       }
//     }
//     for (ModalClause clause :
//          modalitySubtrie.second->getClauses().getBoxClauses()) {
//       clauses.addBoxClause(clause.modality, clause.right->negate(),
//                            clause.left->negate());
//     }
//   }
// }

// void Trieform::preprocessDB() {
//   if (modality.size() == 0) {
//     for (auto modalitySubtrie : subtrieMap) {
//       propagateClauses(
//           Diamond::create(modalitySubtrie.first, 1, True::create()));
//     }
//   }
//   for (auto modalitySubtrie : subtrieMap) {
//     modalitySubtrie.second->preprocessDB();
//     const FormulaTriple subclauses =
//         modalitySubtrie.second->getSubtrieOrEmpty(modalitySubtrie.first)
//             ->getClauses();
//     clauses.extendClauses(subclauses);
//     for (ModalClause clause :
//          modalitySubtrie.second->getClauses().getBoxClauses()) {
//       clauses.addBoxClause(clause.modality, clause.right->negate(),
//                            clause.left->negate());
//     }
//   }
// }

// void Trieform::preprocessB() {
//   // This can easily be improved (don't need deadend check)
//   preprocessT();
//   preprocessKB();
// }

// void Trieform::preprocess(bool reflexive, bool symmetric, bool
// transitive,
//                           bool serial, bool euclidean) {
//   serial = serial && !reflexive;
//   if (reflexive) {
//     if (symmetric) {
//       preprocessB();
//     } else {
//       preprocessT();
//     }
//   } else if (serial) {
//     if (symmetric) {
//       preprocessDB();
//     } else {
//       preprocessD();
//     }
//   } else if (symmetric) {
//     preprocessKB();
//   }
// }

bool Trieform::parentSatisfiesAssump(Literal literal) {
    return modality.size() > 0 && parent->prover->modelSatisfiesAssump(literal);
}

bool Trieform::parentSatisfiesAssumps(literal_set literals) {
    return modality.size() > 0 &&
           parent->prover->modelSatisfiesAssumps(literals);
}

bool Trieform::isSatisfiable(bool withRoot) {
    // MinisatProver *a = dynamic_cast<MinisatProver*>(prover.get());
    // a->calcSolver->toDimacs("dimacs.txt");

    if (withRoot) {
        return prove({Literal("$root", true)}).satisfiable;
    } else {
        return prove().satisfiable;
    }
}

void Trieform::overShadow(shared_ptr<Trieform> shadowTrie, int skipModality) {
    
    clauses.extendClauses(shadowTrie->getClauses());
    if (clauses.getClauses().size() > 0) {
        //cout << "HERE: " << clauses.getClauses().size() << endl;
    }
    // Shadow Trie is one level down
    for (auto modalSubtrie : shadowTrie->getTrieMap()) {
        if (modalSubtrie.first == skipModality) {
            continue;
        }
        // DAG
        if (hasSubtrie(modalSubtrie.first)) {
            subtrieMap[modalSubtrie.first]->overShadow(modalSubtrie.second);
        } else {
            subtrieMap[modalSubtrie.first] = modalSubtrie.second;
        }
        //getSubtrieOrEmpty(modalSubtrie.first)->overShadow(modalSubtrie.second);
        // cout << "Complete" << endl;
    }
}

void Trieform::compose(shared_ptr<Trieform> shadowTrie, int skipModality, bool sameTrie) {
    /*
    cout << ">>> BEGIN" << endl;
    cout << "COMPOSING ON: ";
    for (auto x : modality) {
        cout << x << " ";
    }
    cout << endl;
    */
    composeCache.clear();
    composeHelper(shadowTrie, skipModality, sameTrie);
}

void Trieform::composeHelper(shared_ptr<Trieform> shadowTrie, int skipModality, bool sameTrie) {
    if (composeCache.find({modality, shadowTrie->modality}) != composeCache.end()) {
        /*
        cout << "SHORT CIRCUIT" << endl;
        cout << "TRIED COMPOSED: " << endl;
        cout << "| ";
        for (auto x : shadowTrie->modality) {
            cout << x << " ";
        }
        cout << "|" << endl;
        cout << "ONTO" << endl;
        cout << "| ";
        for (auto x : shadowTrie->composedOnto.back()->modality) {
            cout << x << " ";
        }
        cout << "|" << endl;
        */
        return;
    }
    if (sameTrie && shadowTrie->modality == modality) {
        return;
    }
    shadowTrie->composedOnto.push_back(shared_from_this());
    /*
    cout << "COMPOSED: " << endl;
    cout << "| ";
    for (auto x : shadowTrie->modality) {
        cout << x << " ";
    }
    cout << "|" << endl;
    cout << "ONTO" << endl;
    cout << "| ";
    for (auto x : shadowTrie->composedOnto.back()->modality) {
        cout << x << " ";
    }
    cout << "|" << endl;
    */
    clauses.extendClauses(shadowTrie->getClauses());
    composeCache.insert({modality, shadowTrie->modality});
    // Shadow Trie is one level down
    for (auto modalSubtrie : shadowTrie->getTrieMap()) {
        if (modalSubtrie.first == skipModality) {
            continue;
        }
        // DAG
        if (hasSubtrie(modalSubtrie.first)) {
            subtrieMap[modalSubtrie.first]
                ->composeHelper(modalSubtrie.second, skipModality, sameTrie);
        } else {
            modalSubtrie.second->parents.push_back(shared_from_this());
            subtrieMap[modalSubtrie.first] = modalSubtrie.second;
        }
        //getSubtrieOrEmpty(modalSubtrie.first)->overShadow(modalSubtrie.second);
        // cout << "Complete" << endl;
    }
}

void Trieform::conditionalOverShadow(shared_ptr<Trieform> shadowTrie,
                                     shared_ptr<Formula> condition,
                                     vector<int> prefix, int skipModality) {
    const FormulaTriple shadowClauses = shadowTrie->getClauses();
    formula_set andSet;
    for (const Clause &clause : shadowClauses.getClauses()) {
        formula_set orSet = formula_set();
        orSet.insert(condition);
        orSet.insert(Box::create(prefix, clause.formula));
        andSet.insert(Or::create(orSet));
    }
    for (const ModalClause &clause : shadowClauses.getBoxClauses()) {
        formula_set leftOrSet = formula_set();
        leftOrSet.insert(condition);
        formula_set rightOrSet = formula_set();
        rightOrSet.insert(clause.left->negate());
        rightOrSet.insert(Box::create(clause.modality, 1, clause.right));
        leftOrSet.insert(Box::create(prefix, Or::create(rightOrSet)));
        andSet.insert(Or::create(leftOrSet));
    }
    for (const ModalClause &clause : shadowClauses.getDiamondClauses()) {
        formula_set leftOrSet = formula_set();
        leftOrSet.insert(condition);
        formula_set rightOrSet = formula_set();
        rightOrSet.insert(clause.left->negate());
        rightOrSet.insert(Diamond::create(clause.modality, 1, clause.right));
        leftOrSet.insert(Box::create(prefix, Or::create(rightOrSet)));
        andSet.insert(Or::create(leftOrSet));
    }

    auto sum = std::accumulate(prefix.begin(), prefix.end(), 0);
    cout << "Propagating: " << sum << ": " << And::create(andSet)->toString()
         << endl;
    propagateClauses(And::create(andSet));
    // Shadow Trie is one level down
    for (auto modalSubtrie : shadowTrie->getTrieMap()) {
        if (modalSubtrie.first == skipModality) {
            continue;
        }
        prefix.push_back(modalSubtrie.first);
        conditionalOverShadow(modalSubtrie.second, condition, prefix);
        prefix.pop_back();
    }
}

void Trieform::doResiduation() {
    for (auto modalSubtrie : subtrieMap) {
        modalSubtrie.second->doResiduation();

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
/*
void Trieform::makeModalLhsUnique() {

    formula_set andSet;
    modal_clause_set newBoxClauses;
    modal_clause_set newDiamondClauses;

    for (auto clause : clauses.getBoxClauses()) {
        clause.left
        formula_set orSet = formula_set();
        orSet.insert(condition);
        orSet.insert(Box::create(prefix, clause.formula));
        andSet.insert(Or::create(orSet));

        newLeft = 
        newBoxClauses.insert({clause.modality, clause.left, clause.right});
    }

    for (auto modalSubtrie : subtrieMap) {
        modalSubtrie.second->makeModalLhsUnique();

    }
    
}
*/
void Trieform::preprocessTense() {
    for (auto modalSubtrie : subtrieMap) {
        modalSubtrie.second->preprocessTense();
        if (modalSubtrie.second->hasSubtrie(-modalSubtrie.first)) {
            shared_ptr<Trieform> future =
                modalSubtrie.second->getSubtrie(-modalSubtrie.first);
            if (modality.size() > 0 &&
                modality[modality.size() - 1] == -modalSubtrie.first) {
                overShadow(future, modalSubtrie.first);
            } else {
                conditionalOverShadow(
                    future, Box::create(modalSubtrie.first, 1, False::create()),
                    vector<int>(), modalSubtrie.first);
            }
        }
        /*
        for (ModalClause futureModalClause :
             modalSubtrie.second->getClauses().getBoxClauses()) {
          if (futureModalClause.modality == -modalSubtrie.first) {
            clauses.addBoxClause({modalSubtrie.first,
                                  futureModalClause.right->negate(),
                                  futureModalClause.left->negate()});
          }
        }
        */
    }
}

void Trieform::calculateFormulaDetails(FormulaDetails &formulaDetails,
                                       const shared_ptr<Formula> &formula,
                                       bool inBox, int curLevelDia) {
    switch (formula->getType()) {
        case FNot:
        case FTrue:
        case FFalse:
        case FAtom:
            if (!inBox) {
                formulaDetails.maxLevelDia =
                    max(formulaDetails.maxLevelDia, curLevelDia);
            }
            break;
        case FAnd: {
            And *a = dynamic_cast<And *>(formula.get());
            for (shared_ptr<Formula> subformula : a->getSubformulas()) {
                calculateFormulaDetails(formulaDetails, subformula, inBox,
                                        curLevelDia);
            }
        } break;

        case FBox: {
            if (!inBox) {
                formulaDetails.maxLevelDia =
                    max(formulaDetails.maxLevelDia, curLevelDia);
            }
            Box *b = dynamic_cast<Box *>(formula.get());
            formulaDetails.diffBox.insert(formula);
            calculateFormulaDetails(
                formulaDetails,
                Box::create(b->getModality(), b->getPower() - 1,
                            b->getSubformula()),
                true, 0);
        } break;

        case FDiamond: {
            Diamond *d = dynamic_cast<Diamond *>(formula.get());
            if (inBox) {
                formulaDetails.diffDia.insert(formula);
            } else {
                curLevelDia += 1;
            }

            calculateFormulaDetails(
                formulaDetails,
                Diamond::create(d->getModality(), d->getPower() - 1,
                                d->getSubformula()),
                inBox, curLevelDia);
        } break;

        case FOr: {
            Or *a = dynamic_cast<Or *>(formula.get());
            for (shared_ptr<Formula> subformula : a->getSubformulas()) {
                calculateFormulaDetails(formulaDetails, subformula, inBox,
                                        curLevelDia);
            }
        } break;
    }
}

vector<shared_ptr<Trieform>> Trieform::getTopSort() {
    visited.clear();
    topSort.clear();
    topSortDfs();
    reverse(topSort.begin(), topSort.end());
    return topSort;
}

void Trieform::topSortDfs() {
    if (visited.find(shared_from_this()) != visited.end()) return;
    visited.insert(shared_from_this());

    for (auto modTrie : subtrieMap) {
        modTrie.second->topSortDfs();
    }

    topSort.push_back(shared_from_this());
}


void Trieform::unravel(int depth, bool terminate) {
    if (depth == 0) {
        if (terminate) {
            clauses.eraseBoxClauses();
            clauses.eraseDiamondClauses();
        }
    } else {
        shared_ptr<Trieform> succ = nullptr; 
        for (ModalClause diaClause : clauses.getDiamondClauses()) {
            if (!terminate) {
                // only create one successor
                if (succ == nullptr) {
                    if (!hasSubtrie(diaClause.modality)) {
                        getSubtrieOrEmpty(diaClause.modality);
                        subtrieMap[diaClause.modality]->overShadow(shared_from_this(),
                                                                   diaClause.modality);
                        succ = subtrieMap[diaClause.modality];
                    }
                } else {
                    subtrieMap[diaClause.modality] = succ;
                }
            } else {
                // TODO: implement this
                cout << "NOT IMPLEMENTED" << endl;
                assert (false);
            }
        }
        if (!terminate && depth == 1) {
            subtrieMap.clear();
            return;
        }
        for (auto subtrie : subtrieMap) {
            dynamic_cast<Trieform *>(subtrie.second.get())
                ->unravel(depth - 1, terminate);
        }
    }
    // cout << clauses.getDiamondClauses().size() << endl;
    // cout << clauses.getBoxClauses().size() << endl;
}

void Trieform::propRoot() {
        for (auto subtrie : subtrieMap) {
            clauses.addBoxClause({subtrie.first, True::create(), Atom::create("$root")});
        }
}
