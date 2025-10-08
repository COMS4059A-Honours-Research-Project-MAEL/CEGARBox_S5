#ifndef KRIPKE_MODEL_S5
#define KRIPKE_MODEL_S5

#include "../../Literal/Literal.h"
#include <iostream>
#include <memory>
#include <string>
#include <unordered_set>
#include <map>

using namespace std;


struct TraceNode {
    shared_ptr<TraceNode> parent;
    vector<shared_ptr<TraceNode>> children;
    literal_set valuation;
    vector<Literal> causeDiamonds;
};


class KripkeModelS5 {
private:
    static std::unordered_map<unsigned int, std::unordered_set<unsigned int>> edges;

public:
    static unsigned int nextWorldId;
    static std::unordered_map<unsigned int, literal_set> worldValuations;
    
    KripkeModelS5();
    ~KripkeModelS5();

    int createWorld(const literal_set &valuation);

    void addEdge(unsigned int from, unsigned int to);
    void clearEdges();
    void finalizeToS5();

    void pruneWorld(const unsigned int worldId);
    void print();
};

#endif
