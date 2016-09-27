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
#define N 100010
#define inf 1000000000000000LL
struct triple {
    int x, g, d;
};

bool cmp(triple a, triple b) {
    return a.x < b.x;
}

int n;
ll s[N], f[N], t[N], res;
triple a[N];
vector<ll> q;

void update(int i, ll val) {
    for(i; i <= n; i += i & (-i)) t[i] = min(t[i], val);
}

ll get(int i) {
    ll s = inf;
    for(i; i; i -= i & (-i)) s = min(s, t[i]);
    return s;
}

int main() {
    freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d%d%d", &a[i].x, &a[i].g, &a[i].d);
   // sort(a+1, a+n+1, cmp);
    For(i, 1, n) {
        s[i] = s[i-1] + a[i].d;
        f[i] = f[i-1] + a[i].g;
        q.pb(s[i] - a[i].x);
    }
    sort(all(q)); q.erase(unique(all(q)), q.end());
    For(i, 1, n) t[i] = inf;
    For(i, 1, n) {
        int j = lower_bound(all(q), s[i] - a[i].x) - q.begin(); j++;
        //cout << j << ' ';
        res = max(res, f[i] - )
        res = max(res, a[i].g);
        update(j, f[i]);
    }
    cout << res;
}
