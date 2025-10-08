#include "KripkeModelS5.h"
#include <queue>
#include <stack>

unsigned int KripkeModelS5::nextWorldId = 0;
unordered_map<unsigned int, literal_set> KripkeModelS5::worldValuations = {};
unordered_map<unsigned int, unordered_set<unsigned int>> KripkeModelS5::edges = {};

KripkeModelS5::KripkeModelS5() {}
KripkeModelS5::~KripkeModelS5() {}


int KripkeModelS5::createWorld(const literal_set &valuation)
{
    int id = static_cast<int>(nextWorldId++);
    worldValuations[id] = valuation;
    return id;
}


void KripkeModelS5::pruneWorld(const unsigned int worldId)
{
    worldValuations.erase(worldId);
    edges.erase(worldId);
    for (auto &p : edges) {
        p.second.erase(worldId);
    }
}


void KripkeModelS5::addEdge(unsigned int from, unsigned int to) {
    edges[from].insert(to);
}


void KripkeModelS5::clearEdges() {
    edges.clear();
}


void KripkeModelS5::finalizeToS5() {
    // Build undirected adjacency
    unordered_map<unsigned int, unordered_set<unsigned int>> undirected;

    // ensure every world appears
    for (const auto &p : worldValuations) {
        unsigned int id = p.first;
        undirected[id]; // ensure entry
    }

    for (const auto &p : edges) {
        unsigned int u = p.first;
        for (unsigned int v : p.second) {
            undirected[u].insert(v);
            undirected[v].insert(u);
        }
    }

    // ensure reflexive presence
    for (const auto &p : worldValuations) {
        undirected[p.first].insert(p.first);
    }

    // compute connected components (DFS)
    unordered_set<unsigned int> visited;
    vector<vector<unsigned int>> components;
    for (const auto &p : undirected) {
        unsigned int id = p.first;
        if (visited.count(id)) continue;
        vector<unsigned int> comp;
        stack<unsigned int> st;
        st.push(id);
        visited.insert(id);
        while (!st.empty()) {
            unsigned int x = st.top(); st.pop();
            comp.push_back(x);
            for (unsigned int y : undirected[x]) {
                if (!visited.count(y)) {
                    visited.insert(y);
                    st.push(y);
                }
            }
        }
        components.push_back(move(comp));
    }

    // rebuild edges as cliques on each component
    edges.clear();
    for (const auto &comp : components) {
        for (unsigned int u : comp) {
            for (unsigned int v : comp) {
                edges[u].insert(v);
            }
        }
    }
}


inline bool isAuxiliaryLiteral(const string& name) {
    return name.empty() || name[0] == 'P' || name[0] == 'x' || name[0] == '$';
}


void KripkeModelS5::print()
{
    // collect non-aux literal names
    unordered_set<string> literalNamesSet;
    for (const auto& pair : worldValuations) {
        const literal_set& literals = pair.second;
        for (const auto& literal : literals) {
            if (!isAuxiliaryLiteral(literal.getName())) {
                literalNamesSet.insert(literal.getName());
            }
        }
    }

    // sorted stable order
    vector<string> literalNames(literalNamesSet.begin(), literalNamesSet.end());
    sort(literalNames.begin(), literalNames.end());

    // map literal name -> index (1-based)
    unordered_map<string, unsigned int> literalIndex;
    for (unsigned int i = 0; i < literalNames.size(); ++i) {
        literalIndex[literalNames[i]] = i + 1;
    }

    unsigned int nWorlds = static_cast<unsigned int>(worldValuations.size());
    unsigned int maxLiteralNum = 0;
    for (const auto& name : literalNames) {
        if (name.length() > 1) { // Basic check for names like "p1", "q5"
            try {
                unsigned int currentNum = static_cast<unsigned int>(std::stoi(name.substr(1)));
                if (currentNum > maxLiteralNum) {
                    maxLiteralNum = currentNum;
                }
            } catch (const std::invalid_argument& e) {
                // Handle cases where the name isn't in the expected "p<number>" format
            }
        }
    }
    unsigned int nLiterals = maxLiteralNum;
    unsigned int nRelations = 1; // mono-modal
    unsigned int nEdges = 0;
    for (const auto &p : edges) nEdges += p.second.size();

    cout << "c #var #worlds #relations #edges\n";
    cout << "v " << nLiterals << " " << nWorlds << " " << nRelations << " " << nEdges << "\n";

    // Print valuations for each world in ascending id order
    vector<unsigned int> worldIds;
    worldIds.reserve(worldValuations.size());
    for (const auto &p : worldValuations) worldIds.push_back(p.first);
    sort(worldIds.begin(), worldIds.end());

    for (unsigned int w : worldIds) {
        const literal_set &valuation = worldValuations[w];
        vector<int> signedIds(nLiterals, 0);
        for (const auto &literal : valuation) {
            auto it = literalIndex.find(literal.getName());
            if (it == literalIndex.end()) continue;

            signedIds[it->second - 1] = literal.getPolarity() ? 1 : -1;
        }
        cout << "v ";
        for (unsigned int i = 0; i < nLiterals; ++i) {
            cout << (signedIds[i] > 0 ? "" : "-") << (i + 1) << " ";
        }
        cout << "0\n";
    }

    // Print relations using edges map
    for (unsigned int u : worldIds) {
        auto it = edges.find(u);
        if (it == edges.end()) continue;
        for (unsigned int v : it->second) {
            cout << "v r1 w" << u << " w" << v << "\n";
        }
    }
}