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
#define N 101

int n, a[N], ntest, b[N];
ll w, res;

int main() {
   // freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> ntest;
    For(test, 1, ntest) {
        cin >> n >> w;
        For(i, 1, n) cin >> a[i];
        res = 0;
        b[n+1] = 0;
        Rep(i, n, 1) b[i] = max(b[i+1], a[i]);
        For(i, 1, n-1) {
            ll sl = w / a[i];
            ll du = w - sl*a[i];
            ll tien = sl * b[i+1];
            res = max(res, du + tien - w);
        }
        cout << res << endl;
    }
}
