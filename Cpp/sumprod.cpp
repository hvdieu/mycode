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
#define N 100010
#define inf 1000000000

int n, b, c, d, a[N], f[N][10], res;

int main() {
    freopen("sumprod.inp","r",stdin);
    freopen("sumprod.out","w",stdout);
    scanf("%d %d %d %d", &n, &b, &c, &d);
    For(i, 1, n) scanf("%d", &a[i]);
    For(i, 1, n) For(j, b, c) {
        f[i][j] = -inf;
        For(jj, max(j - d, b), min(j + d, c)) f[i][j] = max(f[i][j], f[i-1][jj] + a[i] * j);
    }
    res = -inf;
    For(j, b, c) res = max(res, f[n][j]);
    cout << res;
}
