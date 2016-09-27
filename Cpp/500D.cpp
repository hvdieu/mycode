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
#define N 100010

int n, q, gt[N], cha[N], nguoc[N];
vector<int> ke[N], id[N], w[N], con[N], tt[N];
double dem[N];
double res, f[N];

void dfs(int u) {
    f[u] = 1;
    For(j, 0, sz(ke[u])-1) {
        int v = ke[u][j];
        if (!cha[v]) {
            cha[v] = u;
            dfs(v);
            f[u] += f[v];
            int k = id[u][j];
            dem[k] = f[v] * (n - f[v]);
        }
    }
}

void solve() {
    cha[1] = 1;
    dfs(1);
    For(i, 1, n-1) res += ull(gt[i]) * dem[i];
    double sc = ll(n) * (n-1);
    scanf("%d", &q);
    while (q) {
        q--; int i, x;
        scanf("%d %d", &i, &x);
        ll y = gt[i] - x;
        res -= double(y) * dem[i];
        gt[i] = x;
        double kq = (res * 6) / sc;
        printf("%.10lf\n", kq);
    }
}

int main() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &n);
    For(i, 1, n-1) {
        int u, v, l;
        scanf("%d%d%d", &u, &v, &l);
        gt[i] = l;
        ke[u].pb(v); ke[v].pb(u);
        w[u].pb(l); w[v].pb(l);
        id[u].pb(i); id[v].pb(i);
    }
    solve();
}




