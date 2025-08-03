#ifndef PREFIX_CACHE
#define PREFIX_CACHE

#include <vector>
#include "../../Cache/Cache.h"

using namespace std;

class PrefixCache : public Cache {
    public:
        PrefixCache(string prepend);
        ~PrefixCache();
        virtual shared_ptr<vector<int>> modalityPrefixToKey(const vector<int>& modalityPrefix) const;
};

#endif
