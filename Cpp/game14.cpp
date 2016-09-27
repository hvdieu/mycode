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
#define N 5001
#define inf 1000000000

int n, k, a[2][N], f[2][N], s[2][N];

void solve() {
    For(i, 0, 1) For(j, 1, n) {
        f[i][j] = -inf;
        s[i][j] = s[i][j - 1] + a[i][j];
    }
    f[0][1] = a[0][1]; f[1][1] = a[1][1];
    For(j, 2, n) For(i, 0, 1) if (f[i][j] == -inf) {
        For(t, 2, min(k, j)) {
            int jj = j - t + 1;
            if (i == 0 && jj == 1) f[i][j] = max(f[i][j], s[i][j]);
            else f[i][j] = max(f[i][j], f[1 - i][jj] + s[i][j] - s[i][jj - 1]);
        }
    }
    cout << max(f[1][n], f[0][n] + a[1][n]);
}

int main() {
    freopen("game14.inp","r",stdin);
    freopen("game14.out","w",stdout);
    scanf("%d %d", &n, &k);
    For(i, 0, 1) For(j, 1, n) scanf("%d", &a[i][j]);
    solve();
}
