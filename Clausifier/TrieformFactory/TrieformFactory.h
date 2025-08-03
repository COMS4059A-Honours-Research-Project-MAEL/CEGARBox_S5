#ifndef TRIEFORM_FACTORY_H
#define TRIEFORM_FACTORY_H

#include <memory>

#include "../../Formula/Formula/Formula.h"
#include "../Cache/GlobalCache/GlobalCache.h"
#include "../Cache/TenseCache/TenseCache.h"
#include "../Trieform/Trieform.h"

using namespace std;

class TrieformFactory {
   public:
    static shared_ptr<Trieform> makeTrie(const shared_ptr<Formula> &formula,
                                         SolverConstraints constraints);

    static shared_ptr<Trieform> makeTrieK(
        const shared_ptr<Formula> &formula,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieK(
        const shared_ptr<Formula> &formula, const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieK(
        const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());


    static shared_ptr<Trieform> makeTrieKDag(
        const shared_ptr<Formula> &formula,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieKDag(
        const shared_ptr<Formula> &formula, const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieKDag(
        const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());

    static shared_ptr<Trieform> makeTrieKGlobal(
        const shared_ptr<Formula> &formula,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieKGlobal(
        const shared_ptr<Formula> &formula, const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieKGlobal(
        const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());

    static shared_ptr<Trieform> makeTrieD(
        const shared_ptr<Formula> &formula,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieD(
        const shared_ptr<Formula> &formula, const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieD(
        const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());

    static shared_ptr<Trieform> makeTrieKT(
        const shared_ptr<Formula> &formula,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieKT(
        const shared_ptr<Formula> &formula, const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieKT(
        const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());

    static shared_ptr<Trieform> makeTrieT(
        const shared_ptr<Formula> &formula,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieT(
        const shared_ptr<Formula> &formula, const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieT(
        const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());

    static shared_ptr<Trieform> makeTrieKB(
        const shared_ptr<Formula> &formula,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieKB(
        const shared_ptr<Formula> &formula, const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieKB(
        const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());

    static shared_ptr<Trieform> makeTrieDB(
        const shared_ptr<Formula> &formula,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieDB(
        const shared_ptr<Formula> &formula, const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieDB(
        const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());

    static shared_ptr<Trieform> makeTrieB(
        const shared_ptr<Formula> &formula,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieB(
        const shared_ptr<Formula> &formula, const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieB(
        const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());

    static shared_ptr<Trieform> makeTrieK4(
        const shared_ptr<Formula> &formula,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieK4(
        const shared_ptr<Formula> &formula, const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieK4(
        const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());

    static shared_ptr<Trieform> makeTrieD4(
        const shared_ptr<Formula> &formula,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieD4(
        const shared_ptr<Formula> &formula, const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieD4(
        const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());

    static shared_ptr<Trieform> makeTrieS4(
        const shared_ptr<Formula> &formula,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieS4(
        const shared_ptr<Formula> &formula, const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieS4(
        const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());

    static shared_ptr<Trieform> makeTrieS5(
        const shared_ptr<Formula> &formula,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieS5(
        const shared_ptr<Formula> &formula, const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieS5(
        const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());

    static shared_ptr<Trieform> makeTrieKB5(
        const shared_ptr<Formula> &formula,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieKB5(
        const shared_ptr<Formula> &formula, const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieKB5(
        const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());

    static shared_ptr<Trieform> makeTrieK5(
        const shared_ptr<Formula> &formula,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieK5(
        const shared_ptr<Formula> &formula, const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieK5(
        const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());

    static shared_ptr<Trieform> makeTrieD5(
        const shared_ptr<Formula> &formula,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieD5(
        const shared_ptr<Formula> &formula, const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieD5(
        const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());

    static shared_ptr<Trieform> makeTrieK45(
        const shared_ptr<Formula> &formula,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieK45(
        const shared_ptr<Formula> &formula, const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieK45(
        const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());

    static shared_ptr<Trieform> makeTrieD45(
        const shared_ptr<Formula> &formula,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieD45(
        const shared_ptr<Formula> &formula, const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieD45(
        const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());

    static shared_ptr<Trieform> makeTrieKt(
        const shared_ptr<Formula> &formula,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieKt(
        const shared_ptr<Formula> &formula, const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
    static shared_ptr<Trieform> makeTrieKt(
        const vector<int> &newModality,
        shared_ptr<Trieform> trieParent = shared_ptr<Trieform>());
};

#endif
