#include "TrieformFactory.h"

shared_ptr<Trieform> TrieformFactory::makeTrie(
    const shared_ptr<Formula> &formula, SolverConstraints constraints) {
    shared_ptr<Formula> newFormula = formula;
    
    if (constraints.euclidean || constraints.transitive) {
        // There are issues if we have a -> [] b and a -> phi
        Trieform::ensureUniqueModalClauseLhs = true;
        //Trieform::stringModalContexts = true;
    }
    if (constraints.tense || constraints.oneSat || constraints.symmetric || constraints.euclidean || constraints.transitive || constraints.usingGlobalAssumps) {
        Trieform::stringModalContexts = true;

        formula_set orSet;
        orSet.insert(Not::create(Atom::create("$root")));
        orSet.insert(formula);

        newFormula = Or::create(orSet);
    }

    if (constraints.tense) {
        Trieform::cache = make_shared<TenseCache>("x");
    }
    if (constraints.oneSat) {
        // Trieform::cache = make_shared<GlobalCache>("x");
        Trieform::useOneSat = true;
    }
    
    if (constraints.useDag) {
        return makeTrieKDag(newFormula);
    } else if (constraints.usingGlobalAssumps) {
        return makeTrieKGlobal(newFormula);
    } else if (constraints.localReduction) {
        return makeTrieK(newFormula);
    } else if (constraints.tense) {
        return makeTrieKt(newFormula);
    } else if (constraints.globalReduction) {
        return makeTrieKGlobal(newFormula);
    } else if ((constraints.reflexive && constraints.euclidean) ||
               (constraints.symmetric && constraints.euclidean) ||
               (constraints.reflexive && constraints.symmetric &&
                constraints.transitive) ||
               (constraints.serial && constraints.symmetric &&
                constraints.transitive) ||
               (constraints.serial && constraints.symmetric &&
                constraints.euclidean)) {
        return makeTrieS5(newFormula);
    } else if (constraints.symmetric &&
               (constraints.euclidean || constraints.transitive)) {
        return makeTrieKB5(newFormula);
    }
    if (constraints.reflexive && constraints.symmetric) {
        return makeTrieB(newFormula);
    } else if (constraints.serial && constraints.symmetric) {
        return makeTrieDB(newFormula);
    } else if (constraints.reflexive && constraints.transitive) {
        return makeTrieS4(newFormula);
    } else if (constraints.serial && constraints.transitive &&
               constraints.euclidean) {
        return makeTrieD45(newFormula);
    } else if (constraints.transitive && constraints.euclidean) {
        return makeTrieK45(newFormula);
    } else if (constraints.serial && constraints.transitive) {
        return makeTrieD4(newFormula);
    } else if (constraints.serial && constraints.euclidean) {
        return makeTrieD5(newFormula);
    } else if (constraints.reflexive) {
        return makeTrieKT(newFormula);
    } else if (constraints.serial) {
        return makeTrieD(newFormula);
    } else if (constraints.symmetric) {
        return makeTrieKB(newFormula);
    } else if (constraints.transitive) {
        return makeTrieK4(newFormula);
    } else if (constraints.euclidean) {
        return makeTrieK5(newFormula);
    }
    return makeTrieK(newFormula);
}
