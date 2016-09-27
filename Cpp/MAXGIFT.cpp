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
#define N 301
#define inf 1000000000000000

int n, k, a[N];
ll f[N][N];
int trace[N][N];

int main() {
    freopen("maxgift.inp","r",stdin);
    freopen("maxgift.out","w",stdout);
    cin >> n >> k;
    For(i, 1, n) cin >> a[i];
    For(i, 0, n) For(j, 0, k) f[i][j] = -inf;
    f[0][0] = 0;
    For(i, 1, n) For(j, 1, min(k, i)) {
        int MIN = a[i];
        Rep(jj, i, 1) {
            MIN = min(MIN, a[jj]);
            if (f[i][j] < f[jj-1][j-1] + MIN) {
                f[i][j] = f[jj-1][j-1] + MIN;
                trace[i][j] = jj-1;
            }
        }
    }
    cout << f[n][k] << endl;
    int i = n, j = k;
    vector<int> tt;
    while (j > 1) {
        tt.pb(trace[i][j]);
        i = trace[i][j]; j--;
    }
    reverse(all(tt));
    FOR(x, tt) cout << *x << ' ';
}
