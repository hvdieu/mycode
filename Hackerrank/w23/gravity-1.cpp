#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define REP(i, n) for(int i = 0; i < n; i++)
#define FOR(i, f) for(auto i : f)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define getbit(x, i) ((x >> (i-1)) & 1LL)
#define onbit(x, i) (x | (1LL << (i-1)))
#define offbit(x, i) (x & ~(1 << (i-1)))

const int N = 1e5 + 10;
const int LOG = 20;

int n, q, vmax, con[N], d[N];
int cha[N], f[N][LOG];
int timer, tin[N], tout[N];
ll g[N], h[N], gg[N], hh[N];
vector<int> ke[N];

void dfs(int u) {
    con[u] = 1;
    tin[u] = ++timer;
    For(j, 1, vmax) f[u][j] = f[f[u][j-1]][j-1];
    FOR(v, ke[u]) {
        cha[v] = f[v][0] = u;
        d[v] = d[u] + 1;
        dfs(v);
        con[u] += con[v];
        g[u] += g[v] + con[v];
        h[u] += h[v] + 2LL*g[v] + con[v];
    }
    tout[u] = ++timer;
}

void visit(int u) {
    FOR(v, ke[u]) {
        ll sum = gg[u] + g[u] - g[v] - con[v];
        gg[v] = sum + n - con[v];
        hh[v] = h[u] - (h[v] + 2LL*g[v] + con[v]) + hh[u] + 2LL*sum + n - con[v];
        visit(v);
    }
}

bool check(int u, int v) {
    return (tin[u] <= tin[v] && tout[u] >= tout[v]);
}

int lca(int u, int v) {
    if (check(u, v)) return u;
    if (check(v, u)) return v;
    Rep(j, vmax, 0)
        if (!check(f[u][j], v)) u = f[u][j];
    return cha[u];
}

int distance(int u, int v) {
    int pp = lca(u, v);
    return d[u] + d[v] - 2*d[pp];
}

int cal(int u, int v) {
    int ans = 0;
    For(i, 1, n) if (check(v, i)) ans += distance(u, i) * distance(u, i);
    return ans;
}

int main() {
    //freopen("in.txt","r",stdin);
    cin >> n;
    For(v, 2, n) {
        int u; cin >> u;
        ke[u].pb(v);
    }
    cha[1] = f[1][0] = 1;
    vmax = trunc(log(n) / log(2));
    dfs(1);
    visit(1);
    //For(i, 1, n) cout << h[i] << ' '; cout << "\n";
    //For(i, 1, n) cout << hh[i] << ' '; cout << "\n";
    cin >> q;
    while (q--) {
        int u, v;
        cin >> u >> v;
        ll ans;
        ll z = distance(u, v);
        if (!check(v, u)) {
            ans = h[v] + 2LL*g[v]*z + z*z*con[v];
        } else {
            ans = hh[u] + h[u];
            if (v != 1) {
                int p = cha[v];
                z++;
                ll sum = gg[p] + g[p] - g[v] - con[v];
                ll tmpG = sum + n - con[v];
                ll tmpH = h[p] - (h[v] + 2LL*g[v] + con[v]) + hh[p];
                ans -= tmpH + 2LL*sum*z + z*z*(n-con[v]);
            }
        }
        cout << ans << "\n";// << cal(u, v) << "\n";
    }
}
