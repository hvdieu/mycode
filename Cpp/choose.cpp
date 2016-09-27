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
#define inf 1000000000
int m, n, a[N][N], res;

void solve() {
    res = -inf;
    For(l, 1, n) For(r, l+1, n) {
        int m1 = - inf, m2 = -inf;
        For(i, 1, m) {
            int x = a[i][l] + a[i][r];
            if (x > m1) {
                m2 = m1; m1 = x;
            } else if (x > m2) m2 = x;
        }
        res = max(res, m1 + m2);
    }
    cout << res;
}

int main() {
    freopen("choose.inp","r",stdin);
    freopen("choose.out","w",stdout);
    scanf("%d %d", &m, &n);
    For(i, 1, m) For(j, 1, n) scanf("%d", &a[i][j]);
    solve();
}
