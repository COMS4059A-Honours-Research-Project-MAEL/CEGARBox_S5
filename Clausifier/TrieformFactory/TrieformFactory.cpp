#include "TrieformFactory.h"

shared_ptr<Trieform> TrieformFactory::makeTrie(const shared_ptr<Formula> &formula, SolverConstraints constraints) {
    shared_ptr<Formula> newFormula = formula;
    
    // There are issues if we have a -> [] b and a -> phi
    Trieform::ensureUniqueModalClauseLhs = true;
    Trieform::stringModalContexts = true;

    formula_set orSet;
    orSet.insert(Not::create(Atom::create("$root")));
    orSet.insert(formula);

    newFormula = Or::create(orSet);

    if (constraints.oneSat) {
        Trieform::useOneSat = true;
    }

    if (constraints.constructModel){
        Trieform::constructModel = true;
    }
    
    return makeTrieS5(newFormula);
}
