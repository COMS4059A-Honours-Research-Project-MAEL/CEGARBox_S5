#ifndef TRIEFORM_PROVER_K5
#define TRIEFORM_PROVER_K5

#include "../../../Bitset/Bitset.h"
#include "../../../Clausifier/Trieform/Trieform.h"
#include "../../../Clausifier/TrieformFactory/TrieformFactory.h"
#include "../../LocalSolutionMemo/LocalSolutionMemo.h"
#include <memory>
#include <string>
#include <unordered_map>

using namespace std;

class TrieformProverK5 : public Trieform {
protected:
  static shared_ptr<Cache> persistentCache;
  unsigned int assumptionsSize = 0;
  LocalSolutionMemo localMemo;
  unordered_map<string, unsigned int> idMap;

  shared_ptr<Bitset> convertAssumptionsToBitset(literal_set literals);
  void updateSolutionMemo(const shared_ptr<Bitset> &assumptions,
                          Solution solution);


int isInHistory(vector<pair<int, shared_ptr<Bitset>>> history, shared_ptr<Bitset> bitset);

  void propagateEuclideaness();
  void reflexiveHandleBoxClauses();
  void reflexivepropagateLevels();
  void pruneTrie();
  void makePersistence();
vector<pair<int, literal_set>> pastModels;
  
  vector<pair<int, shared_ptr<Bitset>>> history;
    static int restartUntil;
  static map<vector<int>, shared_ptr<Trieform>> all_trieforms;
    void globallyAddClauses(const FormulaTriple &otherClauses);
    shared_ptr<modal_clause_set> getAllBoxClauses5();

public:
  TrieformProverK5();
  ~TrieformProverK5();

  static ProbationSolutionMemo probationMemo;

  Solution prove(vector<shared_ptr<Bitset>> history, literal_set assumptions);
 virtual Solution prove(literal_set assumptions);
  Solution prove(int depth, literal_set assumptions = literal_set());
  virtual void preprocess();
  virtual void prepareSAT(name_set extra = name_set());

  virtual shared_ptr<Trieform> create(const shared_ptr<Formula> &formula);
  virtual shared_ptr<Trieform> create(const shared_ptr<Formula> &formula,
                                      const vector<int> &newModality);
  virtual shared_ptr<Trieform> create(const vector<int> &newModality);
unsigned int checkClauseAgainstPastModels(int restartUntil, literal_set clause);
  vector<literal_set> allConflicts;
shared_ptr<Bitset> fleshedOutAssumptionBitset(literal_set model);
};

#endif
