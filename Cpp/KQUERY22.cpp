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

const int N = 30010;
const int MAX = 10010;
const int SZ = 33;
const int BN = 1010;

struct node {
  node* left;
  node* right;
  int key, cnt, sz, pri;
  node();
  inline void update() {
    sz = left->sz + right->sz + cnt;
  }
} p[N * 20];

node* const NIL = p;
node* next = p;

node::node() : left(NIL), right(NIL), pri(rand()) { }

class treap {
  inline node* left_rotate(node* x) const {
    node* y = x->right;
    x->right = y->left;
    y->left = x;
    y->sz = x->sz;
    x->update();
    return y;
  }

  inline node* right_rotate(node* x) const {
    node* y = x->left;
    x->left = y->right;
    y->right = x;
    y->sz = x->sz;
    x->update();
    return y;
  }

  node* insert(node* x, const int key) const {
    if (x == NIL) {
      x = ++next;
      x->key = key;
      x->sz = x->cnt = 1;
    } else {
      if (key == x->key) {
        ++x->cnt;
      } else if (key < x->key) {
        x->left = insert(x->left, key);
        if (x->left->pri > x->pri) x = right_rotate(x);
      } else {
        x->right = insert(x->right, key);
        if (x->right->pri > x->pri) x = left_rotate(x);
      }
      x->update();
    }
    return x;
  }

  node* erase(node* x, const int key) const {
    if (key == x->key) {
      if (x->cnt > 1) {
        --x->cnt;
      } else {
        if (x->left == NIL && x->right == NIL) {
          x = NIL;
        } else if (x->left == NIL) {
          x = x->right;
        } else if (x->right == NIL) {
          x = x->left;
        } else {
          if (x->left->pri > x->right->pri) {
            x = right_rotate(x);
            x->right = erase(x->right, key);
          } else {
            x = left_rotate(x);
            x->left = erase(x->left, key);
          }
        }
      }
    } else if (key < x->key) {
      x->left = erase(x->left, key);
    } else {
      x->right = erase(x->right, key);
    }
    x->update();
    return x;
  }

  node* root;

public:
  treap() : root(NIL) { }

  inline void insert(const int key) {
    root = insert(root, key);
  }

  inline void erase(const int key) {
    root = erase(root, key);
  }

  inline int query(const int key) const {
    int res = 0;
    node* x = root;
    while (x != p) {
      if (key <= x->key) {
        res += x->right->sz + x->cnt;
        if (key == x->key) break;
        x = x->left;
      } else {
        x = x->right;
      }
    }
    return res;
  }
} tr[BN][SZ];

int fw[BN][MAX], bf[BN], bt[BN];
int a[N], sq, bn;

inline void update(int id, int pos, int val, int k) {
  int f = pos - bf[id] + 1;
  while (f <= sq) {
    if (k == 1) {
      tr[id][f].insert(val);
    } else {
      tr[id][f].erase(val);
    }
    f += f & -f;
  }
  for (int i = id; i <= bn; i += i & -i)
    for (int j = val - 1; j >= 1; j &= j - 1)
      fw[i][j] += k;
}

inline int query(int id, int pos, int val) {
  int res = 0;
  int f = pos - bf[id] + 1;
  while (f >= 1) {
    res += tr[id][f].query(val + 1);
    f &= f - 1;
  }
  for (int i = id - 1; i >= 1; i &= i - 1)
    for (int j = val; j < MAX; j += j & -j)
      res += fw[i][j];
  return res;
}

int main() {
  assert(freopen("input.txt", "r", stdin));
  assert(freopen("output.txt", "w", stdout));
  //std::ios::sync_with_stdio(0);
  //std::cin.tie(0);
  int n;
  scanf("%d", &n);
  for (int i = 1; i <= n; ++i) scanf("%d", a + i);
  sq = pow(n, 0.3333333333);
  bn = (n - 1) / sq + 1;
  fprintf(stderr, "sq = %d\n", sq);
  fprintf(stderr, "bn = %d\n", bn);
  bf[1] = 1, bt[1] = sq;
  for (int i = 2; i <= bn; ++i) {
    bf[i] = bf[i - 1] + sq;
    bt[i] = bt[i - 1] + sq;
  }
  if (bt[bn] > n) bt[bn] = n;
  for (int i = 1; i <= bn; ++i)
    for (int j = bf[i]; j <= bt[i]; ++j)
      update(i, j, a[j], 1);
  int q;
  scanf("%d", &q);
  while (q--) {
    int k, p, f, t, v;
    scanf("%d", &k);
    if (k == 0) {
      scanf("%d %d", &p, &v);
      int pid = (p - 1) / sq + 1;
      update(pid, p, a[p], -1);
      a[p] = v;
      update(pid, p, a[p], 1);
    } else {
      scanf("%d %d %d", &f, &t, &v);
      int tid = (t - 1) / sq + 1;
      int ans = query(tid, t, v);
      if (f > 1) {
        --f;
        int fid = (f - 1) / sq + 1;
        ans -= query(fid, f, v);
      }
      printf("%d\n", ans);
    }
  }
}
