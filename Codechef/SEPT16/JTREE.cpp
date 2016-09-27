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

const int N = 1e5 + 5;
const int LOG = 20;
const ll inf = 1e18;

int n, m, q, vmax;
int f[N][LOG], cha[N];
vector<int> ke[N];
vector<ii> ticket[N];
ll g[N], ff[N][LOG];

ll jump(int u, int k) {
    ll ans = inf;
    Rep(j, vmax, 0) if (k >= two(j)) {
        k -= two(j);
        ans = min(ans, ff[u][j]);
        u = f[u][j];
    }
    return ans;
}

void dfs(int u) {
    For(j, 1, vmax) {
        f[u][j] = f[f[u][j-1]][j-1];
        ff[u][j] = min(ff[u][j-1], ff[f[u][j-1]][j-1]);
    }
    FOR(pp, ticket[u]) {
        int k = pp.first, w = pp.second;
        g[u] = min(g[u], jump(u, k) + w);
    }
    FOR(v, ke[u]) {
        f[v][0] = cha[v] = u;
        ff[v][0] = g[u];
        dfs(v);
    }
}

int main() {
    //freopen("in.txt","r",stdin);
    cin >> n >> m;
    REP(i, n-1) {
        int u, v;
        cin >> u >> v;
        ke[v].pb(u);
    }
    REP(i, m) {
        int v, k, w;
        cin >> v >> k >> w;
        ticket[v].pb(ii(k, w));
    }
    vmax = int(log(n) / log(2));
    For(i, 2, n) {
        g[i] = inf;
    }
    f[1][0] = 1; cha[0] = 1;
    ff[1][0] = 0;
    dfs(1);
    cin >> q;
    REP(i, q) {
        int u; cin >> u; cout << g[u] << "\n";
    }
}


