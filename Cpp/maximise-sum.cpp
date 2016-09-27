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
#define N 100010

set<ll> ff;
set<ll>::iterator it;

int main() {
    ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    int ntest;
    ll s[N], M;
    int n;
    cin >> ntest;
    while (ntest) {
        ntest--;
        cin >> n >> M;
        For(i, 1, n) {
            ll x;
            cin >> x;
            s[i] = (s[i-1] + x) % M;
        }
        ff.erase(all(ff));
        ff.insert(0);
        ll res = 0;
        For(i, 1, n) {
            res = max(res, s[i]);
            it = ff.upper_bound(s[i]);
            if (it != ff.end()) res = max(res, s[i] - *it + M);
            ff.insert(s[i]);
        }
        cout << res << endl;
    }
}
