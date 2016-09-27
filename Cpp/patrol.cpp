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
#define N 100010

int n, d[N], f[N][2], cha[N], deg[N];
ll g[N][2];
ll h[N];
int MAX;
vector<int> ke[N];

void dfs(int u) {
    g[u][0] = 1;
    f[u][0] = 0;
    g[u][1] = 1;
    ll sum = 0;
    FOR(v, ke[u]) if (!cha[*v]) {
        cha[*v] = u;
        dfs(*v);
        int x = f[*v][0] + 1;
        if (x > f[u][0]) {
            f[u][1] = f[u][0];
            g[u][1] = g[u][0];
            f[u][0] = x; g[u][0] = g[*v][0];
            h[u] = 0;
            sum = g[*v][0];
            deg[u] = 1;
        } else if (x == f[u][0]) {
            deg[u]++;
            g[u][0] += g[*v][0];
            h[u] += sum*g[*v][0];
            sum += g[*v][0];
        } else if (x > f[u][1]) {
            f[u][1] = x; g[u][1] = g[*v][0];
        } else if (x == f[u][1]) g[u][1] += g[*v][0];
    }
    MAX = max(MAX, f[u][0] + f[u][1]);
    if (deg[u] > 1) MAX = max(MAX, 2*f[u][0]);
}

int main() {
  //  freopen("input.txt","r",stdin);
   // freopen("","w",stdout);
   scanf("%d", &n);
   For(i, 1, n-1) {
        int u, v;
        scanf("%d%d", &u, &v);
        ke[u].pb(v); ke[v].pb(u);
   }
    cha[1] = 1;
    dfs(1);
   // cout << MAX << endl;
    ll res = 0;
    For(u, 1, n) if (f[u][0] + f[u][1] == MAX || (deg[u] > 1 && 2*f[u][0] == MAX)) {
        if (deg[u] == 1) res += g[u][0]*g[u][1];
        else res += h[u];
    }
    if (n == 2) res = 0;
    cout << 2*(n-1) - MAX + 1 << ' ' << res;
}
