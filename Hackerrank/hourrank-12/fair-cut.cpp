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

const int N = 3000 + 5;
const ll inf = 1e18;

int n, k;
ll f[N][N], a[N];

int main() {
    //freopen("in.txt","r",stdin);
    cin >> n >> k;
    For(i, 1, n) cin >> a[i];
    sort(a+1, a+n+1);
    For(i, 0, n) For(j, 0, k) f[i][j] = inf;
    f[0][0] = 0;
    For(i, 1, n) For(j, 0, min(k, i)) {
        ll x = f[i-1][j] + a[i]*j - a[i]*(k-j); // don't put a[i] to I
        ll y = inf;
        if (j > 0) y = f[i-1][j-1] + a[i]*(i-j) - a[i]*(n-i-k+j);
        f[i][j] = min(x, y);
    }
    cout << f[n][k];
}


