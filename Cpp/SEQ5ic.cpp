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
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 1000010
#define inf 1000000000000000000LL

int n, a[N];
ll f[5], g[5];

void solve() {
    For(i, 0, 4) f[i] = -inf;
    For(i, 1, n) {
        Rep(j, min(i-1, 4), 1) {
            int x = a[i]; if (j % 2) x = -x;
            ll y = f[j-1] + x;
            if (y > f[j]) {
                f[j] = y; g[j] = g[j-1];
            } else if (y == f[j]) g[j] += g[j-1];
        }
        if (a[i] > f[0]) {
            f[0] = a[i]; g[0] = 1;
        } else if (a[i] == f[0]) g[0]++;
    }
    cout << f[4] << ' ' << g[4];
}

int main() {
   // freopen("input.txt", "r", stdin);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d", a+i);
    solve();
}
