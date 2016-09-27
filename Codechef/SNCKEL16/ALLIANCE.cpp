#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define REP(i, n) for(int i = 0; i < n; i++)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
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

const int N = 5e5 + 10;

int n, k, q, tin[N], tout[N], timer, cha[N], vmax, d[N], root;
int f[N][20];
int st[N], top, jj[N];
vector<int> ke[N], g[N];
vector<int> Q;

void dfs() {
    st[++top] = 1;
    while (top) {
        int u = st[top];
        if (!jj[u]) {
            tin[u] = ++timer;
            For(j, 1, vmax) {
                f[u][j] = f[f[u][j-1]][j-1];
            }
        }
        while (jj[u] < sz(ke[u])) {
            int v = ke[u][jj[u]++];
            if (!cha[v]) {
                cha[v] = u;
                f[v][0] = u;
                d[v] = d[u] + 1;
                st[++top] = v;
                break;
            }
        }
        if (st[top] == u) {
            top--;
            tout[u] = ++timer;
        }
    }
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

void init() {
    cha[1] = 1; f[1][0] = 1;
    vmax = trunc(log(n) / log(2));
    dfs();
}

bool cmp(int i, int j) {
    return tin[i] < tin[j];
}

int distance(int u, int v) {
    int pp = lca(u, v);
    return d[u] + d[v] - 2*d[pp];
}

void solve() {
    sort(all(Q), cmp);
    int res = distance(Q[0], root);
    For(i, 1, sz(Q)-1) {
        res = min(res, distance(Q[i], root));
        int pp = lca(Q[i], Q[i-1]);
        int p1 = lca(Q[i], root);
        int p2 = lca(Q[i-1], root);
        if (check(pp, p1)) res = min(res, distance(p1, root));
        if (check(pp, p2)) res = min(res, distance(p2, root));
        res = min(res, distance(pp, root));
    }
    cout << res << "\n";
}

int main() {
    ios_base::sync_with_stdio(false);
    //freopen("in.txt","r",stdin);
    cin >> n;
    REP(i, n-1) {
        int u, v;
        cin >> u >> v;
        ke[u].pb(v); ke[v].pb(u);
    }
    cin >> k;
    For(i, 1, k) {
        int m; cin >> m;
        REP(j, m) {
            int u; cin >> u;
            g[i].pb(u);
        }
    }
    init();
    cin >> q;
    REP(i, q) {
        cin >> root;
        Q.clear();
        int m; cin >> m;
        REP(j, m) {
            int u; cin >> u;
            FOR(v, g[u]) Q.pb(*v);
        }
        solve();
    }
}


