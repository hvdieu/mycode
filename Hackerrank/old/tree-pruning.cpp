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
#define N 100010
#define inf 1000000000000000LL
#define K 210
int n, k, num[N], a[N], cha[N], p[N], timer, con[N];
vector<int> ke[N];
ll s[N], f[N][K];

void input() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d", &n, &k);
    For(i, 1, n) scanf("%d", a+i);
    For(i, 1, n-1) {
        int u, v; scanf("%d%d", &u, &v);
        ke[u].pb(v); ke[v].pb(u);
    }
}

void dfs(int u) {
    con[u] = 1; num[u] = ++timer; p[timer] = u;
    For(j, 0, sz(ke[u])-1) {
        int v = ke[u][j];
        if (!cha[v]) {
            cha[v] = u;
            dfs(v);
            con[u] += con[v];
        }
    }
}

void solve() {
    cha[1] = 1;
    dfs(1);
    For(i, 1, n) s[i] = s[i-1] + a[p[i]];
    For(i, 0, n+1) For(j, 0, k) f[i][j] = -inf;
    f[n+1][0] = 0;
    Rep(i, n, 1) For(j, 0, k) {
        int u = i + con[p[i]];
        f[i][j] = f[i+1][j] + a[p[i]];
        if (j) f[i][j] = max(f[i][j], f[u][j-1]);
    }
    ll res = -inf;
    For(j, 0, k) res = max(res, f[1][j]);
    cout << res;
}

int main() {
    input();
    solve();
}
