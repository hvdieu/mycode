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
#define BASE 1000007
#define N 100001
#define K 101

int n, k, f[N][K];

void add(int &a, int b) {
    a += b; if (a >= BASE) a -= BASE;
}

int main() {
    freopen("bitstr.inp","r",stdin);
    freopen("bitstr.out","w",stdout);
    cin >> n >> k; k--;
    f[0][0] = 1;
    int res = 1;
    For(i, 1, n) {
        For(j, 0, min(k, i)) {
            add(f[i][0], f[i-1][j]);
            if (j > 0) add(f[i][j], f[i-1][j-1]);
        }
        res = (res * 2) % BASE;
    }
    For(j, 0, k) {
        res -= f[n][j];
        if (res < 0) res += BASE;
    }
    cout << res;
}
