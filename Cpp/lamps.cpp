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
#define N 300010

struct node {
    int d, c, mem, sl;
};

int n, q;
char s[N];
node t[4*N], null;
ll f[4*N];
int g[4*N], mi[4*N], ma[4*N];

void down(int i) {
    if (!t[i].mem) return;
    t[i*2].mem = t[i*2+1].mem = t[i].mem;
    if (t[i].mem == 1) t[i*2].d = t[i*2].c = t[i*2+1].d = t[i*2+1].c = 0;
    else {
        t[i*2].d = t[i*2].c = t[i*2].sl;
        t[i*2+1].d = t[i*2+1].c = t[i*2+1].sl;
    }
    t[i].mem = 0;
}

node join(node l, node r) {
    node t; t.mem = 0;
    t.d = l.d; t.c = r.c;
    if (l.d == l.sl) t.d += r.d;
    if (r.c == r.sl) t.c += l.c;
    t.sl = l.sl + r.sl;
    return t;
}

void fill(int i, int lo, int hi, int u, int v, int x) {
    if (u > hi || v < lo) return;
    if (u <= lo && hi <= v) {
        if (x) t[i].d = t[i].c = hi - lo + 1;
        else t[i].d = t[i].c = 0;
        t[i].mem = x+1;
        return;
    }
    int mid = (lo + hi) / 2;
    down(i);
    fill(i*2, lo, mid, u, v, x);
    fill(i*2+1, mid+1, hi, u, v, x);
    t[i] = join(t[i*2], t[i*2+1]);
}

node get(int i, int lo, int hi, int u, int v) {
    if (u > hi || v < lo) return null;
    if (u <= lo && hi <= v) return t[i];
    int mid = (lo + hi) / 2;
    down(i);
    node l = get(i*2, lo, mid, u, v), r = get(i*2+1, mid+1, hi, u, v);
    return join(l, r);
}

ll sum (int l, int r, int x) {
    int len = r - l + 1;
    return ll(len) * x - (ll(l) + r) * len / 2 + len;
}

void update(int i, int lo, int hi, int u, int v, int x) {
    if (u > hi || v < lo || mi[i] >= x) return;
    int len = hi - lo + 1;
    if (u <= lo && hi <= v && ma[i] <= x) {
        g[i] = x; mi[i] = x; ma[i] = mi[i] = x;
        f[i] = sum(lo, hi, x);
        return;
    }
    int mid = (lo + hi) / 2;
    if (g[i]) {
        g[i*2] = g[i*2+1] = mi[i*2] = mi[i*2+1] = ma[i*2] = ma[i*2+1] = g[i];
        f[i*2] = sum(lo, mid, g[i]);
        f[i*2+1] = sum(mid+1, hi, g[i]);
        g[i] = 0;
    }
    update(i*2, lo, mid, u, v, x);
    update(i*2+1, mid+1, hi, u, v, x);
    f[i] = f[i*2] + f[i*2+1];
    mi[i] = min(mi[i*2], mi[i*2+1]);
    ma[i] = max(ma[i*2], ma[i*2+1]);
}

void init(int i, int lo, int hi) {
    if (lo == hi) {
        t[i].d = t[i].c = 0;
        t[i].mem = 0; t[i].sl = 1;
        return;
    }
    int mid = (lo + hi) / 2;
    init(i*2, lo, mid);
    init(i*2+1, mid+1, hi);
    t[i] = join(t[i*2], t[i*2+1]);
}

int main() {
    freopen("lamps.inp","r",stdin);
    freopen("lamps.out","w",stdout);
    scanf("%d%d\n", &n, &q);
    scanf("%s\n", s+1);
    int i = 1; null.d = null.c = null.mem = 0;
    init(1, 1, n);
    while (i <= n) {
        int j = i;
        while (j < n && s[i] == s[j+1]) j++;
        if (s[i] == '1') {
            update(1, 1, n, i, j, j);
            fill(1, 1, n, i, j, 1);
        }
        i = j + 1;
    }
    printf("%lld\n", f[1]);
    REP(i, q) {
        int u, v, k, uu, vv;
        scanf("%d%d%d", &u, &v, &k);
        if (k) {
            uu = u; vv = v;
            node x;
            if (v < n) {
                x = get(1, 1, n, v+1, n);
                vv += x.d;
            }
            if (u > 1) {
                x = get(1, 1, n, 1, u-1);
                uu -= x.c;
            }
            update(1, 1, n, uu, vv, vv);
        }
        fill(1, 1, n, u, v, k);
        printf("%lld\n", f[1]);
    }
}
