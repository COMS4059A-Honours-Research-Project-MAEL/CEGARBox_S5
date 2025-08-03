#ifndef LITERAL_H
#define LITERAL_H

#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>
#include <algorithm>

using namespace std;

class Literal {
private:
  string name;
  bool polarity;

public:
  Literal(string name_, bool polarity_);
  ~Literal();

  string getName() const;
  bool getPolarity() const;

  string toString() const;

  bool operator==(const Literal &other) const;
  bool operator!=(const Literal &other) const;

  Literal operator~() const;

  size_t hash() const;
};

struct LiteralHash {
  std::size_t operator()(Literal const &l) const { return l.hash(); }
};
struct LiteralEqual {
  size_t operator()(Literal const &a, Literal const &b) const { return a == b; }
};

typedef unordered_set<Literal, LiteralHash, LiteralEqual> literal_set;
typedef unordered_map<int, literal_set> modal_literal_map;
typedef unordered_map<Literal, literal_set, LiteralHash, LiteralEqual>
    lit_implication;
typedef unordered_map<Literal, vector<literal_set>, LiteralHash, LiteralEqual>
    ltl_implications;
typedef unordered_map<int, lit_implication> modal_lit_implication;

struct LitSetImplication {
    literal_set lhs;
    Literal rhs;
};

bool isSubsetOf(literal_set set1, literal_set set2);
literal_set setDifference(literal_set set1, literal_set set2);
string litsetString(const literal_set& s);

struct Solution {
  bool satisfiable;
  literal_set conflict;
  bool shouldRestart = false;
};

struct LiteralSetHash {
    size_t operator()(const literal_set& assumptions) const {
        int hash = 0;
        for (auto x : assumptions) hash += x.hash();
        return hash;
    }
};

struct LiteralSetEqual {
    bool operator()(const literal_set& assumptions1, const literal_set& assumptions2) const {
        if (assumptions1.size() != assumptions2.size()) return false;
        for (auto x : assumptions1) {
            if (assumptions2.find(x) == assumptions2.end()) {
                return false;
            }
        }
        return true;
    }
};

#endif
