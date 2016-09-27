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
#define N 1001

int n, a[N][N];
ll f[N][N], s[2][N][N];
bool check[N][N];

void init() {
    For(j, 1, n) For(i, 1, n) s[0][i][j] = s[0][i-1][j] + a[i][j];
    For(i, 1, n) For(j ,1, n) s[1][i][j] = s[1][i-1][j-1] + a[i][j];
}

ll sum(int t, int i, int j, int u, int v) {
    if (!t) return s[t][i][j] - s[t][u-1][v];
    else return s[t][i][j] - s[t][u-1][v-1];
}

ll cal(int i, int j, int k) {
    if (k == 1) return 0;
    if (check[j][k]) return f[j][k];
    check[j][k] = true;
    ll cp2 = 2LL * sum(1,i, j + k - 1, i - k + 1, j) - a[i][j + k - 1] - a[i - k + 1][j];
    ll cp3 = (ll(k) - 1) * (sum(1,i,j+k-2,i-k+2,j) + sum(1,i-1,j+k-2,i-k+1,j));
    ll cp = cp2 + cp3;
    f[j][k] = cal(i,j,k-1) + cp;
    cp2 = 2LL * sum(0, i, j, i - k + 1, j) - a[i][j] - a[i - k + 1][j];
    cp3 = (ll(k) - 1) * (sum(0,i-1,j,i-k+1,j) + sum(0,i,j+1,i-k+2,j+1));
    cp = cp2 + cp3;
    f[j][k] = min(f[j][k], cal(i, j+1, k - 1) + cp);
    return f[j][k];
}

void solve() {
    init();
    cout << cal(n,1,n);
}

int main() {
    freopen("triangle.inp","r",stdin);
    freopen("triangle.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) For(j, 1, i) scanf("%d", &a[i][j]);
    solve();
}
