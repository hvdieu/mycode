#include <bits/stdc++.h>

using namespace std;

const int N = 100000 + 10;

int n, p[N], q[N], l[N], r[N], cha[N];
unsigned long long P[N], Q[N], res, f[N];
vector<int> ke[N];
bool was[N];

void dfs(int u) {
    was[u] = true;
    P[u] = p[u]; Q[u] = q[u];
    for(int v : ke[u]) if (!was[v]) {
        cha[v] = u;
        if (!l[u]) l[u] = v; else r[u] = v;
        dfs(v);
        P[u] += P[v];
        Q[u] += Q[v];
    }
    if (P[u] > Q[u]) res += P[u] - Q[u];
    else res += Q[u] - P[u];
}

void visit(int u) {
    if (P[u] > Q[u]) {
        res += P[u] - Q[u];
    }
    if (l[u] && r[u]) {
        if (P[r[u]] > Q[r[u]]) swap(l[u], r[u]);
    }
    if (l[u]) {
        if (P[l[u]] < Q[l[u]]) res += Q[l[u]] - P[l[u]];
        visit(l[u]);
    }
    if (r[u]) {
        if (P[r[u]] < Q[r[u]]) res += Q[r[u]] - P[r[u]];
        visit(r[u]);
    }
}

int main() {
    //freopen("input.txt", "r", stdin);
    scanf("%d", &n);
    for(int i = 0; i < n; i++) scanf("%d%d", p+i, q+i);
    for(int i = 1; i < n; i++) {
        int u, v; scanf("%d%d", &u, &v);
        ke[u].push_back(v); ke[v].push_back(u);
    }
    dfs(0);
    cout << res;
}
