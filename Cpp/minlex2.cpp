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
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))

const int lim = trunc(sqrt(1e9));

int l, r, k;
bool found;
vector<int> a, b;
int f[11][2][2][2][lim];
bool was[11][2][2][2][lim];
int mu[10];

int gmin(int a, int b, int has) {
    int la = a, lb = b;
    if (a < 0) return b;
    vector<int> aa, bb;
    aa.clear(); bb.clear();
    while (a) aa.pb(a % 10), a /= 10;
    while (b) bb.pb(b % 10), b /= 10;
    if (has) {
        while (sz(aa) < sz(bb)) aa.pb(0);
        while (sz(aa) > sz(bb)) bb.pb(0);
    }
    reverse(all(aa)); reverse(all(bb));
    REP(i, min(sz(aa), sz(bb)))
    if (aa[i] < bb[i]) return la;
    else if (aa[i] > bb[i]) return lb;
    return sz(aa) < sz(bb) ? la : lb;
}

int find(int i, int ok1, int ok2, int has, int mod) {
    if (was[i][ok1][ok2][has][mod]) return f[i][ok1][ok2][has][mod];
    if (i == sz(a)) {
        if (!mod) return 0;
        return -1;
    }
    int d = 0, c = 9;
    if (!ok1) d = a[i];
    if (!ok2) c = b[i];
    int res = -1;
    For(ch, d, c) {
        int tt1, tt2, has1;
        if (ok1 || ch > d) tt1 = 1; else tt1 = 0;
        if (ok2 || ch < c) tt2 = 1; else tt2 = 0;
        if (has || ch != 0) has1 = 1; else has1 = 0;
        int y = find(i+1, tt1, tt2, has1, (mod*10 + ch) % k);
        if (y != -1) {
            int xx = ch * mu[sz(a) - i - 1] + y;
            res = gmin(res, xx, has);
        }
    }
    was[i][ok1][ok2][has][mod] = true;
    f[i][ok1][ok2][has][mod] = res;
    return res;
}

int main() {
   //freopen("input.txt", "r", stdin);
   // cout << gmin(0, 1, 1) << endl;
    mu[0] = 1; For(i, 1, 9) mu[i] = mu[i-1] * 10;
    while (cin >> l >> r >> k) {
        if (k > lim) {
            int res = -1;
            int x = (l / k) * k;
            if (x < l) x += k;
            while (x <= r) {
                res = gmin(res, x, 0);
                x += k;
            }
            cout << res << endl;
        } else {
            a.clear(); b.clear();
            while (l) a.pb(l % 10), l /= 10;
            while (r) b.pb(r % 10), r /= 10;
            while (sz(a) < sz(b)) a.pb(0);
            reverse(all(a)); reverse(all(b));
        //    REP(i, sz(a)) cout << a[i] << ' '; cout << endl;
        //    REP(i, sz(b)) cout << b[i] << ' '; cout << endl;
            found = false;
            reset(f, -1);
            reset(was, false);
            int res = find(0, 0, 0, 0, 0);
            //cout << f[1][1][1][0] << endl;
            cout << res << endl;
        }
    }
}

