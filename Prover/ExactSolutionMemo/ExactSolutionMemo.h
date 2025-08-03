#ifndef EXACT_SOLUTION_MEMO_H
#define EXACT_SOLUTION_MEMO_H

#include "../../Bitset/Bitset.h"
#include "../Literal/Literal.h"
#include "../ProbationSolutionMemo/ProbationSolutionMemo.h"
#include "../LocalSolutionMemo/LocalSolutionMemo.h"
#include <memory>
#include <vector>

using namespace std;

class ExactSolutionMemo {
private:
    unordered_set<literal_set, LiteralSetHash, LiteralSetEqual> satSols;
  unordered_map<literal_set, literal_set, LiteralSetHash, LiteralSetEqual> unsatSols;

public:
  ExactSolutionMemo();
  ~ExactSolutionMemo();

  LocalSolutionMemoResult
  getFromMemo(const literal_set &assumptions) const;

  void insertSat(const literal_set &assumptions);
  void insertUnsat(const literal_set &assumptions,
                   const literal_set &unsatCore);
    
};

#endif
