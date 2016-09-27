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
#define N 100010

const int inf = 1000000000;

int n, q, dd[N], con[N], cha[N], id[N], pos[N], m, root[N];
int f[N][20], vmax, tin[N], tout[N], timer;
vector<int> ke[N];
int t[4*N], g[4*N];

void dfs(int u) {
    tin[u] = ++timer;
    For(j, 1, vmax) f[u][j] = f[f[u][j-1]][j-1];
    con[u] = 1;
    int tmp = 0;
    FOR(v, ke[u]) if (!cha[*v]) {
        cha[*v] = u; f[*v][0] = u;
        dfs(*v);
        con[u] += con[*v];
        if (con[*v] > tmp) {
            tmp = con[*v]; dd[u] = *v;
        }
    }
    tout[u] = ++timer;
}

void visit(int u) {
    id[++m] = u; pos[u] = m;
    if (dd[u]) {
        root[dd[u]] = root[u];
        visit(dd[u]);
    }
    FOR(v, ke[u]) if (cha[*v] == u && *v != dd[u]) {
        root[*v] = *v;
        visit(*v);
    }
}

void down(int i) {
    t[i*2] += g[i]; g[i*2] += g[i];
    t[i*2+1] += g[i]; g[i*2+1] += g[i];
    g[i] = 0;
}

void update(int i, int lo, int hi, int u, int v, int x) {
    if (lo > v || hi < u) return;
    if (u <= lo && hi <= v) {
        t[i] += x;
        g[i] += x;
        return;
    }
    int mid = (lo + hi) / 2;
    down(i);
    update(i*2, lo, mid, u, v, x);
    update(i*2+1, mid+1, hi, u, v, x);
    t[i] = max(t[i*2], t[i*2+1]);
}

int get(int i, int lo, int hi, int u, int v) {
    if (lo > v || hi < u) return -inf;
    if (u <= lo && hi <= v) return t[i];
    int mid = (lo + hi) / 2;
    down(i);
    int l = get(i*2, lo, mid, u, v);
    int r = get(i*2+1, mid+1, hi, u, v);
    t[i] = max(t[i*2], t[i*2+1]);
    return max(l, r);
}

void init() {
    vmax = trunc(log(n) / log(2));
    cha[1] = 1; f[1][0] = 1;
    dfs(1);
    root[1] = 1;
    visit(1);
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

int Query(int u, int v) {
    int res = -inf;
    while (1) {
        int p = root[u];
        if (check(p, v)) {
            res = max(res, get(1, 1, n, pos[v], pos[u]) );
            break;
        } else res = max(res, get(1, 1, n, pos[root[u]], pos[u]) );
        u = cha[root[u]];
    }
    return res;
}

void solve() {
    int ntest;
    scanf("%d\n", &ntest);
    For(test, 1, ntest) {
        string kind;
        int u, v;
        cin >> kind; scanf("%d%d", &u, &v);
        if (kind == "add") update(1, 1, n, pos[u], pos[u] + con[u] - 1, v);
        else {
            int pp = lca(u, v);
            int res = -inf;
            res = max(res, Query(u, pp));
            res = max(res, Query(v, pp));
            printf("%d\n", res);
        }
    }
}

int main() {
  //  freopen("input.txt","r",stdin);
  //  freopen("output.txt","w",stdout);
    scanf("%d", &n);
    For(i, 1, n-1) {
        int u, v; scanf("%d%d", &u, &v);
        ke[u].pb(v); ke[v].pb(u);
    }
    init();
    solve();
}
