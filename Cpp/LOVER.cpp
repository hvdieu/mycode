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
#define ld long double
#define pb push_back
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define BASE 100003

ll n, k;
int gt[BASE+1];

int mu(int a, int n) {
    ll res = 1;
    while (n) {
        if (n & 1) res = (res * a) % BASE;
        n >>= 1;
        a = (ll(a) * a) % BASE;
    }
    return res;
}

int cal(int k, int n) {
    if (n < k) return 0;
    int x = (ll(gt[k]) * gt[n-k]) % BASE;
    x = mu(x, BASE-2);
    x = (ll(gt[n]) * x) % BASE;
    return x;
}

int C(ll k, ll n) {
    if (k > n) return 0;
    ll res = 1;
    while (k && n) {
        int x1 = k % BASE;
        int x2 = n % BASE;
        res = (res * cal(x1, x2)) % BASE;
        k /= BASE; n /= BASE;
    }
    return res;
}

int main() {
    freopen("lover.inp","r",stdin);
    freopen("lover.out","w",stdout);
    int ntest;
    cin >> ntest;
    gt[0] = 1;
    For(i, 1, BASE) gt[i] = (ll(gt[i-1]) * i) % BASE;
    while (ntest) {
        ntest--; cin >> n >> k;
        cout << C(k, n-k+1) << endl;
    }
}
