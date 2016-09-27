#include <algorithm>
#include <bitset>
#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstring>
#include <ctime>
#include <deque>
#include <functional>
#include <iomanip>
#include <iostream>
#include <map>
#include <queue>
#include <set>
#include <sstream>
#include <string>
#include <vector>

// miller rabin primality test header
//#include "miller_rabin_64bit.h"

typedef int                 i32;
typedef long long           i64;
typedef unsigned            u32;
typedef unsigned long long  u64;
typedef float               f32;
typedef double              f64;
typedef long double         f128;

typedef std::pair<i32, i32> p32;
typedef std::pair<i64, i64> p64;

using std::cin;
using std::cout;

const i32 inf = 1e9;

struct edge {
  u32 u, v; // edge from u to v
  i64 c;    // edge cost / weight / distance
  edge(const u32 u, const u32 v, const i64 c) :
    u(u), v(v), c(c) { }
};

// generates random i64 in range [f, t]
inline i64 random(const i64 f, const i64 t) {
  i64 x = 0;
  f128 m = t - f + 1;
  for (u32 i = 0; i < 5; ++i) {
    x += (m / 32768) * rand();
    m /= 32768;
  }
  return x + f;
}

// generates a pair in range [f, t] and their difference in range [df, dt]
inline p64 range(const i64 f, const i64 t, const i64 df, const i64 dt) {
  p64 r;
  i64 diff = 0;
  do {
    r.first = random(f, t);
    r.second = random(f, t);
    diff = r.second - r.first;
  } while (diff < df || dt < diff);
  return r;
}

// generates a tree
void gen_tree(u32 n, const u64 THR, std::vector<edge>& vt);

std::set<p64> set;

const int N = 100010;

std::pair<int, int> p[N];

int main() {
  srand(time(NULL));
  freopen("VOSCOMPS.INP", "w", stdout);
  int n = 100;
  cout << n << ' ';
  int q = 2000;
  cout << q << '\n';
  while (q--) {
    int u = random(1, n);
    int v = random(1, n);
//    if (u == v) {
//      ++q;
//      continue;
//    }
    int k = random(1, 3);
    cout << k << ' ' << u << ' ' << v << '\n';
  }
}

// pop a vertex from queue
inline u32 getv(std::priority_queue<p32>& que) {
  u32 r = que.top().second;
  que.pop();
  return r;
}

// push a vertex into queue
inline void addv(const u32 v, std::priority_queue<p32>& que) {
  que.push(p32(random(1, 100000), v));
}

void gen_tree(const u32 n, const u64 THR, std::vector<edge>& vt) {
  std::priority_queue<p32> qin, qout;
  u32 root = random(1, n);
  // qin contains vertices already in the tree
  addv(root, qin);
  // qout contains vertices have yet in the tree
  for (u32 i = 1; i <= n; ++i) if (i != root) addv(i, qout);
  // repeatly pop 2 vertices at once from queue to create an edge between them
  for (u32 i = 1; i < n; ++i) {
    u32 u = getv(qin);  addv(u, qin);
    u32 v = getv(qout); addv(v, qin);
    i64 c = random(-THR, THR);
    vt.push_back(edge(u, v, c));
  }
}
