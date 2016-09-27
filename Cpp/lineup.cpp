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

int n, m, s[N][30], f[N][30], vt[N], k;
ll a[N];

bool cmp(int i, int j) {
    For(jj, 0, k) if (f[i][jj] != f[j][jj]) return f[i][jj] < f[j][jj];
    return i < j;
}

bool com(int i, int j) {
    For(jj, 0, k) if (f[i][jj] != f[j][jj]) return false;
    return true;
}

void solve() {
    For(i, 1, n) For(j, 0, k) {
        if ((a[i] >> j) & 1) s[i][j] = s[i-1][j] + 1; else s[i][j] = s[i-1][j] - 1;
        if (j) f[i][j] = s[i][j] - s[i][j-1];
        f[i][0] = s[i][0];
    }
    For(i, 0, n) vt[i] = i;
    sort(vt, vt + 1 + n, cmp);
    int i = 0, res = 0;
    while (i <= n) {
        int j = i;
        while (j < n && com(vt[i], vt[j+1])) j++;
        res = max(res, vt[j] - vt[i]);
        i = j + 1;
    }
    cout << res;
}

int main() {
    freopen("lineup.inp","r",stdin);
 //   freopen("lineup.out","w",stdout);
    scanf("%d %d", &n, &k);
    k--;
    For(i, 1, n) scanf("%d", &a[i]);
    solve();
}
