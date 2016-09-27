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
#define ld long double
#define pb push_back
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 50100
#define BASE 1000000007
struct bignum {
    int h[100];
};

int m, n, deg[N], dem, x[N], y[N];
vector<int> ke[N], ke2[N];
ull f[N], g[N], res;


int main() {
    freopen("graph3.inp","r",stdin);
    freopen("graph3.out","w",stdout);
    scanf("%d %d", &n, &m);
    For(i, 1, m) {
        int u, v; scanf("%d %d", &u, &v);
        ke[u].pb(v); ke2[v].pb(u);
        x[i] = u; y[i] = v;
        deg[v]++;
    }
    For(u, 1, n) {
        if (!deg[u]) f[u] = 1;
        For(j, 0, sz(ke[u])-1) {
            int v = ke[u][j];
            f[v] += f[u];
        }
    }
    g[n] = 1;
    Rep(u, n, 1) {
        For(j, 0, sz(ke2[u])-1) {
            int v = ke2[u][j];
            g[v] += g[u];
        }
    }
    For(i, 1, m) {
        int u = x[i], v = y[i];
        res = max(res, f[u] * g[v]);
    }
    cout << res;
}
