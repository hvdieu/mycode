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
#define two(x) ((1LL << x) - 1)
#define bit(x, i) ((x >> (i)) & 1LL)
#define onbit(x, i) (x | (1LL << (i)))
#define offbit(x, i) (x & ~(1 << i))
#define N 1010

struct triple {
    int u, v, l;
    triple(int _u, int _v, int _l) {
        u = _u; v = _v; l = _l;
    }
};

int n, m, vmax, f[N][11], cha[N], d[N], deg[N], id[N], kq;
int tin[N], tout[N], timer;
vector<int> ke[N];
vector<triple> edge;
vector<int> con[N];
vector<triple> ds[N];
vector<int> cost;
int g[N][1025];

bool check(int u, int v) {
    return (tin[u] <= tin[v] && tout[u] >= tout[v]);
}

int lca(int u, int v) {
	if (check(u, v)) return u;
	if (check(v, u)) return v;
    Rep(j, vmax, 0) if (!check(f[u][j], v)) u = f[u][j];
    return cha[u];
}

void dfs(int u) {
    tin[u] = ++timer;
    For(j, 1, vmax) f[u][j] = f[f[u][j-1]][j-1];
    FOR(v, ke[u]) if (!cha[*v]) {
        con[u].pb(*v); id[*v] = sz(con[u])-1;
        d[*v] = d[u] + 1;
        cha[*v] = f[*v][0] = u;
        dfs(*v);
    }
    tout[u] = ++timer;
}

int full(int u) {
    return two(sz(con[u]));
}

void visit(int u) {
    FOR(v, con[u])
        visit(*v);
    cost.clear();
    FOR(it, ds[u]) {
        int uu = it->u, vv = it->v, l = it->l;
        cost.pb(l);
        if (uu != u) cost.back() += g[uu][full(uu)];
        if (vv != u) cost.back() += g[vv][full(vv)];
        while (uu != u && cha[uu] != u) {
            int p = cha[uu];
            cost.back() += g[p][offbit(full(p), id[uu])];
            uu = p;
        }
        it->u = uu;
        while (vv != u && cha[vv] != u) {
            int p = cha[vv];
            cost.back() += g[p][offbit(full(p), id[vv])];
            vv = p;
        }
        it->v = vv;
    }
    For(tt, 0, full(u)) {
        if (u == 1) kq = max(kq, g[u][tt]);
        REP(j, sz(con[u])) if (!bit(tt, j))
            g[u][onbit(tt, j)] = max(g[u][onbit(tt, j)], g[u][tt] + g[con[u][j]][full(con[u][j])]);
        REP(j, sz(ds[u])) {
            int uu = ds[u][j].u, vv = ds[u][j].v, l = ds[u][j].l;
            int newtt = tt;
            if (uu != u && !bit(tt, id[uu])) newtt = onbit(tt, id[uu]);
            else if (uu != u) newtt = -1;
            if (tt != -1)
            if (vv != u && !bit(tt, id[vv])) newtt = onbit(newtt, id[vv]);
            else if (vv != u) newtt = -1;
            if (newtt != -1) g[u][newtt] = max(g[u][newtt], g[u][tt] + cost[j]);
        }
    }
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d", &n, &m);
    REP(i, m) {
        int u, v, l;
        scanf("%d%d%d", &u, &v, &l);
        if (!l) {
            ke[u].pb(v); ke[v].pb(u);
        } else edge.pb(triple(u, v, l));
    }
    vmax = trunc(log(n) / log(2));
    cha[1] = f[1][0] = 1;
    dfs(1);
    int res = 0;
    REP(i, sz(edge)) {
        int u = edge[i].u, v = edge[i].v, l = edge[i].l;
        int p = lca(u, v); res += l;
        if ((d[u] + d[v] - 2*d[p]) % 2 == 0) ds[p].pb(triple(u, v, l));
    }
    visit(1);
    cout << res - kq;
}
