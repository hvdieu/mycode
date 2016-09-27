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
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 210

int n, m, k, a[N], f[N][N][N], b[N];

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> n;
    int x;
    For(i, 1, n) {
        cin >> x;
        if (x) a[++m] = x;
    }
    For(i, 1, n) {
        cin >> x;
        if (x) b[++k] = x;
    }
    reset(f, 0x8f);
   // cout << f[0][0];
    f[0][0][0] = 0;
    For(i, 1, n) For(j, 0, min(n-m, i)) For(t, 0, min(n-k, i)) {
        int ii = i - j, jj = i - t;
        if (ii && jj && ii <= m && jj <= k) f[i][j][t] = f[i-1][j][t] + a[ii] * b[jj];
        if (j) f[i][j][t] = max(f[i][j][t], f[i-1][j-1][t]);
        if (t) f[i][j][t] = max(f[i][j][t], f[i-1][j][t-1]);
    }
    cout << f[n][n-m][n-k];
}
