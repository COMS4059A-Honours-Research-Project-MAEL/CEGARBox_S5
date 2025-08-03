
#include "Bitset.h"
#include <immintrin.h>
#include <cstring>
#define is_aligned(POINTER, BYTE_COUNT) \
    (((uintptr_t)(const void *)(POINTER)) % (BYTE_COUNT) == 0)

Bitset::Bitset(const unsigned int bits) {
  size = bits;
  bitsPerBucket = CHAR_BIT * sizeof(int);
  buckets = (size + bitsPerBucket - 1) / bitsPerBucket;
  //buckets = (buckets + 3) / 4 * 4; // round to nearest 8
  if (buckets > 0) {
    bitArray = new unsigned int[buckets]{0};
  }
}
Bitset::~Bitset() {
  if (buckets > 0) {
    delete[] bitArray;
  }
}




void Bitset::set(const unsigned int bit) {
  // print();
    shouldCalculateHash = true;
  *(bitArray + bit / bitsPerBucket) |= 1U << (bit % bitsPerBucket);
  // print();
}

void Bitset::reset(const unsigned int bit) {
    shouldCalculateHash = true;
  *(bitArray + bit / bitsPerBucket) &= ~(1U << (bit % bitsPerBucket));
}

bool Bitset::contains(const Bitset &other) const {
  for (unsigned int i = 0; i < buckets; i++) {
    if (((~*(bitArray + i)) & *(other.bitArray + i)) != 0) {
      return false;
    }
  }
  return true;
  /*
   for (unsigned int i = 0; i < buckets; i += 4) {
    __m128i this_data = _mm_load_si128((__m128i*)(bitArray + i));
    __m128i other_data = _mm_load_si128((__m128i*)(other.bitArray + i));
    __m128i result = _mm_andnot_si128(this_data, other_data);
    if (!_mm_testz_si128(result, result)) {
      return false;
    }
  }
  return true;
  */
}

bool Bitset::isContainedBy(const Bitset &other) const {
  for (unsigned int i = 0; i < buckets; i++) {
    if ((*(bitArray + i) & ~other[i]) != 0) {
      return false;
    }
  }
  return true;
}

unsigned int Bitset::operator[](const unsigned int &bucket) const {
  return *(bitArray + bucket);
}

void Bitset::print() const {
  for (int bit = (size % bitsPerBucket) - 1; bit >= 0; bit--) {
    cout << ((*(bitArray + buckets - 1) >> bit) & 1U);
  }
  for (int bucket = buckets - 2; bucket >= 0; bucket--) {
    for (int bit = bitsPerBucket - 1; bit >= 0; bit--) {
      cout << ((*(bitArray + bucket) >> bit) & 1U);
    }
  }

  cout << endl;
}


bool Bitset::operator==(const Bitset &other) const {
    if (buckets != other.buckets) return false;
    for (int i = 0; i < buckets; i++) {
        if (bitArray[i] != other.bitArray[i]) return false;
    }
    return true;
}

bool Bitset::operator!=(const Bitset &other) const {
  return !(operator==(other));
}

size_t Bitset::hash() const  {
    if (shouldCalculateHash) {
  hash_ = 0;
  for (int i = 0; i < buckets; i++) {
      hash_ += int_hash(bitArray[i] + i);
  }
  shouldCalculateHash = false;
  }

  return hash_;
}
