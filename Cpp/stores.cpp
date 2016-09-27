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
#define inf 1000000007

int n, s[N];
pair<int, char> a[N];
vector<int> ss;
int t[2][N];

void update(int k, int i, int x) {
    for(i; i <= n+1; i += i & (-i)) t[k][i] = min(t[k][i], x);
}

int get(int k, int i) {
    int res = inf;
    for(i; i; i -= i & (-i)) res = min(res, t[k][i]);
    return res;
}

int main() {
    freopen("stores.inp","r",stdin);
    freopen("stores.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d %c\n", &a[i].fi, &a[i].se);
    sort(a+1, a+n+1);
    For(i, 1, n) {
        if (a[i].se == 'G') s[i] = s[i-1]+1; else s[i] = s[i-1]-1;
        ss.pb(s[i]);
    }
    ss.pb(0);
    sort(all(ss));
    For(i, 0, n) s[i] = lower_bound(all(ss), s[i]) - ss.begin() + 1;
    For(i, 1, n+1) t[0][i] = t[1][i] = inf;
    int res = 0;
    update(0, s[0], a[1].fi);
    update(1, s[1], a[2].fi);
    For(i, 2, n) {
        int x = get(i % 2, s[i]);
        res = max(res, a[i].fi - x);
        if (i < n) update(i % 2, s[i], a[i+1].fi);
    }
    cout << res;
}


