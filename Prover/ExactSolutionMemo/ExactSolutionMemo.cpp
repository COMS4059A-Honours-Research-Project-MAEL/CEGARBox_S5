#include "ExactSolutionMemo.h"

ExactSolutionMemo::ExactSolutionMemo() {}
ExactSolutionMemo::~ExactSolutionMemo() {}

LocalSolutionMemoResult
ExactSolutionMemo::getFromMemo(const literal_set &assumptions) const {
    if (satSols.find(assumptions) != satSols.end()) {
      return {true, {true, literal_set()}};
    }
    /*
    if (unsatSols.find(assumptions) != unsatSols.end()) {
        return {true, {false, unsatSols.at(assumptions)}};
    }
    */
  return {false, {false, literal_set()}};
}

void ExactSolutionMemo::insertSat(const literal_set &assumptions) {
    satSols.insert(assumptions);
}

void ExactSolutionMemo::insertUnsat(const literal_set &assumptions,
                                    const literal_set &unsatCore) {
  unsatSols[assumptions] = unsatCore;
}

