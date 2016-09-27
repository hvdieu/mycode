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
#define pb push_back
#define sz(s) int(s.size())
#define reset(f,x) memset(f,x,sizeof(f))
#define all(x) x.begin(), x.end()
#define N 500010

int n, k, a[N], cha[N], c[N];
ll f[N][2], g[N], d[N], kq[N];
vector<int> ke[N], w[N];
ll res;

void dfs(int u) {

    For(j, 0, sz(ke[u])-1) {
        int v = ke[u][j];
        if (!cha[v]) {
            cha[v] = u; c[v] = w[u][j];
            dfs(v);
            a[u] += a[v];
            if (a[v]) {
                res += w[u][j];
                ll x = f[v][0] + w[u][j];
                if (x >= f[u][0]) {
                    f[u][1] = f[u][0]; f[u][0] = x;
                } else if (x > f[u][1]) f[u][1] = x;
            }
        }
    }
}

void visit(int u, int t) {
    int v = cha[u];
    g[u] = 0;
    if (v > 0) {
        g[u] = max(g[v] + c[u], g[u]);
        if (f[v][0] == f[u][0] + c[u]) g[u] = max(g[u], f[v][1] + c[u]);
        else g[u] = max(g[u], f[v][0] + c[u]);
    }
    if (a[u]) kq[u] = res - max(g[u], f[u][0]);
    else kq[u] = d[u] + kq[t];
    For(j, 0, sz(ke[u])-1) {
        int v = ke[u][j];
        if (cha[v] == u) {
            if (!a[v]) {
                d[v] = d[u] + w[u][j];
                if (a[u]) visit(v, u); else visit(v, t);
            } else visit(v, t);
        }
    }
}

void solve() {
    cha[1] = -1;
    dfs(1);
    res *= 2;
    visit(1, 0);
    For(i, 1, n) printf("%lld\n", kq[i]);
    //cout << res;
}

int main() {
    freopen("kamp.inp","r",stdin);
    freopen("kamp.out","w",stdout);
    scanf("%d%d", &n, &k);
    For(i, 1, n-1) {
        int u, v, l; scanf("%d%d%d", &u, &v, &l);
        ke[u].pb(v); ke[v].pb(u); w[u].pb(l); w[v].pb(l);
    }
    For(i, 1, k) {
        int u; scanf("%d", &u); a[u] = 1;
    }
    solve();
}


