#ifndef TRIEFORM_PROVER_Kt
#define TRIEFORM_PROVER_Kt

#include "../../../Bitset/Bitset.h"
#include "../../../Clausifier/Trieform/Trieform.h"
#include "../../../Clausifier/TrieformFactory/TrieformFactory.h"
#include "../../LocalSolutionMemo/LocalSolutionMemo.h"
#include "../../ProbationSolutionMemo/ProbationSolutionMemo.h"
#include <memory>
#include <string>
#include <unordered_map>
#include <map>
#include <set>

using namespace std;

class TrieformProverKt : public Trieform {
protected:
  shared_ptr<vector<int>> modalContext;
  int numRelations = -1;
  vector<pair<int, literal_set>> pastModels;
  vector<literal_set> occ;

  // For restarting
  bool shouldRestart = false;
  static int restartUntil;

  LocalSolutionMemo localMemo;
  shared_ptr<unordered_map<string, unsigned int>> idMap = make_shared<unordered_map<string, unsigned int>>();
unsigned int assumptionsSize; 
  static shared_ptr<unordered_map<string, unsigned int>> globalIdMap;
  shared_ptr<Bitset> convertAssumptionsToBitset(literal_set literals);
  void updateSolutionMemo(const shared_ptr<Bitset> &assumptions,
                          Solution solution);
  unsigned int checkClauseAgainstPastModels(int restartUntil, literal_set clause);
  
int isInHistory(vector<pair<int, shared_ptr<Bitset>>> history, shared_ptr<Bitset> bitset);
vector<pair<int, shared_ptr<Bitset>>> history;
shared_ptr<Bitset> fleshedOutAssumptionBitset(literal_set model);
vector<literal_set> getAllConflicts(int modality, vector<literal_set> nextModalContextConflicts);

public:
  TrieformProverKt();
  ~TrieformProverKt();
  
  static map<vector<int>, shared_ptr<TrieformProverKt>> all_trieforms;
  static ProbationSolutionMemo probationMemo;
  virtual shared_ptr<TrieformProverKt> convertToGrid(vector<int>& modal_context);
  Solution prove(literal_set assumptions = literal_set());
  Solution prove(int depth, literal_set assumptions = literal_set());
  vector<literal_set> allConflicts;
  virtual void getStats();
  virtual void preprocess();
   void doResiduation();
  virtual void buildConnections();
  virtual void removeTrueAndFalse();
  virtual void prepareSAT(name_set extra = name_set());

  virtual shared_ptr<Trieform> create(const shared_ptr<Formula> &formula);
  virtual shared_ptr<Trieform> create(const shared_ptr<Formula> &formula,
                                      const vector<int> &newModality);
  virtual shared_ptr<Trieform> create(const vector<int> &newModality);
  string toString();

  shared_ptr<TrieformProverKt> createGridTrie();


    virtual void reduceClauses();
};

#endif
