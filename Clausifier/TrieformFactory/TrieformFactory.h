#ifndef TRIEFORM_FACTORY_H
#define TRIEFORM_FACTORY_H

#include <memory>

#include "../../Formula/Formula/Formula.h"
#include "../Trieform/Trieform.h"

using namespace std;

class TrieformFactory {
   public:
    static shared_ptr<Trieform> makeTrie(const shared_ptr<Formula> &formula,
                                         SolverConstraints constraints);

    static shared_ptr<Trieform> makeTrieS5(
        const shared_ptr<Formula> &formula,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieS5(
        const shared_ptr<Formula> &formula, const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieS5(
        const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
};

#endif
