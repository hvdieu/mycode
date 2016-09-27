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
#define N 21
#define T 2097153
#define inf 100000000
int n, m, k, g, a[N][N], f[N][T], A, B, pos[N];

int bat(int x, int i) {
    return x | (1 << i);
}

int bit(int x, int i) {
    return (x >> i) & 1;
}

void solve() {
    int TT = (1 << k) - 1;
    For(t, 1, n) For(i, 1, n) For(j, 1, n) if (a[i][j] > a[i][t] + a[t][j]) a[i][j] = a[i][t] + a[t][j];
    For(i, 1, k) For(tt, 0, TT) f[i][tt] = inf;
    For(i, 1, k) f[i][bat(0, i-1)] = max(a[A][pos[i]], a[B][pos[i]]);
    For(tt, 1, TT) {
        For(i, 1, k) if (f[i][tt] < inf)
        For(j, 1, k) if (i != j && !bit(tt, j-1)) {
            f[j][bat(tt, j-1)] = min(f[j][bat(tt,j-1)], f[i][tt] + a[pos[i]][pos[j]]);
        }
    }
    int res = 0;
    For(i, 1, k) res = max(res, g - (f[i][TT] + max(a[A][pos[i]], a[B][pos[i]])));
    cout << res;
}

int main() {
    freopen("bye.inp","r",stdin);
    freopen("bye.out","w",stdout);
    scanf("%d%d%d%d", &n, &m, &k, &g);
    scanf("%d %d", &A, &B);
    For(i, 1, k) scanf("%d", &pos[i]);
    For(i, 1, n) For(j, 1, n) if (i == j) a[i][j] = inf; else a[i][j] = inf;
    For(i, 1, m) {
        int u, v, c;
        scanf("%d%d%d", &u, &v, &c);
        a[u][v] = c; a[v][u] = c;
    }
    solve();
}
