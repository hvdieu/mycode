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
#define N 301

int n, con[N], color[N], d, num[N], vt[N], timer, start, g[N], f[N][N];
vector<int> ke[N];

void dfs(int u) {
    num[u] = ++timer; vt[timer] = u;
    For(j, 0, sz(ke[u])-1) {
        int v = ke[u][j];
        dfs(v);
    }
}

int main() {
    freopen("tree.inp","r",stdin);
    freopen("tree.out","w",stdout);
    scanf("%d %d", &n, &d);
    For(i, 1, n) {
        int u;
        scanf("%d", &u);
        scanf("%d %d", &color[u], &con[u]);
        For(j, 1, con[u]) {
            int v; scanf("%d", &v); ke[u].pb(v);
        }
        start += color[u];
    }
    dfs(0);
}
