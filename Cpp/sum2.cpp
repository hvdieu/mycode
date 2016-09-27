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
#define BASE 1000000

ll n;
int ntest, p;
ll res;

void add(ll &a, ll b) {
    a += b; if (a >= BASE) a %= BASE;
}

int main() {
   // freopen("input.txt","r",stdin);
   // freopen("sum2.out","w",stdout);
    cin >> ntest;
    For(test, 1, ntest) {
        cin >> n;
        p = trunc(sqrt(n));
        res = 0;
        For(i, 1, p) add(res, n / i);
        ll i = p + 1;
        while (i <= n) {
            ll x = n / i;
            ll j = n / x;
            add(res, ((j - i + 1) * x) % BASE);
            i = j + 1;
        }
        cout << res << endl;
    }
}
