#ifndef BITSET_H
#define BITSET_H

#include <climits>
#include <iostream>

using namespace std;

class Bitset {
private:
  unsigned int size = 0;
  unsigned int bitsPerBucket = 0; // CHAR_BIT * sizeof(int);
  unsigned int buckets = 0;       //(size + bitsPerBucket - 1) / bitsPerBucket;
  unsigned int *bitArray;
  std::hash<int> int_hash;
  mutable int hash_;
  mutable bool shouldCalculateHash = true;
  unsigned int *orig;

public:
  Bitset(const unsigned int bits);
  ~Bitset();

  void set(const unsigned int bit);
  void reset(const unsigned int bit);

  bool contains(const Bitset &other) const;
  bool isContainedBy(const Bitset &other) const;
  unsigned int operator[](const unsigned int &bucket) const;

  void print() const;
  
  bool operator==(const Bitset &other) const;
  bool operator!=(const Bitset &other) const;

  size_t hash() const;
};

struct BitsetHash {
  std::size_t operator()(Bitset const &l) const { return l.hash(); }
};
struct BitsetEqual {
  size_t operator()(Bitset const &a, Bitset const &b) const { return a == b; }
};
#endif
