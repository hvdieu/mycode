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
#define N 100010

int n, m, timer, tin[N], tout[N], cha[N], con[N], f[N][20], vmax, mm, q[N], start[N], pos[N], c[N];
vector<int> ke[N];
map<int, int> e[N];
int t[4*N], ff[4*N], dd[N];
vector<int> ke2[N];

void dfs(int u) {
    con[u] = 1; tin[u] = ++timer;
    For(j, 1, vmax) f[u][j] = f[f[u][j-1]][j-1];
    FOR(v, ke[u]) if (!cha[*v]) {
        cha[*v] = f[*v][0] = u;
        dfs(*v);
        con[u] += con[*v];
        if (!dd[u] || con[*v] > con[dd[u]]) dd[u] = *v;
    }
    tout[u] = ++timer;
}

bool check(int u, int v) {
    return (tin[u] <= tin[v]) && (tout[u] >= tout[v]);
}

int lca(int u, int v) {
    if (check(u, v)) return u;
    if (check(v, u)) return v;
    Rep(j, vmax, 0)
        if (check(f[u][j], v) == false) u = f[u][j];
    return cha[u];
}

void HLD() {
    vmax = trunc(log(n) / log(2));
    cha[1] = 1; f[1][0] = 1;
    dfs(1);
    For(i, 1, n) if (dd[cha[i]] != i) {
        int u = i;
        q[++mm] = u; start[u] = u; pos[u] = mm;
        while (dd[u]) {
            u = dd[u];
            q[++mm] = u; start[u] = i; pos[u] = mm;
        }
    }
}

void update(int i, int lo, int hi, int u, int v, int x) {
    if (lo == u && hi == v) {
        ff[i] += x;
        if (ff[i]) t[i] = hi-lo+1;
             else t[i] = t[i*2] + t[i*2+1];
        return;
    }
    int mid = (lo+hi) / 2;
    if (u <= mid) update(i*2, lo, mid, u, min(mid,v), x);
    if (v > mid)  update(i*2+1, mid+1, hi, max(u,mid+1), v, x);
    if (ff[i]) t[i] = hi-lo+1;
        else t[i] = t[i*2] + t[i*2+1];
}

void Query(int u, int v, int x) {
    while (1) {
        if (check(start[u], v)) {
            update(1, 1, n, pos[v], pos[u], x);
            return;
        } else {
            update(1, 1, n, pos[start[u]], pos[u], x);
            u = cha[start[u]];
        }
    }
}

void solve() {
    int Q;
    update(1, 1, n, pos[1], pos[1], 1);
    For(u, 1, n) FOR(v, ke2[u]) {
        int p = lca(u, *v);
        Query(u, p, 1);
        Query(*v, p, 1);
       // cout << t[1] << ' ';
        printf("%d\n", n-t[1]);
    }
    scanf("%d", &Q);
    For(i, 1, Q) {
        int u, v;
        scanf("%d%d", &u, &v);
        if (e[u][v] == 1) {
            e[u][v] = e[v][u] = 0;
            int p = lca(u, v);
            Query(u, p, -1);
            Query(v, p, -1);
        } else {
            e[v][u] = e[u][v] = 1;
            int p = lca(u, v);
            Query(u, p, 1);
            Query(v, p, 1);
        }
        //cout << t[1] << ' ';
        printf("%d\n", n-t[1]);
    }
}

int main() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d", &n, &m);
    For(i, 1, m) {
        int u, v, k;
        scanf("%d%d%d", &u, &v, &k);
        if (k == 0) {
            ke[u].pb(v); ke[v].pb(u);
        } else {
            e[u][v]++; e[v][u]++;
            ke2[u].pb(v);
        }
    }
    HLD();
    solve();
}


