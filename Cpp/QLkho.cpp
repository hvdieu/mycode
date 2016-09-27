#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 310
#define inf 1000000000

int ntest, n, m, a[N];
int f[N][N];

bool check(int L) {
    For(i, 0, m) For(j, 0, n) f[i][j] = inf;
    f[0][0] = 0;
    For(i, 0, m-1) For(j, 0, n) if (f[i][j] < inf) {
        f[i+1][j] = min(f[i+1][j], f[i][j]);
        int x = a[i+1] / L;
        f[i+1][ min(n, j+x) ] = min(f[i+1][ min(n, j+x) ], f[i][j] + a[i+1]);
    }
    return f[m][n] < inf;
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    while (1) {
        scanf("%d%d", &n, &m);
        if (!n && !m) break;
        int c = 0;
        For(i, 1, m) {
            scanf("%d", a+i); c = max(c, a[i]);
        }
        int d = 1, L = 0, Y = 0;
        while (d <= c) {
            int mid = (d + c) / 2;
            if (check(mid)) {
                L = mid; Y = f[m][n];
                d = mid + 1;
            } else c = mid - 1;
        }
        cout << L << ' ' << Y << endl;
    }
}
