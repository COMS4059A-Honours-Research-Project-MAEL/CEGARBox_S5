#ifndef TRIEFORM_PROVER_KDAG
#define TRIEFORM_PROVER_KDAG

#include <memory>
#include <string>
#include <unordered_map>
#include <typeinfo>

#include "../../../Bitset/Bitset.h"
#include "../../../Clausifier/Trieform/Trieform.h"
#include "../../../Clausifier/TrieformFactory/TrieformFactory.h"
#include "../../LocalSolutionMemo/LocalSolutionMemo.h"
#include "../../ExactSolutionMemo/ExactSolutionMemo.h"

using namespace std;

class TrieformProverKDag : public Trieform {
   protected:
    unsigned int assumptionsSize = 0;
    LocalSolutionMemo localMemo;
    ExactSolutionMemo exactMemo;
    unordered_map<string, unsigned int> idMap;

    shared_ptr<Bitset> convertAssumptionsToBitset(literal_set literals);
    void updateSolutionMemo(const literal_set &assumptions, const shared_ptr<Bitset> &assumptionsBitset,
                            Solution solution);

    bool isExact = false;
    void boxClausesT();
    void modalContextsT();

   public:
    void forwardProp();
    TrieformProverKDag();
    ~TrieformProverKDag();

    static shared_ptr<Cache> persistentCache;

    vector<literal_set> allConflicts;

    Solution prove(literal_set assumptions = literal_set());
    Solution prove(int depth, literal_set assumptions = literal_set());
    virtual void preprocess();
    virtual void prepareSAT(name_set extra = name_set());
    virtual shared_ptr<Bitset> fleshedOutAssumptionBitset(literal_set model);

    virtual shared_ptr<Trieform> create(const shared_ptr<Formula> &formula);
    virtual shared_ptr<Trieform> create(const shared_ptr<Formula> &formula,
                                        const vector<int> &newModality);
    virtual shared_ptr<Trieform> create(const vector<int> &newModality);
    bool clauseConflictsWithModel(literal_set clause, literal_set model);

    void localReductionT();
    void localReductionD();
    void localReduction5();
    void localReductionTense();
    modal_clause_set uniqueBoxLHS5();
    modal_clause_set uniqueDiamondLHS5();
    modal_clause_set presistentBoxes5();

    shared_ptr<modal_clause_set> getAllBoxClauses5();
    void getAllClauses(shared_ptr<FormulaTriple> allClauses);

    void globallyAddClauses(const FormulaTriple &otherClauses);

    void localReductionB();
    void propagateSymmetry();
    void propagateSymmetricBoxes();

    void localReduction4(FormulaDetails formulaDetails);
    void propagateLevels4();
    void persistentBoxes4();
    void globalToLocal(int depth = 0);

    void propagateLearntClauses(vector<literal_set>& formula); 
    void propagateLearntClausesHelper(vector<literal_set>& formula); 
    void prepareSATHelper(name_set extra);

    pair<int, literal_set> model;
    static int restartUntil;
    static vector<pair<int, literal_set>> pastModels;
    unsigned int checkClauseAgainstPastModels(int restartUntil, literal_set clause);


};

#endif
