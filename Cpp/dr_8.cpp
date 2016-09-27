#include <stdio.h>
#include <iostream>
#include <algorithm>
#include <math.h>
#include <vector>
#include <string>
#include <cstring>
#include <map>
#include <set>
#include <queue>
#include <stack>

using namespace std;

const int N = 501000;
const int LOG = 20;
const long long INF = 0x3C3C3C3C3C3C3C3CLL;

int n, q, f[N][LOG + 1], depth[N], a[N];
vector<int> ke[N], w[N];
long long d[N];

pair<long long, int> heap[N * 5];

void sub1() {
  while (q--) {
    int s, t;
    scanf("%d %d", &s, &t);
    memset(d, 0x3C, sizeof(d));
    int sz = 0;
    for (int i = 0; i < s; ++i) {
      int u;
      scanf("%d", &u);
      if (d[u] == INF) {
        d[u] = 0;
        heap[sz++] = make_pair(0, u);
        push_heap(heap, heap + sz, greater<pair<long long, int> >());
		  }
    }
    while (sz > 0) {
      long long du = heap[0].first;
      int u = heap[0].second;
      pop_heap(heap, heap + sz, greater<pair<long long, int> >());
      --sz;
      if (du != d[u]) continue;
      for (int j = 0; j < ke[u].size(); ++j) {
        int v = ke[u][j];
        if (d[v] > d[u] + w[u][j]) {
          d[v] = d[u] + w[u][j];
          heap[sz++] = make_pair(d[v], v);
          push_heap(heap, heap + sz, greater<pair<long long, int> >());
        }
      }
    }
    long long r = INF;
    for (int i = 0; i < t; ++i) {
      int u;
      scanf("%d", &u);
      r = min(r, d[u]);
    }
    printf("%lld\n", r);
  }
}

void dfs(int u, int p) {
  f[u][0] = p;
  depth[u] = depth[p] + 1;
  for (int i = 0; i < ke[u].size(); ++i) {
    int v = ke[u][i];
    if (v == p) continue;
    d[v] = d[u] + w[u][i];
    dfs(v, u);
  }
}

int lca(int u,int v) {
  if (depth[u] < depth[v]) swap(u, v);
  for (int i = LOG; i >= 0; --i)
    if (depth[u] - (1 << i) >= depth[v])
      u = f[u][i];
  if (u == v) return u;
  for (int i = LOG; i >= 0; --i)
    if (f[u][i] != f[v][i]) {
      u = f[u][i];
      v = f[v][i];
    }
  return f[u][0];
}

long long dis(int u, int v) {
  int p = lca(u, v);
  return d[u] + d[v] - (d[p] << 1);
}

void sub2() {
  memset(f, -1, sizeof(f));
  dfs(0, -1);
  for (int j = 1; 1 << j <= n; ++j)
    for (int i = 0; i < n; ++i)
      f[i][j] = f[f[i][j - 1]][j - 1];
  while (q--) {
    int s, t;
    scanf("%d %d", &s, &t);
    for (int i = 0; i < s; ++i) {
      scanf("%d", a + i);
    }
    long long r = INF;
    for (int i = 0; i < t; ++i) {
      int u;
      scanf("%d", &u);
      for (int j = 0; j < s; ++j)
        r = min(r, dis(a[j], u));
    }
    printf("%lld\n", r);
  }
}

int main() {
  freopen("factories.inp", "r", stdin);
  freopen("factories.ou1", "w", stdout);
  scanf("%d %d", &n, &q);
  for (int i = 1; i < n; ++i) {
    int u, v, c;
    scanf("%d %d %d", &u, &v, &c);
    ke[u].push_back(v);
    ke[v].push_back(u);
    w[u].push_back(c);
    w[v].push_back(c);
  }
  if (n <= 5000 && q <= 5000) sub1();
      else sub2();
  //  sub2();
}
