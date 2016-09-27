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
#define N 1001

int n, res, d[N];
bool fr[N];
vector<int> ke[N];

void dfs(int u) {
    fr[u] = false; res = max(res, d[u]);
    For(j, 0, sz(ke[u])-1) {
        int v = ke[u][j];
        if (fr[v]) {
            d[v] = d[u] + 1;
            dfs(v);
        }
    }
}

int main() {
    freopen("tree1.inp","r",stdin);
    freopen("tree1.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n-1) {
        int u, v; scanf("%d %d", &u, &v);
        ke[u].pb(v); ke[v].pb(u);
    }

    For(i, 1, n) {
        reset(fr, true); reset(d, 0);
        dfs(i);
    }
    cout << 2 * n - 2 - res;
}
