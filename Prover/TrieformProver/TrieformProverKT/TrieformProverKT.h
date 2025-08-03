#ifndef TRIEFORM_PROVER_KT
#define TRIEFORM_PROVER_KT

#include <memory>
#include <string>
#include <unordered_map>

#include "../../../Bitset/Bitset.h"
#include "../../../Clausifier/Trieform/Trieform.h"
#include "../../../Clausifier/TrieformFactory/TrieformFactory.h"
#include "../../LocalSolutionMemo/LocalSolutionMemo.h"

using namespace std;

class TrieformProverKT : public Trieform {
   protected:
    unsigned int assumptionsSize = 0;
    LocalSolutionMemo localMemo;
    unordered_map<string, unsigned int> idMap;

    void handleReflexiveBoxClauses();
    void propagateLevels();

    shared_ptr<Bitset> convertAssumptionsToBitset(literal_set literals);
    void updateSolutionMemo(const shared_ptr<Bitset> &assumptions,
                            Solution solution);
    bool isInHistory(vector<shared_ptr<Bitset>> history,
                     shared_ptr<Bitset> bitset);

    void boxClausesT();
    void modalContextsT();

   public:
    TrieformProverKT();
    ~TrieformProverKT();

    Solution prove(int depth, literal_set assumptions);
    virtual Solution prove(literal_set assumptions);

    virtual void preprocess();
    virtual void prepareSAT(name_set extra = name_set());

    virtual shared_ptr<Trieform> create(const shared_ptr<Formula> &formula);
    virtual shared_ptr<Trieform> create(const shared_ptr<Formula> &formula,
                                        const vector<int> &newModality);
    virtual shared_ptr<Trieform> create(const vector<int> &newModality);

    shared_ptr<Bitset> fleshedOutAssumptionBitset(literal_set model);
};

#endif
