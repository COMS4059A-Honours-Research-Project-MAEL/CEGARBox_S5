#ifndef GLOBAL_CACHE
#define GLOBAL_CACHE

#include <vector>
#include "../../Cache/Cache.h"

using namespace std;

class GlobalCache : public Cache {
    public:
        GlobalCache(string prepend);
        ~GlobalCache();
        virtual shared_ptr<vector<int>> modalityPrefixToKey(const vector<int>& modalityPrefix) const;
};

#endif
