#include <bits/stdc++.h>

using namespace std;

#define For(i, a, b) for(int i = a; i <= b; i++)
#define Rep(i, a, b) for(int i = a; i >= b; i--)
#define FOR(i, f) for(auto i = f.begin(); i != f.end(); i++)

const int N = 2e5 + 10;

int n, f[N][20], u, v, d[N], tin[N], tout[N], timer, vmax;
vector<int> ke[N];

void dfs(int u) {
   // cout << u << ' ' ;
    tin[u] = ++timer;
    For(j, 1, vmax) f[u][j] = f[f[u][j-1]][j-1];
    FOR(v, ke[u]) {
        if (f[*v][0] == 0) {
            f[*v][0] = u; d[*v] = d[u] + 1;
            dfs(*v);
        }
    }
    tout[u] = ++timer;
}

bool check(int u, int v) {
    return (tin[u] <= tin[v] && tout[u] >= tout[v]);
}

int lca(int u, int v) {
    if (check(u, v)) return u;
    if (check(v, u)) return v;
    Rep(j, vmax, 0)
        if (!check(f[u][j], v)) u = f[u][j];
    return f[u][0];
}

int dis(int u, int v) {
    int pp = lca(u, v);
    return d[u] + d[v] - 2*d[pp];
}

int main() {
    //ifstream cin("in.txt");
    //freopen("out.txt", "w", stdout);
    cin >> n;
    u = v = 1;
    vmax = int(log(n) / log(2));
    f[1][0] = 1;
    For(i, 2, n) {
        int p; cin >> p;
        ke[i].push_back(p); ke[p].push_back(i);
    }
    dfs(1);
    For(w, 2, n) {
        if (dis(u, w) < dis(v, w)) swap(u, v);
        if (dis(u, v) < dis(u, w)) v = w;
        cout << dis(u, v) << ' ';
    }
}
