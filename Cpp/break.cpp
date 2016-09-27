#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 250010
#define inf 1000000000

int n, ntest, tin[N], tout[N], timer, cha[N], root, m;
int dd[N], timer2;
int f[N][20], vmax, g[N][20];
ll dp[N];
vector<ii> ke[N];
vector<int> Q;

void dfs(int u) {
    tin[u] = ++timer;
    For(j, 1, vmax) {
        f[u][j] = f[f[u][j-1]][j-1];
        g[u][j] = min(g[u][j-1], g[f[u][j-1]][j-1]);
    }
    FOR(it, ke[u]) {
        int v = it->fi, l = it->se;
        if (!cha[v]) {
            cha[v] = u; f[v][0] = u; g[v][0] = l;
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

int get(int u, int v) {
    int uu = u, vv = v;
    int res = inf;
    Rep(j, vmax, 0) if (!check(f[u][j], v)) res = min(res, g[u][j]), u = f[u][j];
    if (!check(u, v)) res = min(res, g[u][0]);
    u = uu;
    Rep(j, vmax, 0) if (!check(f[v][j], u)) res = min(res, g[v][j]), v = f[v][j];
    if (!check(v, u)) res = min(res, g[v][0]);
    return res;
}

void init() {
    cha[1] = 1; f[1][0] = 1; g[1][0] = inf;
    vmax = trunc(log(n) / log(2));
    dfs(1);
}

bool cmp(int i, int j) {
    return tin[i] < tin[j];
}

int top, st[N], pa[N], fr[N];
ll ts[N];

void visit(int u) {
    fr[u] = timer2;
    dp[u] = 0;
    if (dd[u] == timer2) {
        dp[u] = ts[u];
        return;
    }
    FOR(it, ke[u]) {
        int v = it->fi, l = it->se;
        if (fr[v] != timer2) {
            ts[v] = l;
            visit(v);
            dp[u] += dp[v];
        }
    }
    dp[u] = min(dp[u], ll(ts[u]));
}

void solve() {
    sort(all(Q), cmp);
    For(i, 1, m) Q.pb(lca(Q[i], Q[i-1]));
    sort(all(Q)); Q.erase(unique(all(Q)), Q.end());
    sort(all(Q), cmp);
    m = sz(Q)-1;
  //  For(i, 0, m) cout << Q[i] << ' '; cout << endl;
    For(i, 0, m) ke[Q[i]].clear();
    top = 0;
    For(i, 0, m) {
        while (top && tout[Q[i]] >= tout[st[top]]) top--;
        if (top) {
            int l = get(Q[i], st[top]);
            ke[Q[i]].pb(ii(st[top], l));
            ke[st[top]].pb(ii(Q[i], l));
        }
        st[++top] = Q[i];
    }
    ts[root] = 1000000000000000LL;
    visit(root);
    printf("%lld\n", dp[root]);
}

int main() {
   // freopen("input.txt","r",stdin);
 //   freopen("output.txt","w",stdout);
    scanf("%d", &n);
    For(i, 1, n-1) {
        int u, v, l; scanf("%d%d%d", &u, &v, &l);
        ke[u].pb(ii(v, l)); ke[v].pb(ii(u, l));
    }
    init();
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        Q.clear(); int u;
        scanf("%d", &u); Q.pb(u); root = u;
        scanf("%d", &m); ++timer2;
        For(i, 1, m) {
            scanf("%d", &u); Q.pb(u);
            dd[u] = timer2;
        }
        solve();
    }
}
