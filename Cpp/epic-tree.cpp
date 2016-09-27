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
#define BASE 10009

int n, m, cha[N], tin[N], tout[N], timer, pp;
vector<int> ke[N];
int a[N], res, b[N];

void dfs(int u) {
    tin[u] = ++timer;
    FOR(v, ke[u]) if (!cha[*v]) {
        cha[*v] = u;
        dfs(*v);
    }
    tout[u] = ++timer;
}

int check(int u, int v) {
    if (tin[u] <= tin[v] && tout[u] >= tout[v]) return true;
    return false;
}

void add(int &a, int b) {
    a += b; a %= BASE;
}

void visit(int u) {
    add(b[u], a[u]);
    if (check(pp, u)) add(res, b[u]);
    FOR(v, ke[u]) if (cha[*v] == u) {
        add(a[*v], a[u]);
        visit(*v);
    }
    a[u] = 0;
}

int main() {
   // freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &n);
    For(i, 1, n-1) {
        int u, v; scanf("%d%d", &u, &v);
        ke[u].pb(v); ke[v].pb(u);
    }
    cha[1] = 1;
    dfs(1);
    scanf("%d", &m);
    while (m) {
        m--;
        int kind, u, v, t;
        scanf("%d", &kind);
        if (kind == 1) {
            scanf("%d%d%d", &u, &v, &t);
            int p = u;
            while (!check(p, v)) p = cha[p];
            while (u != p) add(a[u], t), u = cha[u];
            while (v != p) add(a[v], t), v = cha[v];
            add(a[p], t);
        } else {
            scanf("%d", &pp);
            res = 0;
            visit(1);
            printf("%d\n", res);
        }
    }
}


