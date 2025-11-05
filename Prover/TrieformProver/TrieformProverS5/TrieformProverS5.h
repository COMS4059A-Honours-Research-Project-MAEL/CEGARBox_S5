#ifndef TRIEFORM_PROVER_S5
#define TRIEFORM_PROVER_S5

#include "../../../Bitset/Bitset.h"
#include "../../../Clausifier/Trieform/Trieform.h"
#include "../../../Clausifier/TrieformFactory/TrieformFactory.h"
#include "../../GlobalSolutionMemo/GlobalSolutionMemo.h"
#include "../../KripkeModel/KripkeModelS5/KripkeModelS5.h"
#include <memory>
#include <string>
#include <unordered_map>
#include <sstream>

using namespace std;

class TrieformProverS5 : public Trieform {
protected:
  static shared_ptr<Cache> persistentCache;

  static unsigned int assumptionsSize;
  static GlobalSolutionMemo globalMemo;
  static unordered_map<string, unsigned int> idMap;
  static KripkeModelS5 model;
  static shared_ptr<Node> root;

  shared_ptr<Bitset> convertAssumptionsToBitset(literal_set literals);
  void updateSolutionMemo(const shared_ptr<Bitset> &assumptions, Solution solution);
  bool isInHistory(vector<shared_ptr<Bitset>> history, shared_ptr<Bitset> bitset);

  void reflexiveHandleBoxClauses();
  void reflexivepropagateLevels();
  void pruneTrie();
  void makePersistence();
  void propagateSymmetricBoxes();

public:
  TrieformProverS5();
  ~TrieformProverS5();

  Solution prove(shared_ptr<Node> node, vector<shared_ptr<Bitset>> history, literal_set assumptions);
  Solution prove(vector<shared_ptr<Bitset>> history, literal_set assumptions);
  virtual Solution prove(literal_set assumptions);
  virtual void preprocess();
  virtual void prepareSAT(name_set extra = name_set());

  virtual shared_ptr<Trieform> create(const shared_ptr<Formula> &formula);
  virtual shared_ptr<Trieform> create(const shared_ptr<Formula> &formula, const vector<int> &newModality);
  virtual shared_ptr<Trieform> create(const vector<int> &newModality);

  void printModel();
};

#endif
