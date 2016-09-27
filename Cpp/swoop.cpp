#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define REP(i, n) for(int i = 0; i < n; i++)
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
#define N 100010
#define LOG 20

int n, x[N], a[N], f[N][LOG], vmax;

ll get(int i, int j) {
    int k = trunc(log(j-i+1) / log(2));
    return a[f[i][k]] >= a[f[j-two(k)+1][k]] ? f[i][k] : f[j-two(k)+1][k];
}

ll dis(int i, int j) {
    ll xx = x[i] - x[j], yy = a[i] - a[j];
    return xx*xx + yy*yy;
}

ll cal(int l, int r) {
    if (l + 1 == r) return dis(l, r);
    int mid = get(l+1, r-1);
    ll res;
    res = max(cal(l, mid), cal(mid, r));
    if (a[mid] < a[l] && a[mid] < a[r]) res = min(res, dis(l, r));
    return res;
}

int main() {
    freopen("swoop.inp","r",stdin);
    freopen("swoop.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d%d", x+i, a+i);
    vmax = trunc(log(n) / log(2));
    For(i, 1, n) f[i][0] = i;
    For(j, 1, vmax) For(i, 1, n - two(j) + 1)
    f[i][j] = a[f[i][j-1]] >= f[i + two(j-1)][j-1] ? f[i][j-1] : f[i + two(j-1)][j-1];
    double res = sqrt(cal(1, n));
    printf("%.10f", res);
}
