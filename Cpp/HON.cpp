#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 200

int a[N][N], n, k, b[N];
ll f[N][N][2], g[N][N][N][2], MAX[N], MAX2[N];

void gmax(ll &a, ll b) {
    if (b > a) a = b;
}

void sub1() {
    For(i, 1, b[1]) {
        f[1][i][0] = a[1][i];
        f[1][i][1] = MAX[1];
    }
    For(i, 1, n-1) For(j, 1, b[i]) {
        int d, c;
        if (i <= n / 2) d = 0, c = 1;
        else d = -1, c = 0;
        For(k, d, c)
        if (j + k <= b[i+1]) {
            gmax(f[i+1][j+k][0], f[i][j][0] + a[i+1][j+k]);
            gmax(f[i+1][j+k][1], f[i][j][1] + a[i+1][j+k]);
            gmax(f[i+1][j+k][1], f[i][j][0] + MAX[i+1]);
        }
    }
  //  cout << f[5][3][1] << endl;
    ll res = 0;
    For(j, 1, b[n]) gmax(res, max(f[n][j][0], f[n][j][1]));
    cout << res;
}

void sub2() {
    For(i, 1, b[1]) For(j, i+1, b[1]) {
        g[1][i][j][0] = a[1][i] + a[1][j];
        if (max(a[1][i], a[1][j]) != MAX[1]) g[1][i][j][1] = max(a[1][i], a[1][j]) + MAX[1];
        else g[1][i][j][1] = MAX[1] + MAX2[1];
    }
    For(i, 1, n-1) For(j1, 1, b[i]) For(j2, j1+1, b[i]) {
        int d, c;
        if (i <= n / 2) d = 0, c = 1;
        else d = -1, c = 0;
        For(k1, d, c) For(k2, d, c) if (j1 + k1 <= b[i+1] && j2 + k2 <= b[i+1] && j1 != j2) {
            gmax(g[i+1][j1+k1][j2+k2][0], g[i][j1][j2][0] + a[i+1][j1+k1] + a[i+1][j2+k2]);
            gmax(g[i+1][j1+k1][j2+k2][1], g[i][j1][j2][1] + a[i+1][j1+k1] + a[i+1][j2+k2]);
            if (max(a[i+1][j1+k1], a[i+1][j2+k2]) != MAX[i+1]) gmax(g[i+1][j1+k1][j2+k2][1], g[i][j1][j2][0] + max(a[i+1][j1+k1], a[i+1][j2+k2]) + MAX[i+1]);
            else gmax(g[i+1][j1+k1][j2+k2][1], g[i][j1][j2][0] + MAX2[i+1] + MAX[i+1]);
        }
    }
    ll res = 0;
    For(j1, 1, b[n]) For(j2, j1+1, b[n]) gmax(res, max(g[n][j1][j2][0], g[n][j1][j2][1]));
    cout << res;
}

int main() {
	// main();
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d", &n, &k);
    b[1] = n;
    n = n*2 - 1;
    For(i, 2, n/2 + 1) b[i] = b[i-1] + 1;
    For(i, n/2 + 2, n) b[i] = b[i-1] - 1;
    For(i, 1, n) For(j, 1, b[i]) {
        scanf("%d", &a[i][j]);
        if (a[i][j] > MAX[i]) {
            MAX2[i] = MAX[i];
            MAX[i] = a[i][j];
        } else if (a[i][j] > MAX2[i]) MAX2[i] = a[i][j];
    }
    if (k == 1) sub1();
    else sub2();
}
