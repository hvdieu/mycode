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

const int N = 1e5 + 5;
const int M = 1e9 + 7;

int n, x, a[N];
long long sum;
multiset<ll> f;

ll pw(ll a, ll n) {
    ll ans = 1;
    while (n) {
        if (n & 1) ans = (ans * a) % M;
        n >>= 1;
        a = (a * a) % M;
    }
    return ans;
}

int main() {
    //freopen("in.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> n >> x;
    For(i, 1, n) cin >> a[i], sum += a[i];
    For(i, 1, n) f.insert(sum - a[i]);
    while (true) {
        ll last = *f.begin(); f.erase(f.begin());
        if (last > sum) {
            cout << pw(x, sum);
            return 0;
        }
        For(i, 2, x) {
            ll tmp;
            if (f.empty()) tmp = -1; else tmp = *f.begin();
            if (tmp != last) {
                cout << pw(x, last);
                return 0;
            } else f.erase(f.begin());
        }
        f.insert(last+1);
    }
}


