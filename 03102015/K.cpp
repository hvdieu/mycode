#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define REP(i, n) for(int i = 0; i < n; i++)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define getbit(x, i) ((x >> (i-1)) & 1LL)
#define onbit(x, i) (x | (1LL << (i-1)))
#define offbit(x, i) (x & ~(1 << (i-1)))
#define N 210

int n, f[N], ntest, m;
int a[N], b[N], res;

bool can(int i, int j) {
    if (i <= n && j <= n) {
        if (a[i] > a[j] && b[i] > b[j]) return true;
        return false;
    }
    if (i > n && j > n) {
        if (a[i] > a[j]) return true;
        return false;
    }
    if (i <= n && j > n) {
        if (a[i] > 2*a[j] && b[i] > 2*a[j]) return true;
        return false;
    }
    if (i > n && j <= n) {
        double xx = double(a[j]) / 2, yy = double(b[j]) / 2;
        double zz = sqrt(xx*xx + yy*yy);
        if (zz < a[i]) return true;
        return false;
    }
}

void dfs(int i) {
    if (f[i]) return;
    f[i] = 1;
    For(j, 1, n+m) if (i != j)
    if (can(i, j)) {
        dfs(j);
        f[i] = max(f[i], f[j] + 1);
    }
    res = max(res, f[i]);
}

void solve() {
    res = 0;
    reset(f, 0);
    For(i, 1, n+m) dfs(i);
  //  For(i, 1, n+m) cout << f[i] << ' '; cout << endl;
    cout << res << endl;
}

int main() {
   // freopen("input.txt","r",stdin);
  //  freopen("","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d", &n);
        For(i, 1, n) {
            scanf("%d%d", a+i, b+i);
            if (a[i] > b[i]) swap(a[i], b[i]);
        }
        scanf("%d", &m);
        For(i, 1, m) scanf("%d", &a[i + n]);
        solve();
    }
}


