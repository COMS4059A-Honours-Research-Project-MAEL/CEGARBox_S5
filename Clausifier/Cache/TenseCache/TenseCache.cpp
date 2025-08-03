#include "TenseCache.h"

TenseCache::TenseCache(string prepend) : Cache(prepend) {}
TenseCache::~TenseCache() {}
shared_ptr<vector<int>> TenseCache::modalityPrefixToKey(const vector<int>& modalityPrefix) const {
    // Get sum
    vector<int> res (2);
    for (auto x : modalityPrefix) {
        while (abs(x) >= res.size()) res.push_back(0);
        res[abs(x)] += (x > 0) ? 1 : -1;
    }
    return make_shared<vector<int>>(res);

}
