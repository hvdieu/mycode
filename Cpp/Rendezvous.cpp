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
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 500010

int n, m, a[N], deg[N], dt[N], root[N], tree[N], timer, tin[N], tout[N];
vector<int> ke[N];
int lab[N], cnt, cycle[N], d[N], dd[N], vmax, f[N][21];
bool indfs[N], fr[N];

void visit(int u) {
    lab[u] = cnt;
    For(j, 0, sz(ke[u])-1) {
        int v = ke[u][j];
        if (!lab[v]) visit(v);
    }
}

void dfs(int u) {
    int v = a[u]; fr[u] = false;
    indfs[u] = true;
    if (fr[v]) dfs(v);
    else {
        if (indfs[v]) {
            cnt++; int len = 0;
            while (v != u) {
                cycle[v] = cnt;
                d[v] = ++len; v = a[v];
            }
            cycle[u] = cnt; d[u] = ++len;
            dd[cnt] = len;
        }
    }
    indfs[u] = false;
}

void Find_cycle() {
    reset(fr, true); cnt = 0;
    For(i, 1, n) if (fr[i]) dfs(i);
}

void loang(int u) {
    fr[u] = false; tin[u] = ++timer;
    For(j, 1, vmax) f[u][j] = f[f[u][j-1]][j-1];
    For(j, 0, sz(ke[u])-1) {
        int v = ke[u][j];
        if (fr[v] && !cycle[v]) {
            f[v][0] = u; tree[v] = cnt; dt[v] = dt[u] + 1;
            loang(v);
        }
    }
    tout[u] = ++timer;
}

void Find_tree() {
    vmax = trunc(log(n) / log(2))+1;
    cnt = 0;
    reset(fr, true);
    For(i, 1, n) if (cycle[i]) {
        cnt++; f[i][0] = i;
        loang(i);
    }
}

void Find_lab() {
    cnt = 0;
    For(i, 1, n) if (!lab[i]) {
        cnt++; visit(i);
    }
}

int ra, rb;

void update(int x, int y) {
    if (max(x, y) < max(ra, rb)) {
        ra = x; rb = y;
    } else if (max(x, y) == max(ra, rb)) {
        if (min(x, y) < min(ra, rb)) {
            ra = x; rb = y;
        } else if (min(x,y) == min(ra, rb) && x >= y) {
            ra = x; rb = y;
        }
    }
}

void tinh(int u, int v, int x, int y) {
    int uv, vu, cc = cycle[u];
    if (d[u] < d[v]) {
        uv = d[v] - d[u]; vu = dd[cc] - uv;
    } else {
        vu = d[u] - d[v]; uv = dd[cc] - vu;
    }
    ra = n+1, rb = n+1;
    update(x + uv, y);
    update(x, y + vu);
}

bool check(int u, int v) {
    if (tin[u] <= tin[v] && tout[u] >= tout[v]) return true;
    return false;
}

int lca(int u, int v) {
    if (check(u, v)) return u;
    if (check(v, u)) return v;
    Rep(j, vmax, 0) if (!check(f[u][j], v)) u = f[u][j];
    return f[u][0];
}

void solve() {
    Find_lab();
    Find_cycle();
    Find_tree();
    int u, v;
    For(test, 1, m) {
        scanf("%d%d", &u, &v);
        if (u == v) printf("0 0\n"); else
        if (lab[u] != lab[v]) printf("-1 -1\n");
        else if (tree[u] && tree[v] && tree[u] == tree[v]) {
            int p = lca(u, v);
            printf("%d %d\n", dt[u] - dt[p], -dt[p] + dt[v]);
        } else {
            int uu = f[u][vmax], vv = f[v][vmax];
            int x = -dt[uu] + dt[u], y = -dt[vv] + dt[v];
            tinh(uu, vv, x, y);
            printf("%d %d\n", ra, rb);
        }
    }
}

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d", &n, &m);
    For(i, 1, n) {
        scanf("%d", a+i); deg[a[i]]++;
        ke[i].pb(a[i]); ke[a[i]].pb(i);
    }
    solve();
}
