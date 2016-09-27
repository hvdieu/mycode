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
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 1010
#define BUG 0
#define P 1000000LL

int m, n, k, a[11][11];
ll BASE, res;
bool fr[101];


ll mod(ll a, ll b) {
    ll c = a % P;
    a /= P;
    ll l = (((a * b) % BASE) * P) % BASE;
    ll r = (c * b) % BASE;
    return (l + r) % BASE;
}

ll mu(ll a, ll n) {
    ll res = 1;
    while (n) {
        if (n & 1) res = mod(res, a);
        n >>= 1;
        a = mod(a, a);
    }
    return res;
}

int main() {
    freopen("L.INP","r",stdin);
    freopen("L.OUT","w",stdout);
    cin >> m >> n >> BASE;
    int k = m - n;
    ll res = 1;
    ll x = 1;
    For(i, 1, m*m - n*n) res = mod(res, i);
   // cout << res << endl;
    For(i, 1, m) For(j, 1, m) {
        if (i > k && j > k) continue;
        int hook = m - i + 1 + m - j;
        if (i > k) hook -= n;
        if (j > k) hook -= n;
        x = mod(x, hook);
    }
    //cout << x << endl;
    x = mu(x, BASE-2);
    res = mod(res, x);
    cout << res;
}
