#include "GlobalCache.h"

GlobalCache::GlobalCache(string prepend) : Cache(prepend) {}

GlobalCache::~GlobalCache() {}

shared_ptr<vector<int>> GlobalCache::modalityPrefixToKey(const vector<int>& modalityPrefix) const {
    return make_shared<vector<int>>(vector<int> ());
}
