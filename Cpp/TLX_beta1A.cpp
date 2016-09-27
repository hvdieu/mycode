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
#define N 100010
#define MAX 10000

int n;
ii a[N];
ll t[4][N]; // 0 : so luong, 1 : sum fi, 2 : sum se, 3 : sum fi * se
ll res;

void update(int k, int i, int x) {
    for(i; i <= MAX; i += i & (-i)) t[k][i] += x;
}

ll get(int k, int i) {
    ll s = 0;
    for(i; i; i -= i & (-i)) s += t[k][i];
    return s;
}

int main() {
   // freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d%d", &a[i].fi, &a[i].se);
    sort(a+1, a+n+1);
    For(i, 1, n) {
        ll l0 = get(0, a[i].se), r0 = i-1-l0;
        ll tich = ll(a[i].fi) * a[i].se;
        ll l1 = get(1, a[i].se), r1 = get(1, MAX) - l1;
        ll l2 = get(2, a[i].se), r2 = get(2, MAX) - l2;
        ll l3 = get(3, a[i].se), r3 = get(3, MAX) - l3;
        res += tich*l0 - ll(a[i].fi) * l2 - ll(a[i].se) * l1 + l3;
        res -= tich*r0 - ll(a[i].fi) * r2 - ll(a[i].se) * r1 + r3;
        update(0, a[i].se, 1);
        update(1, a[i].se, a[i].fi);
        update(2, a[i].se, a[i].se);
        update(3, a[i].se, ll(a[i].fi) * a[i].se);
    }
    cout << res << endl;
}
