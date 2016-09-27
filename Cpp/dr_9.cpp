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
#include <numeric>
#include <queue>
#include <set>
#include <sstream>
#include <string>
#include <vector>

#define DEBUG(z, x) { cerr << setw(z) << "" << (#x) << " = " << (x) << '\n'; }

using namespace std;

const int N = 100010;
const long long INF = 1LL << 50;

struct edge {
  int to, dist;
  edge(int to, int dist) : to(to), dist(dist) { }
};

vector<edge> graph[N];
vector<int> q1[N], q2[N];
bool used[N], mark[N];
int sub[N], idx[N], q[N];
long long dist[N], ans[N], b1[N], b2[N];

void dfs_sz(int u, int p) {
  sub[u] = 1;
  for (int i = 0; i < graph[u].size(); ++i) {
    int v = graph[u][i].to;
    if (v == p) continue;
    if (mark[v]) {
      swap(graph[u][i], graph[u].back());
      graph[u].pop_back();
    } else {
      dfs_sz(v, u);
      sub[u] += sub[v];
    }
  }
}

int dfs_center(int u, int p, int anc) {
  int total = anc + sub[u];
  if (anc << 1 > total) return 0;
  int f = 1;
  for (int i = 0; i < graph[u].size() && f; ++i) {
    int v = graph[u][i].to;
    if (v == p) continue;
    f = sub[v] << 1 <= total;
  }
  if (f) return u;
  for (int i = 0; i < graph[u].size(); ++i) {
    int v = graph[u][i].to;
    if (v == p) continue;
    int x = dfs_center(v, u, total - sub[v]);
    if (x) return x;
  }
  return 0;
}

void dfs_dist(int u, int p) {
  for (int i = 0; i < graph[u].size(); ++i) {
    int v = graph[u][i].to;
    if (v == p) continue;
    dist[v] = dist[u] + graph[u][i].dist;
    dfs_dist(v, u);
  }
}

bool cmp(int i, int j) {
  return sub[i] < sub[j];
}

void solve(int root) {
  dfs_sz(root, -1);
  int ct = dfs_center(root, -1, 0);
  dist[ct] = 0;
  dfs_dist(ct, -1);
  int sz = graph[ct].size();
  for (int i = 0; i < sz; ++i) {
    idx[i] = i;
  }
  sort(idx, idx + sz, cmp);
  used[ct] = 1;
  vector<int> e1, e2;
  for (int i = 0; i < q1[ct].size(); ++i) {
    int id = q1[ct][i];
    b1[id] = 0;
    e1.push_back(id);
  }
  for (int i = 0; i < q2[ct].size(); ++i) {
    int id = q2[ct][i];
    if (b1[id] == 0) ans[id] = 0;
    b2[id] = 0;
    e2.push_back(id);
  }
  for (int i = 0; i < sz; ++i) {
    int u = graph[ct][i].to;
    int tail = 0;
    q[tail++] = u;
    used[u] = 1;
    for (int head = 0; head < tail; ++head) {
      int v = q[head];
      for (int j = 0; j < q1[v].size(); ++j) {
        int id = q1[v][j];
        ans[id] = min(ans[id], b2[id] + dist[v]);
      }
      for (int j = 0; j < q2[v].size(); ++j) {
        int id = q2[v][j];
        ans[id] = min(ans[id], b1[id] + dist[v]);
      }
      for (int j = 0; j < graph[v].size(); ++j) {
        int z = graph[v][j].to;
        if (!used[z]) {
          used[z] = 1;
          q[tail++] = z;
        }
      }
    }
    for (int j = 0; j < tail; ++j) {
      int u = q[j];
      for (int j = 0; j < q1[u].size(); ++j) {
        int id = q1[u][j];
        b1[id] = min(b1[id], dist[u]);
        e1.push_back(id);
      }
      for (int j = 0; j < q2[u].size(); ++j) {
        int id = q2[u][j];
        b2[id] = min(b2[id], dist[u]);
        e2.push_back(id);
      }
      used[u] = 0;
    }
  }
  for (int i = 0; i < e1.size(); ++i) {
    b1[e1[i]] = INF;
  }
  for (int i = 0; i < e2.size(); ++i) {
    b2[e2[i]] = INF;
  }
  mark[ct] = 1;
  for (int i = 0; i < sz; ++i) {
    solve(graph[ct][i].to);
  }
}

int main() {
  assert(freopen("factories.inp", "r", stdin));
  assert(freopen("factories.out", "w", stdout));
  std::ios::sync_with_stdio(0);
  std::cin.tie(0);
  int n, q;
  cin >> n >> q;
  for (int i = 1; i < n; ++i) {
    int u, v, c;
    cin >> u >> v >> c;
    graph[u].push_back(edge(v, c));
    graph[v].push_back(edge(u, c));
  }
  for (int i = 1; i <= q; ++i) {
    int a, b, u;
    cin >> a >> b;
    for (int j = 0; j < a; ++j) {
      cin >> u;
      q1[u].push_back(i);
    }
    for (int j = 0; j < b; ++j) {
      cin >> u;
      q2[u].push_back(i);
    }
  }
  memset(ans, 0x3C, sizeof(ans));
  memset(b1, 0x3C, sizeof(b1));
  memset(b2, 0x3C, sizeof(b2));
  solve(0);
  for (int i = 1; i <= q; ++i) {
    cout << ans[i] << '\n';
  }
}
