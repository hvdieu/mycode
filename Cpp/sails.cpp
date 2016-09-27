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

int n;
ii a[N];
ull t[4*N];
int f[4*N], mi[4*N], MAX, ma[4*N];

void down(int i, int lo, int hi) {
    if (!f[i]) return;
    int mid = (lo + hi) / 2;
    f[i*2] += f[i]; f[i*2+1] += f[i];
    mi[i*2] += f[i]; mi[i*2+1] += f[i];
    ma[i*2] += f[i]; ma[i*2+1] += f[i];
    t[i*2] += ll(f[i]) * (mid-lo+1);
    t[i*2+1] += ll(f[i]) * (hi - mid);
    f[i] = 0;
}

void update(int i, int lo, int hi, int u, int v, int x) {
	if (u > v) return;
    if (lo > v || hi < u) return;
    if (u <= lo && hi <= v) {
        t[i] += ll(x) * (hi - lo + 1);
        mi[i] += x; ma[i] += x;
        f[i] += x;
        return;
    }
    int mid = (lo + hi) / 2;
    down(i, lo, hi);
    update(i*2, lo, mid, u, v, x);
    update(i*2+1, mid+1, hi, u, v, x);
    t[i] = t[i*2] + t[i*2+1];
    mi[i] = min(mi[i*2], mi[i*2+1]);
    ma[i] = max(ma[i*2], ma[i*2+1]);
}

ll get(int i, int lo, int hi, int u, int v) {
    if (lo > v || hi < u) return 0;
    if (u <= lo && hi <= v) return t[i];
    int mid = (lo + hi) / 2;
    down(i, lo, hi);
    ll res = get(i*2, lo, mid, u, v) + get(i*2+1, mid+1, hi, u, v);
 //   t[i] = t[i*2] + t[i*2+1];
 //   mi[i] = min(mi[i*2], mi[i*2+1]);
 //   ma[i] = max(ma[i*2], ma[i*2+1]);
    return res;
}

int find(int i, int lo, int hi, int x, int tt) {
    if (lo == hi) return lo;
    int mid = (lo + hi) / 2;
    down(i, lo, hi);
    if (!tt) {
        if (x >= mi[i*2] && x <= ma[i*2]) return find(i*2, lo, mid, x, tt);
        else return find(i*2+1, mid+1, hi, x, tt);
    } else {
        if (x >= mi[i*2+1] && x <= ma[i*2+1]) return find(i*2+1, mid+1, hi, x, tt);
        else return find(i*2, lo, mid, x, tt);
    }
}

int main() {
    ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d%d", &a[i].fi, &a[i].se);
    sort(a+1, a+n+1);
    MAX = a[n].fi;
    ll res = 0;
    For(i, 1, n) {
        int x = a[i].fi, y = a[i].se;
        res += get(1, 1, MAX, x-y+1, x);
        int gt = get(1, 1, MAX, x-y+1, x-y+1);
        int u = find(1, 1, MAX, gt, 0), v = find(1, 1, MAX, gt, 1);
        if (v > x) v = x;
        int sl = v - (x - y + 1) + 1;
        update(1, 1, MAX, u, u+sl-1, 1);
        update(1, 1, MAX, v+1, x, 1);
    }
    printf("%lld", res);
}
