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
#define N 301

int m, n, k, s[N][N], res, a[N];

void solve() {
    res = m*n+1;
    For(l, 1, n)
	For(r, l, n) {
        For(i, 1, m) a[i] = a[i-1] + s[i][r] - s[i][l-1];
        int j = 1;
        For(i, 1, m) if (a[i] >= k) {
            while (j < i && a[i] - a[j] >= k) j++;
            if (a[i] - a[j-1] >= k) res = min(res, (r-l+1) * (i-j+1));
        }
    }
    cout << res;
}

int main() {
    freopen("find.inp","r",stdin);
    freopen("find.out","w",stdout);
    scanf("%d %d %d\n", &m, &n, &k);
    For(i, 1, m) {
        char ss[N];
        scanf("%s\n", (ss+1));
        For(j, 1, n) {
            s[i][j] = s[i][j-1];
            if (ss[j] == '.') s[i][j]++;
        }
    }
    solve();
}
