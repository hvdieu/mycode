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

ll n, s, x, l, r;

int main() {
   // freopen("tdepth.inp","r",stdin);
   // freopen("tdepth.out","w",stdout);
    cin >> n;
    int deg = 1;
    x = 1;
    s = 0;
    while (s + x*2 < n) {
		s += x*2; x *= 2, deg++;
	}
    cout << deg << endl;
    n = n - s;
    ll pos;
    if (n <= x) pos = (n-1)*2 + 1;
    else pos = (n-1-x)*2 + 2;
    s += x*2;
    ll l = s + 1, r = s + x*2+1;
    cout << l + pos-1 << ' ' << r + pos-1;
}
