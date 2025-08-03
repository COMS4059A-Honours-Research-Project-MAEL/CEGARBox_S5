#ifndef TRIEFORM_PROVER_K4
#define TRIEFORM_PROVER_K4

#include "../../../Bitset/Bitset.h"
#include "../../../Clausifier/Trieform/Trieform.h"
#include "../../../Clausifier/TrieformFactory/TrieformFactory.h"
#include "../../LocalSolutionMemo/LocalSolutionMemo.h"
#include <memory>
#include <string>
#include <unordered_map>

using namespace std;

class TrieformProverK4 : public Trieform {
protected:
  static shared_ptr<Cache> persistentCache;
    static map<vector<int>, shared_ptr<Trieform>> all_trieforms;

  unsigned int assumptionsSize = 0;
  LocalSolutionMemo localMemo;
  unordered_map<string, unsigned int> idMap;

  shared_ptr<Bitset> convertAssumptionsToBitset(literal_set literals);
  void updateSolutionMemo(const shared_ptr<Bitset> &assumptions,
                          Solution solution);
    int isInHistory(vector<pair<int, shared_ptr<Bitset>>> history, shared_ptr<Bitset> bitset);

    vector<pair<int, shared_ptr<Bitset>>> history;
  void makePersistence();
  void propagateLevels();

    static int restartUntil;
    unsigned int checkClauseAgainstPastModels(int restartUntil, literal_set clause);
    vector<pair<int, literal_set>> pastModels;
  vector<literal_set> allConflicts;

public:
  TrieformProverK4();
  ~TrieformProverK4();

  static ProbationSolutionMemo probationMemo;

  Solution prove(literal_set assumptions = literal_set());
  Solution prove(int depth, literal_set assumptions = literal_set());
  virtual void preprocess();
  void prepareSAT(name_set extra = name_set());

  virtual shared_ptr<Bitset> fleshedOutAssumptionBitset(literal_set model);
  virtual shared_ptr<Trieform> create(const shared_ptr<Formula> &formula);
  virtual shared_ptr<Trieform> create(const shared_ptr<Formula> &formula,
                                      const vector<int> &newModality);
  virtual shared_ptr<Trieform> create(const vector<int> &newModality);

  void fillTrieformMap();
void propLearnClause(literal_set learnClause);
};

#endif
