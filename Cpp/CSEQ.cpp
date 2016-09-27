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
#define N 10010
#define BASE 1000003

int n, ntest, l, r, f[2][N];
int ppow[BASE], ipow[BASE];

void add(int &a, int b) {
    a += b; if (a >= BASE) a -= BASE;
}

int C(int k, int n) {
    if (k > n) return 0;
    if (k == n) return 1;
    return (((ll(ppow[n]) * ipow[n-k]) % BASE) * ipow[k]) % BASE;
}

int solve(int k, int n) {
    /*int t = 0;
    For(i, 1, x) f[0][i] = 1;
    For(i, 2, n) {
        t = 1 - t;
        reset(f[t], 0);
        For(j, 1, x) For(jj, 1, j) add(f[t][j], f[1-t][jj]);
    }
    int res = 0;
    For(j, 1, x) add(res, f[t][j]);
    return res; */
    int res = 1;
    while (k || n) {
        res = (ll(res) * C(k % BASE, n % BASE)) % BASE;
        k /= BASE; n /= BASE;
    }
    return res;
}

int mu(int a, int n) {
    int res = 1;
    while (n) {
        if (n & 1) res = (ll(res)*a) % BASE;
        n >>= 1;
        a = (ll(a)*a) % BASE;
    }
    return res;
}

void init() {
    ppow[0] = 1; ipow[0] = mu(ppow[0], BASE-2);
    For(i, 1, BASE-1) {
        ppow[i] = (ll(ppow[i-1])*i) % BASE;
        ipow[i] = mu(ppow[i], BASE-2);
    }
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> ntest;
    init();
    For(test, 1, ntest) {
        cin >> n >> l >> r;
        int res = solve(r-l+1, n+r-l+1) - 1;
        if (res < 0) res += BASE;
        cout << res << endl;
    }
}
