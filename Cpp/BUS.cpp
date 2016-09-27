#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define N 50010
#define M 100010
#define inf 1000000010

struct edge {
    int u, v, a, b, c, d;
};

struct rr {
    int val, id, isA;
    rr(int a, int b, int c) {
        val = a; id = b; isA = c;
    }
};

int n, m, s, T, d[M], res, lef[N], righ[N], pos[M][2], deg[N];
vector<int> t[N];
vector<rr> ds[N];
edge e[M];

bool cmp(rr a, rr b) {
    return a.val < b.val;
}

bool cmp2(edge a, edge b) {
    return a.a < b.a;
}

void update(int i, int j, int val) {
    int n = sz(t[i])-1;
    while (j <= n) {
        t[i][j] = min(t[i][j], val);
        j += j & (-j);
    }
}

int get(int i, int j) {
    int s = inf;
    while (j > 0) {
        s = min(s, t[i][j]);
        j -= j & (-j);
    }
    return s;
}

void init() {
    sort(e+1, e+m+1, cmp2);
    deg[1]++;
    ds[1].pb(rr(0, 0, 1));
    For(i, 1, m) {
        int u = e[i].u, v = e[i].v;
        deg[u]++; deg[v]++;
        ds[u].pb(rr(e[i].a, i, 0));
        ds[v].pb(rr(e[i].d, i, 1));
    }
    int cnt = 0;
    For(i, 1, n) if (sz(ds[i])) {
        sort(ds[i].begin(), ds[i].end(), cmp);
        int dem = 0;
        For(j, 0, sz(ds[i])-1) {
            if (!j || ds[i][j].val != ds[i][j-1].val) dem++;
            int jj = ds[i][j].id, stt = ds[i][j].isA;
            pos[jj][stt] = dem;
        }
        For(j, 0, deg[i]) t[i].pb(inf);
    }
    if (s == 1) res = T; else res = inf;
}

void solve() {
    init();
    update(1, pos[0][1], 0);
    For(i, 1, m) {
        int u = e[i].u, v = e[i].v;
        int x = get(u, pos[i][0]) + e[i].b;
        if (x < inf) {
            if (v == s && e[i].d <= T) res = min(res, x + T - e[i].c);
            update(v, pos[i][1], x - e[i].c);
        }
    }
    if (res == inf) cout << -1; else cout << res;
}

int main() {
    freopen("BUS.inp","r",stdin);
   // freopen("BUS.out","w",stdout);
    scanf("%d%d%d%d", &n, &m, &s, &T);
    For(i, 1, m) {
        int u, v, a, b, c, d;
        scanf("%d%d%d%d%d%d", &u, &v, &a, &b, &c, &d);
        e[i].u = u; e[i].v = v; e[i].a = a; e[i].b = b; e[i].c = c; e[i].d = d;
    }
    solve();
}


