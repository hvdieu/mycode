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
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 3010
#define inf 1000000000

int n, m, pay[N], con[N];
vector<int> ke[N], w[N];
int f[N][N], res, g[N][N];

void dfs(int u) {
    if (!sz(ke[u])) con[u] = 1;
    For(j, 0, sz(ke[u])-1) {
        int v = ke[u][j], l = w[u][j];
        dfs(v);
        con[u] += con[v];
    }
    f[u][0] = 0;
    if (!sz(ke[u])) f[u][1] = pay[u];
    else {
        int d1 = min(con[u], m);
        For(i, 0, sz(ke[u])) For(j, 0, d1) g[i][j] = -inf;
        g[0][0] = 0;
        For(jj, 0, sz(ke[u])-1) {
            int v = ke[u][jj], l = w[u][jj];
            int d2 = min(con[v], m);
            g[jj+1][0] = 0;
            For(j, 1, d1) {
                g[jj+1][j] = g[jj][j];
                For(k, 1, min(d2, j)) g[jj+1][j] = max(g[jj+1][j], g[jj][j-k] + f[v][k] - l);
            }
        }
        For(j, 1, d1) f[u][j] = g[sz(ke[u])][j];
    }
}

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d", &n, &m);
    For(u, 1, n-m) {
        int k, v, l;
        scanf("%d", &k);
        For(i, 1, k) {
            scanf("%d%d", &v, &l);
            ke[u].pb(v); w[u].pb(l);
        }
    }
    For(i, n-m+1, n) scanf("%d", &pay[i]);
    For(i, 1, n) For(j, 1, n) f[i][j] = -inf;
    dfs(1);
    For(i, 1, m) if (f[1][i] >= 0) res = i;
    cout << res;
}
