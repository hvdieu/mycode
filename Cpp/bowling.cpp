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
#define N 600010
#define inf 1000000000000000000LL

int n, ntest, m, a[N], r;
ll s[N], f[N][2], g[N][2], res;

void solve() {
    For(i, 1, m) s[i] = s[i-1] + a[i];
    f[0][0] = 0; f[0][1] = -inf;
    g[0][0] = 0; g[0][1] = -inf;
    res = -inf;
    For(i, 1, m) {
        f[i][0] = f[i-1][0];
        f[i][1] = f[i-1][1];
        if (i > 2*r) {
            int j = i - 2*r - 1;
            f[i][1] = max(f[i][1], s[i] + max(g[j][0], g[j][1]));
        }
        g[i][0] = max(g[i-1][0], f[i][0] - s[i]);
        g[i][1] = max(g[i-1][1], f[i][1] - s[i]);
        res = max(res, f[i][1]);
    }
    printf("%lld\n", res);
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("bowling.inp","r",stdin);
    freopen("bowling.out","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d%d", &n, &r);
        m = 0;
        For(i, 1, r) a[++m] = 0;
        For(i, 1, n) scanf("%d", &a[++m]);
        For(i, 1, r) a[++m] = 0;
        solve();
    }
}
