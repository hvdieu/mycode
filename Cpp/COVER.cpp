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
#define N 1010
#define inf 1000000000
#define BASE 1000000007

int n, k, x[N], y[N], xmin, ymin, xmax, ymax;
int xx[N], yy[N], m, gt[N];
int f[N][N][16];
ll res;

int mu(int a, int n) {
    ll res = 1;
    while (n) {
        if (n & 1) res = (res * a) % BASE;
        n >>= 1;
        a = (ll(a) * a) % BASE;
    }
    return res;
}

int C(int k, int n) {
	if (k == 0) return 1;
    if (k > n) return 0;
    int x = (ll(gt[k]) * gt[n-k]) % BASE;
    x = mu(x, BASE-2);
    x = (ll(x) * gt[n]) % BASE;
    return x;
}

void solve() {
    For(i, 1, n) {
        if (x[i] == xmin || x[i] == xmax || ymin == y[i] || ymax == y[i]) {
            m++; xx[m] = x[i]; yy[m] = y[i];
        }
    }
    f[0][0][0] = 1;
    For(i, 0, m-1) For(j, 0, i) For(tt, 0, 15) {
        f[i+1][j][tt] = (f[i+1][j][tt] + f[i][j][tt]) % BASE;
        int t1 = tt;
        if (xx[i+1] == xmin) t1 |= 1;
        if (xx[i+1] == xmax) t1 |= 2;
        if (yy[i+1] == ymin) t1 |= 4;
        if (yy[i+1] == ymax) t1 |= 8;
        f[i+1][j+1][t1] = (f[i][j][tt] + f[i+1][j+1][t1]) % BASE;
    }
    gt[0] = 1;
    For(i, 1, n) gt[i] = (ll(gt[i-1]) * i) % BASE;

    For(j, 0, k) {
        int sc = (C(j, m) - f[m][m-j][15] + BASE) % BASE;
        res = (res + ll(sc) * C(k-j, n-m)) % BASE;
    }
    cout << res;
}

int main() {
    freopen("cover.inp","r",stdin);
    freopen("cover.out","w",stdout);
    scanf("%d %d", &n, &k);
    xmax = ymax = -inf;
    xmin = ymin = inf;
    For(i, 1, n) {
        scanf("%d%d", &x[i], &y[i]);
        xmax = max(xmax, x[i]); xmin = min(xmin, x[i]);
        ymax = max(ymax, y[i]); ymin = min(ymin, y[i]);
    }
    solve();
}
