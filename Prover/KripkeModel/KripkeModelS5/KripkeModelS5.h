#ifndef KRIPKE_MODEL_S5
#define KRIPKE_MODEL_S5

#include <iostream>
#include <memory>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <map>
#include <vector>
#include <algorithm>

#include "../../Literal/Literal.h"
#include "../../../Clausifier/Cache/Cache.h"
#include "../../../Clausifier/Cache/PrefixCache/PrefixCache.h"

using namespace std;


// ============================================================
// Node structure for model construction
// ============================================================
struct Node {
    shared_ptr<Node> parent;
    literal_set valuation;
    vector<shared_ptr<Node>> children;
};


// ============================================================
// Kripke Model (S5)
// ============================================================
class KripkeModelS5 {
private:
    static unsigned int nextWorldId;
    static unordered_map<unsigned int, literal_set> worldValuations;
    static unordered_map<size_t, int> seenWorlds;

    inline bool isAuxiliaryLiteral(const string &name) const {
        return name.empty() || name[0] == '$';
    }

public:
    KripkeModelS5();
    ~KripkeModelS5();

    int createWorld(const literal_set &valuation);
    void build(shared_ptr<Node> root);
    void print();
};

#endif
