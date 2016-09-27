#include <bits/stdc++.h>
using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ld long double
#define pb push_back
#define all(x) x.begin(), x.end()
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 10010
#define inf 100000000

int n, ntest, vmax, root, d[N], f[N][20], cha[1], g[N][20], tin[N], tout[N], timer;
vector<int> ke[N];
vector<int> kind[110];

void dfs(int u) {
    tin[u] = ++timer;
    For(j, 1, vmax) {
        f[u][j] = f[f[u][j-1]][j-1];
        g[u][j] = min(g[u][j-1], g[f[u][j-1]][j-1]);
    }
    For(j, 0, sz(ke[u])-1) {
        int v = ke[u][j];
        if (!cha[v]) {
            cha[v] = f[v][0] = u; g[v][0] = d[u];
            d[v] = d[u] + 1;
            dfs(v);
        }
    }
    tout[u] = ++timer;
}

bool check(int u, int v) {
    return tin[u] <= tin[v] && tout[u] >= tout[v];
}

int lca(int u, int v) {
    if (check(u, v)) return u;
    if (check(v, u)) return v;
    Rep(j, vmax, 0) if (!check(f[u][j], v)) u = f[u][j];
    return cha[u];
}

int cal(int u, int v) {
    if (u == v) return 0;
    int pp = lca(u, v);
    int res = min(d[u], d[v]);
    if (u != p) {
        Rep(j, vmax, 0) if (!check(f[u][j], p)) {
            res = min(res, g[u][j]);
            u = f[u][j];
        }
        res = min(res, g[u][0]);
    }
    if (v != p) {
        Rep(j, vmax, 0) if (!check(f[v][j], p)) {
            res = min(res, g[v][j]);
            v = f[v][j];
        }
        res = min(res, g[v][0]);
    }
    return res;
}

int main() {
    freopen("input.txt","r",stdin);
    freopen("output.txt","w",stdout);
    scanf("%d%d", &n, &k);
    scanf("%d", &root);
    For(i, 1, n-1) {
        int u, v; scanf("%d%d", &u, &v);
        ke[u].pb(v); ke[v].pb(u);
    }
    For(i, 1, n) {
        int x; scanf("%d", &x);
        kind[x].pb(i);
    }
    vmax = trunc(log(n) / log(2));
    cha[root] = root; f[root][0] = root; g[root][0] = inf;
    dfs(root);
    scanf("%d", &ntest);
    while (ntest) {
        ntest--; int u, x;
        scanf("%d%d", &u, &x);
        res = 0;
        For(j, 0, sz(kind[x])-1) {
            int v = kind[x][j];
            res = max(res, cal(u, v));
        }
        printf("%d\n", res);
    }
}
