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
#define N 5010

int m, n, d[N], dem[N], cha[N];
bool fr[N];
vector<int> ke[N];
ll res;

void dfs(int u) {
    fr[u] = false;
    For(j, 0, sz(ke[u])-1) {
        int v = ke[u][j];
        if (fr[v]) {
            d[v] = d[u] + 1;
            dfs(v);
        }
    }
}

int main() {
    freopen("tree4.inp","r",stdin);
    //freopen("tree4.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n-1) {
        int u, v;
        scanf("%d %d", &u, &v);
        ke[u].pb(v); ke[v].pb(u);
    }
    For(i, 1, n) {
        reset(fr, true);
        reset(d, 0);
        dfs(i);
        reset(dem, 0);
        For(j, 1, n) dem[d[j]]++;
        For(j, 1, n) if (dem[j] >= 3) {
            ll x = dem[j];
            x = x * (x - 1) * (x - 2);
            x = x / 6; res += x;
        }
    }
    cout << res;
}
