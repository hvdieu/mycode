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
#define N 2010

int n, a[N][N], doc[N][N], ngang[N][N], res, h[N], g[N], s1[N][N], s2[N][N];

inline void init() {
    For(i, 2, n-1) For(j, 1, n-1) {
        if (a[i][j] == a[i][j+1]) doc[i][j] = 1; else doc[i][j] = 0;
        s1[i][j] = s1[i-1][j] + doc[i][j];
    }

    For(j, 2, n-1) For(i, 1, n-1) {
        if (a[i][j] == a[i+1][j]) ngang[i][j] = 1; else ngang[i][j] = 0;
        s2[i][j] = s2[i][j-1] + ngang[i][j];
    }
}

inline bool check(int i, int j, int len) {
    int x, u = i - len + 1, v = j - len + 1;
    x = s1[i][j] - s1[u-1][j];
    if (x) return false;
    x = s1[i][v-1] - s1[u-1][v-1];
    if (x) return false;
    x = s2[i][j] - s2[i][v-1];
    if (x) return false;
    x = s2[u-1][j] - s2[u-1][v-1];
    if (x) return false;
    return true;
}

void solve() {
    init();
    res = 0;
    For(i, 2, n-1) {
        For(j, 1, n-1) {
        if (doc[i][j]) h[j] = 0; else h[j]++;
        if (j > 1) {
            if (ngang[i][j]) g[j] = 0; else g[j] = g[j-1] + 1;
            int bound = min(g[j], h[j]);
            if (bound % 2) bound--;
            for (int len = bound; len >= res +1; len -= 2) {
                int u = i - len + 1, v = j - len + 1;
                if (check(i, j, len)) {
                    res = len;
                    break;
                }
            }
        }
        }
    }
    cout << res;
}

int main() {
    freopen("hole2.inp","r",stdin);
    freopen("hole2.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) For(j, 1, n) scanf("%d", &a[i][j]);
    solve();
}
