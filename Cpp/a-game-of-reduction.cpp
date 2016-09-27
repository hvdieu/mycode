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
#define N 1000010
#define BASE 1000000007

int n, m, ntest;
int f[N], g[N], gt[N];
int cs[10], l;

void tach(int x) {
    l = 0;
    while (x) {
        cs[++l] = x % 10; x /= 10;
    }
}

int join(int j) {
    int x = 0;
    Rep(i, l, j+2) x = x * 10 + cs[i];
    x = x * 10 + ((cs[j] + cs[j+1]) % 10);
    Rep(i, j-1, 1) x = x * 10 + cs[i];
    return x;
}

void init() {
    int n = 1000000;
    gt[0] = 1;
    For(i, 1, n) gt[i] = (ll(gt[i-1]) * i) % BASE;
    //tach(12345);
    //cout << join(3) << endl;
    For(i, 10, n) {
        tach(i);
        For(j, 1, l-1) {
            int y = join(j);
            if (f[y] == 0) f[i] = 1;
        }
        g[i] = f[i] + g[i-1];
    }
}

ll pw(ll a, int n) {
    ll res = 1;
    while (n) {
        if (n & 1) res = (ll(res) * a) % BASE;
        n >>= 1;
        a = (ll(a) * a) % BASE;
    }
    return res;
}

ll C(int k, int n) {
    if (k == n) return 1;
    if (!k) return 1;
    ll x = gt[n];
    ll y = (ll(gt[k]) * gt[n-k]) % BASE;
    return (ll(x) * pw(y, BASE-2)) % BASE;
}

int main() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &ntest);
    init();
   // cout << C(5, 20) << endl;
 //   cout << f[1923];
  //  For(i, 1, 100) cout << gt[i] << ' '; cout << endl;
    For(test, 1, ntest) {
        scanf("%d%d", &n, &m);
        int r2 = g[n], r1 = n - r2;
        int res = 0;
        For(i, 1, m) {
            int x; scanf("%d", &x);
            res = res ^ f[x];
            if (f[x]) r2--; else r1--;
        }
        int kq = pw(2, r1);
        int sum = 0;
        cout << kq << endl;
        cout << r1 << ' ' << r2 << endl;
        For(i, 0, r2) if (i % 2 == res) sum = (sum + C(i, r2)) % BASE;
        cout << sum << endl;
        kq = (ll(kq) * sum) % BASE;
        if (res == 0) kq--;
        cout << kq << endl;
    }
}


