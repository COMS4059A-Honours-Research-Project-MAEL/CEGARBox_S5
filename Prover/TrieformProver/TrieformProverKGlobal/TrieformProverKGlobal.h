#ifndef TRIEFORM_PROVER_KGLOBAL
#define TRIEFORM_PROVER_KGLOBAL

#include "../../../Bitset/Bitset.h"
#include "../../../Clausifier/Trieform/Trieform.h"
#include "../../../Clausifier/TrieformFactory/TrieformFactory.h"
#include "../../LocalSolutionMemo/LocalSolutionMemo.h"
#include "../../ProbationSolutionMemo/ProbationSolutionMemo.h"
#include <memory>
#include <string>
#include <unordered_map>

using namespace std;

class TrieformProverKGlobal : public Trieform {
protected:

  static unordered_map<literal_set, int, LiteralSetHash, LiteralSetEqual> vertexLabel;
  static unordered_map<literal_set, literal_set, LiteralSetHash, LiteralSetEqual> modelCache;
  static shared_ptr<Cache> persistentCache;
  unsigned int assumptionsSize = 0;
  LocalSolutionMemo localMemo;
  unordered_map<string, unsigned int> idMap;

  shared_ptr<Bitset> convertAssumptionsToBitset(literal_set literals);
  void updateSolutionMemo(const shared_ptr<Bitset> &assumptions,
                          Solution solution);

    void boxClausesT();
    void modalContextsT();



    vector<pair<int, literal_set>> pastModels;
    vector<pair<int, shared_ptr<Bitset>>> history;
    
    static int restartUntil;
    unsigned int checkClauseAgainstPastModels(int restartUntil, literal_set clause);

    int solveLocallyDepth = -1;
    unordered_map<literal_set, int, LiteralSetHash, LiteralSetEqual> occ;


 void globallyAddClauses(const FormulaTriple &otherClauses);
 void forwardProp();

public:
  TrieformProverKGlobal();
  ~TrieformProverKGlobal();

  static ProbationSolutionMemo probationMemo;
  static map<vector<int>, shared_ptr<Trieform>> all_trieforms;

  vector<literal_set> allConflicts;

  Solution prove(literal_set assumptions = literal_set());
  pair<Solution,int> prove(int depth, literal_set assumptions = literal_set());
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

  shared_ptr<modal_clause_set> getAllBoxClauses5();
  void globallyAddBoxClauses(shared_ptr<modal_clause_set> boxClauses);

    void globalReduction5();
  void localReductionB();
  void propagateSymmetry();
  void propagateSymmetricBoxes();


  void globalReduction4();
    void propagateLevels4();
    void persistentBoxes4();
    int isInHistory(vector<pair<int, shared_ptr<Bitset>>> history, shared_ptr<Bitset> bitset);
    void addGlobalAssumptions(shared_ptr<Trieform> globalAssumptions);
    void cutReflexiveLeaves(shared_ptr<Trieform> globalAssumptions);
};

#endif
