#include <bits/stdc++.h>

using namespace std;

const int N = 1010;

int n;
long long d[N];
vector <pair<int, int> > a[N];
vector <int> b[N];

void dfs(int u, int p, int root, long long dis) {
  if (u != root) {
    b[root].push_back(u);
  }
  for (int i = 0; i < a[u].size(); i++) {
    int v = a[u][i].first;
    int l = a[u][i].second;
    if (v == p) {
      continue;
    }
    if (dis + l > d[root]) {
      continue;
    }
    dfs(v, u, root, dis + l);
  }
}

struct tarjan {
  int low[N], num[N], used[N], cnt, belong[N], st[N], top, bot, deg[N];

  void init() {
    cnt = 0;
    for (int i = 1; i <= n; i++) {
      low[i] = num[i] = used[i] = belong[i] = deg[i] = 0;
    }
    top = bot = 0;
  }

  void dfs(int u) {
    low[u] = num[u] = ++cnt;
    st[top++] = u;
    for (int i = 0; i < b[u].size(); i++) {
      int v = b[u][i];
      if (used[v]) {
        continue;
      }
      if (!num[v]) {
        dfs(v);
      }
      low[u] = min(low[u], low[v]);
    }
    if (low[u] == num[u]) {
      int v;
      while (1) {
        v = st[--top];
        belong[v] = u;
        used[v] = 1;
        if (v == u) {
          break;
        }
      }
    }
  }

  void submain() {
    init();
    for (int i = 1; i <= n; i++) {
      if (!used[i]) {
        dfs(i);
      }
    }
    for (int i = 1; i <= n; i++) {
      for (int j = 0; j < b[i].size(); j++) {
        if (belong[i] != belong[b[i][j]]) {
          deg[belong[b[i][j]]] = 1;
        }
      }
    }
    int res = 0;
    for (int i = 1; i <= n; i++) {
      if (belong[i] == i && !deg[i]) {
        res++;
      }
    }
    cout << res;
  }
} lcc;

int main() {
  freopen("Alarm.inp", "r", stdin);
  freopen("alarm.out", "w", stdout);
  ios_base::sync_with_stdio(0);
  cin >> n;
  for (int i = 1; i <= n; i++) {
    cin >> d[i];
  }
  for (int i = 1; i < n; i++) {
    int u, v, l;
    cin >> u >> v >> l;
    a[u].push_back(make_pair(v, l));
    a[v].push_back(make_pair(u, l));
  }
  for (int i = 1; i <= n; i++) {
    dfs(i, 0, i, 0);
  }
  lcc.submain();
  return 0;
}
