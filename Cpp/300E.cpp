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
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 200010

int n, d[N], f[N], g[N], con[N];
vector<int> ke[N];

void dfs(int u) {
    if (!sz(ke[u])) {
        f[u] = g[u] = con[u] = 1;
        return;
    }
    REP(j, sz(ke[u])) {
        int v = ke[u][j];
        d[v] = d[u] + 1;
        dfs(v);
        con[u] += con[v];
    }
    if (d[u] % 2 == 0) {
        int MIN = 100000000;
        FOR(v, ke[u]) MIN = min(MIN, con[*v] - f[*v]);
        f[u] = con[u] - MIN;
        FOR(v, ke[u]) g[u] += g[*v];
    } else {
        int MAX = 0;
        FOR(v, ke[u]) f[u] += f[*v] - 1;
        f[u]++;
        g[u] = 10000000;
        FOR(v, ke[u]) g[u] = min(g[u], g[*v]);
    }
}

int main() {
   // freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &n);
    For(i, 1, n-1) {
        int u, v;
        scanf("%d%d", &u, &v);
        ke[u].pb(v);
    }
    dfs(1);
    cout << f[1] << ' ' << g[1];
}
