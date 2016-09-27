#include <stdio.h>
#include <iostream>
#include <algorithm>
#include <math.h>
#include <vector>
#include <string>
#include <cstring>
#include <map>
#include <set>
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
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 110

int n, k, cha[N], f[N][N], res;
vector<int> ke[N], con[N];

void dfs(int u) {
    f[u][0] = 1;
    For(j, 0, sz(ke[u])-1) {
        int v = ke[u][j];
        if (!cha[v]) {
            cha[v] = u; con[u].pb(v);
            dfs(v);
            f[u][0] += f[v][0];
        }
    }
    if (!sz(con[u])) return;
    For(j, 1, k) {
        f[u][j] = f[u][j-1];
        int x = min(j-1, k - j);
        For(jj, 0, sz(con[u])-1) {
            int v = con[u][jj];
            int cp = f[v][j-1];
            For(ii, 0, sz(con[u])-1) if (ii != jj) cp += f[con[u][ii]][x];
            f[u][j] = min(f[u][j], cp);
        }
    }
    For(jj, 0, sz(con[u])-1) {
        int v = con[u][jj];
        int cp = f[v][k];
        For(ii, 0, sz(con[u])-1) if (ii != jj) cp += f[con[u][ii]][0];
        f[u][k] = min(f[u][k], cp+1);
    }
}

int main() {
   // freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> n >> k;
    For(i, 1, n-1) {
        int u, v;
        cin >> u >> v;
        ke[u].pb(v); ke[v].pb(u);
    }
    cha[1] = 1; k++;
    dfs(1);
    int res = n+1;
    For(j, 0, k) res = min(res, f[1][j]);
    cout << res;
}




