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
#define N 510
#define inf 1000000000000LL

int m, n, a[N][N], s[N][N];
ll res;

ll get(int i, int l, int r) {
    if (l > r) return 0;
    return s[i][r] - s[i][l-1];
}

void solve() {
    res = -inf;
    For(l, 1, n) For(r, l+1, n) {
        ll sum = a[1][l] + a[1][r];
        ll ma = get(1, l+1, r-1);
        For(i, 2, m) {
        	sum += a[i][l] + a[i][r];
            res = max(res, ma + sum + get(i, l+1, r-1));
            ma = max(ma, -sum + a[i][l] + a[i][r] + get(i, l+1, r-1));
        }
    }
    cout << res;
}

int main() {
    freopen("choose2.inp","r",stdin);
    freopen("choose2.out","w",stdout);
    scanf("%d%d", &m, &n);
    For(i, 1, m) For(j, 1, n) {
        scanf("%d", &a[i][j]);
        s[i][j] = s[i][j-1] + a[i][j];
    }
    solve();
}
