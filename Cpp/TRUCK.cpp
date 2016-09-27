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

int m, n, f[N][N], a[N][N];

int cal(int x, int y, int z) {
    int res = -inf;
    if (z < 0) return -inf;
    for(int t = 8999; t <= 33999; t += 1000) {
        if (t > z + 1000) return res;
        int kl = min(t, z);
        int tan = trunc(double(kl) / 1000);
        int mat = 10 + ((y-x) / 100) * tan * 4;
        if (kl - mat >= 0) res = max(res, kl - mat);
    }
    return res;
}

int main() {
    freopen("truck.inp","r",stdin);
    freopen("truck.out","w",stdout);
    scanf("%d%d", &m, &n);
    For(i, 1, m) For(j, 1, n) scanf("%d", &a[i][j]);
    For(i, 0, m) For(j, 0, n+1) f[i][j] = -inf;
    For(i, 0, m) a[i][0] = a[i][n+1] = inf;
    For(j, 0, n+1) a[0][j] = a[m+1][j] = inf;
    f[1][0] = 33010;
    For(i, 1, m) {
        For(j, 1, n) if (a[i][j] <= a[i-1][j]) f[i][j] = max(f[i][j], f[i-1][j]-10);
        else f[i][j] = max(f[i][j], cal(a[i-1][j], a[i][j], f[i-1][j]));
        For(j, 1, n) if (a[i][j] <= a[i][j-1]) f[i][j] = max(f[i][j], f[i][j-1]-10);
        else f[i][j] = max(f[i][j], cal(a[i][j-1], a[i][j], f[i][j-1]));
        Rep(j, n, 1) if (a[i][j] <= a[i][j+1]) f[i][j] = max(f[i][j], f[i][j+1]-10);
        else f[i][j] = max(f[i][j], cal(a[i][j+1], a[i][j], f[i][j+1]));
    }
    if (f[m][n] < 8000) cout << -1;
    else cout << f[m][n] - 8000;
}
