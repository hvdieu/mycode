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
#define N 50010

ll n, m, a[N], f[N], cha[N], sumA[N], mi, ma, sum, sumB[N], g[N];
vector<int> ke[N], w[N];

void dfs(int u) {
    sumA[u] = a[u];
    For(j, 0, sz(ke[u])-1) {
        int v = ke[u][j];
        if (!cha[v]) {
            cha[v] = u;
            dfs(v);
            sumA[u] += sumA[v];
            f[u] += f[v] + sumA[v] * w[u][j];
        }
    }
    For(j, 0, sz(ke[u])-1) {
        int v = ke[u][j];
        if (cha[v] == u) {
            sumB[v] = sumA[u] - sumA[v];
            g[v] = f[u] - (f[v] + sumA[v] * w[u][j]);
        }
    }
}

void visit(int u, ll tong) {
    For(j, 0, sz(ke[u])-1) {
        int v = ke[u][j];
        if (cha[v] == u) {
            ll x = (tong + g[v]) + (sum - sumA[v]) * w[u][j];
            mi = min(mi, (x + f[v]) * a[v]);
            ma = max(ma, (x + f[v]) * a[v]);
            visit(v, x);
        }
    }
}

void solve() {
    cha[1] = 1;
    dfs(1);
    mi = ma = f[1] * a[1];
    visit(1, 0);
    cout << mi << ' ' << ma;
}

int main() {
    freopen("tree2.inp","r",stdin);
    freopen("tree2.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) {
        scanf("%d", &a[i]);
        sum += a[i];
    }
    For(i, 1, n-1) {
        int u, v, l;
        scanf("%d %d %d", &u, &v, &l);
        ke[u].pb(v); w[u].pb(l);
        ke[v].pb(u); w[v].pb(l);
    }
    solve();
}
