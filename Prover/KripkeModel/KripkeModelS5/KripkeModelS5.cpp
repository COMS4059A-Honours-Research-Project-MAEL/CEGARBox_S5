#include "KripkeModelS5.h"

unsigned int KripkeModelS5::nextWorldId = 0;
unordered_map<unsigned int, literal_set> KripkeModelS5::worldValuations = {};
unordered_map<size_t, int> KripkeModelS5::seenWorlds = {};

KripkeModelS5::KripkeModelS5() {}
KripkeModelS5::~KripkeModelS5() {}


int KripkeModelS5::createWorld(const literal_set &valuation) {
    static LiteralSetHash literalHasher;
    literal_set canonical;
    for (auto &literal : valuation){
        if (!isAuxiliaryLiteral(literal.getName()))
            canonical.insert(literal);
    }

    size_t h = literalHasher(canonical);
    auto it = seenWorlds.find(h);
    if (it != seenWorlds.end()) {
        if (worldValuations[it->second] == canonical)
            return it->second;
    }

    int id = nextWorldId++;
    worldValuations[id] = std::move(canonical);
    seenWorlds[h] = id;
    return id;
}


void KripkeModelS5::build(shared_ptr<Node> node) {
    createWorld(node->valuation);

    for (auto &child : node->children) {
        build(child);
    }
}


void KripkeModelS5::print()
{
    // collect non-aux literal names
    unordered_set<string> literalNamesSet;
    for (const auto& pair : worldValuations) {
        const literal_set& literals = pair.second;
        for (const auto& literal : literals) {
            if (!isAuxiliaryLiteral(literal.getName()))
                literalNamesSet.insert(literal.getName());
        }
    }

    // sorted stable order
    vector<string> literalNames(literalNamesSet.begin(), literalNamesSet.end());
    std::sort(literalNames.begin(), literalNames.end(),
        [](const std::string& a, const std::string& b) {
            return stoi(a.substr(1)) < stoi(b.substr(1));
    });

    unsigned int nWorlds = static_cast<unsigned int>(worldValuations.size());
    unsigned int nLiterals = stoi(literalNames[literalNames.size() - 1].substr(1));
    unsigned int nRelations = 1; // mono-modal
    unsigned int nEdges = nWorlds * nWorlds;

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
            auto it = find(literalNames.begin(), literalNames.end(), literal.getName());
            if (it == literalNames.end()) continue;

            signedIds[stoi(literal.getName().substr(1)) - 1] = literal.getPolarity() ? 1 : -1;
        }
        cout << "v ";
        for (unsigned int i = 0; i < nLiterals; ++i) {
            cout << (signedIds[i] > 0 ? "" : "-") << (i + 1) << " ";
        }
        cout << "0\n";
    }

    // Print relations using edges map
    for (unsigned int i = 0; i < nWorlds; i++) {
        for (unsigned int j = 0; j < nWorlds; j++) {
            cout << "v r1 " << "w" << i << " w" << j << "\n";
        }
    }
}
