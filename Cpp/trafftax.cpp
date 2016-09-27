#include <vector>
#include <algorithm>
#include <math.h>
#include <iostream>
#include <stdio.h>
#include <string.h>
#include <cmath>
#include <cstring>
#include <queue>
#include <stack>

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
#define all(x) x.begin(), x.end()
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define two(i) (ll(1) << i)
#define bit(x, i) ( (x >> i) & 1 )
#define onbit(x, i) ( x | (1 << i ) )
#define N 200010
#define K 101

int n, k, cha[N], f[N][K], g[N];
vector<int> ke[N], con[N];

void dfs(int u) {
    f[u][0] = 1;
    For(j, 0, sz(ke[u])-1) {
        int v = ke[u][j];
        if (!cha[v]) {
            cha[v] = u; con[u].pb(v);
            dfs(v);
            f[u][0] += f[v][k];
        }
    }
    if (!sz(con[u])) return;
    For(j, 1, k) {
        g[sz(con[u])] = 0;
        int x = min(j-1, k-j);
        f[u][j] = f[u][j-1];
        Rep(jj, sz(con[u])-1, 0) {
            int v = con[u][jj];
            g[jj] = g[jj+1] + f[v][x];
        }
        int sum = 0;
        For(jj, 0, sz(con[u])-1) {
            int v = con[u][jj];
            f[u][j] = min(f[u][j], f[v][j-1] + g[jj+1] + sum);
            sum += f[v][x];
        }
    }
}

int main() {
    freopen("trafftax.inp","r",stdin);
    //freopen("trafftax.out","w",stdout);
    scanf("%d%d", &n, &k);
    For(i, 1, n-1) {
        int u, v;
        scanf("%d%d", &u, &v);
        ke[u].pb(v); ke[v].pb(u);
    }
    cha[1] = 1;
    dfs(1);
    cout << f[1][k];
}
