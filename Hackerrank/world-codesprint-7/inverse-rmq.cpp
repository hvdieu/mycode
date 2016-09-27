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

const int N = (1 << 18) + 10;

int t[4*N], a[4*N], n, m;
int b[N], cnt[N], nn, vmax;
bool was[4*N];
int ans[4*N];
vector<ii> p;
set<int> num[50];

bool cmp(ii a, ii b) {
    if (a.se != b.se) return a.se > b.se;
    return a.fi < b.fi;
}

bool check(int i) {
    if (2*i+1 >= m) return true;
    if (ans[i] != min(ans[i*2+1], ans[i*2+2])) return false;
    return (check(i*2+1) & check(i*2+2));
}

bool solve() {
    REP(i, m) if (!was[i]) {
        int h = vmax-trunc(log(i+1)/log(2));
        if (num[h].empty()) return false;
        int now = i;
        auto it = num[h].begin();
        if (i) it = num[h].upper_bound(ans[(i-1)/2]);
        if (it == num[h].end()) return false;
        For(cnt, 1, h) {
            ans[now] = *it;
            was[now] = true;
            now = now*2 + 1;
        }
        num[h].erase(it);
    }
    return true;
}

int main() {
    //freopen("in.txt","r",stdin);
    cin >> n;
    m = 2*n-1;
    For(i, 1, m) cin >> a[i];
    sort(a+1, a+m+1);
    a[0] = a[1] - 1;
    vmax = trunc(log(n) / log(2)) + 1;
    For(i, 1, m)
        if (a[i] != a[i-1]) p.pb(ii(a[i], 1));
        else p.back().se++;
    sort(all(p), cmp);
    REP(i, sz(p)) if (p[i].se <= vmax) num[p[i].se].insert(p[i].fi);
   // FOR(i, p) cout << i->fi << ' ' << i->se << "\n";
    if (sz(p) != n) cout << "NO";
    else if (!solve()) cout << "NO";
    else {
       cout << "YES\n";
       REP(i, m) cout << ans[i] << ' ';
    }
}
