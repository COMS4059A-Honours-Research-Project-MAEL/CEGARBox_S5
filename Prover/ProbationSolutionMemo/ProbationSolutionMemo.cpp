#include "ProbationSolutionMemo.h"

ProbationSolutionMemo::ProbationSolutionMemo() {}
ProbationSolutionMemo::~ProbationSolutionMemo() {}

ProbationSolutionMemoResult
ProbationSolutionMemo::getFromMemo(const shared_ptr<vector<int>> &modalContext, const shared_ptr<Bitset> &assumptions) const {
    //cout << "GET PROB: " << satSols.size() << endl;
    for (auto satisfiable : satSols) {
        if (*satisfiable.first == *modalContext) {
            //cout << "HERE NOW" << endl;
            if (satisfiable.second->contains(*assumptions)) {
                return {true, {true, literal_set()}};
            }
        }
    }
    return {false, {false, literal_set()}};
}

void ProbationSolutionMemo::insertSat(const shared_ptr<vector<int>> &modalContext, const shared_ptr<Bitset> &assumptions, literal_set model) {
    satSols.push_back({modalContext, assumptions});
}

void ProbationSolutionMemo::clear() {
    satSols.clear();
}
void ProbationSolutionMemo::resize(int n) {
    satSols.resize(n);
}
int ProbationSolutionMemo::size() {
    return satSols.size();
}

void ProbationSolutionMemo::updateMinimalRoot(int newMinimalRoot) {
    if (minimalRoot == -1) minimalRoot = newMinimalRoot;  
    else minimalRoot = min(minimalRoot, newMinimalRoot);
}

ProbationSolutionMemoState ProbationSolutionMemo::getState() {
    return {minimalRoot, satSols.size()};
}

void ProbationSolutionMemo::setState(ProbationSolutionMemoState pastInfo) {
    //if (satSols.size() != pastInfo.second)
    //    cout << "SETTING: " << satSols.size() << " -> " << pastInfo.second << endl;
    minimalRoot = pastInfo.first;
    satSols.resize(pastInfo.second);
    pastModels.resize(pastInfo.second);
}

 vector<pair<shared_ptr<vector<int>>, shared_ptr<Bitset>>> ProbationSolutionMemo::getSatSols() const {
    return satSols;
}
vector<pair<shared_ptr<vector<int>>, pair<shared_ptr<Bitset>, shared_ptr<literal_set>>>> ProbationSolutionMemo::getSatSolsAndModels() {
vector<pair<shared_ptr<vector<int>>, pair<shared_ptr<Bitset>, shared_ptr<literal_set>>>> res;

    for (int i = 0; i < satSols.size(); ++i) {
        res.push_back(
                {satSols[i].first, {satSols[i].second, pastModels[i]}}
        );
    }
     for (auto x : satSols) {

     }
    return res;
}

void ProbationSolutionMemo::addPastModel(shared_ptr<literal_set> model) {
    pastModels.push_back(model);
}

ProbationCache addProbationCache(ProbationCache& p1, ProbationCache& p2) {
    vector<shared_ptr<Bitset>> combinedCache;
    combinedCache.insert(combinedCache.end(), p1.cache.begin(), p1.cache.end());
    combinedCache.insert(combinedCache.end(), p2.cache.begin(), p2.cache.end());
    return {min(p1.minimalRoot, p2.minimalRoot), combinedCache};
}

bool ProbationCache::contains(shared_ptr<Bitset> assumps) {
    for (auto x : cache) {
        if (x->contains(*assumps)) return true;
    }
    return false;
}
