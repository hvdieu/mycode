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
#define N 16

const ll a[4] = { 1000, 2000, 3000, 5000 };

int ntest, c;
ll w, mu[16];

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    mu[0] = 1;
    For(i, 1, 15) mu[i] = mu[i-1]*10;
    cin >> ntest;
    For(test, 1, ntest) {
        ll res = 0;
        cin >> w;
        cin >> c;
        Rep(i, c, 0) Rep(j, 3, 0) {
            res += w / (a[j]*mu[i]);
            w %= (a[j]*mu[i]);
        }
        cout << res << ' ' << 1 << endl;
    }
}
