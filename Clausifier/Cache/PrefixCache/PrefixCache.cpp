#include "PrefixCache.h"

PrefixCache::PrefixCache(string prepend) : Cache(prepend) {}

PrefixCache::~PrefixCache() {}
shared_ptr<vector<int>> PrefixCache::modalityPrefixToKey(const vector<int>& modalityPrefix) const {
    return make_shared<vector<int>>(modalityPrefix);
}
