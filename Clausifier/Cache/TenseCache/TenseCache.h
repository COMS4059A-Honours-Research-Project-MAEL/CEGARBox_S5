#ifndef TENSE_CACHE
#define TENSE_CACHE

#include <vector>
#include "../../Cache/Cache.h"

using namespace std;

class TenseCache : public Cache {
    public:
        TenseCache(string prepend);
        ~TenseCache();
        virtual shared_ptr<vector<int>> modalityPrefixToKey(const vector<int>& modalityPrefix) const;
};

#endif
