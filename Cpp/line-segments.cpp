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
#define N 100010

int n;
ii a[N];
int f[N], t[N];
vector<int> q;

void update(int i, int x) {
    for(i; i <= n; i += i & (-i)) t[i] = max(t[i], x);
}

int get(int i) {
    int s = 0;
    for(i; i; i -= i & (-i)) s = max(s, t[i]);
    return s;
}

void solve() {
    For(i, 1, n) q.pb(a[i].fi);
    sort(all(q));
    For(i, 1, n) a[i].fi = lower_bound(all(q), a[i].fi) - q.begin() + 1;
    q.clear();
    For(i, 1, n) q.pb(a[i].se);
    sort(all(q));
    For(i, 1, n) a[i].se = lower_bound(all(q), a[i].se) - q.begin() + 1;
    sort(a+1, a+n+1);
    int i = 1, res = 0;
    while (i <= n) {
        int j = i;
        while (j < n && a[j+1].fi == a[i].fi) j++;
        For(k, i, j) f[k] = get(a[k].se - 1) + 1, res = max(res, f[k]);
        For(k, i, j) update(a[k].se, f[k]);
        i = j + 1;
    }
   // cout << n << endl;
    //For(i, 1, n) cout << a[i].fi << ' ' << a[i].se << endl;
    cout << res << endl;
}

int main() {
   // freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d%d", &a[i].fi, &a[i].se);
    solve();
}


