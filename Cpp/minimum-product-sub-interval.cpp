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
struct node {
    int f, d, c, g, lm, sum;
    int vt;
};

int n, q;
node t[8*N];

node join(node l, node r) {
    if (l.f == -1) return r;
    if (r.f == -1) return l;
    node t;
    t.sum = l.sum + r.sum;
    if (l.f <= r.f) t.f = l.f, t.vt = l.vt;
    else t.f = r.f, t.vt = r.vt;
    t.d = l.d; if (l.d == l.sum) t.d += r.d;
    t.c = r.c; if (r.c == r.sum) t.c += l.c;
    int x = l.c + r.d;
    if (l.g >= r.g) t.g = l.g, t.lm = l.lm;
    else t.g = r.g, t.lm = l.sum + r.lm;
    if (t.d >= t.g) t.g = t.d, t.lm = 1;
    if (t.c > t.g) t.g = t.c, t.lm = t.sum - t.c + 1;
    else if (t.c == t.g && t.lm > t.sum -t.c+1) t.lm = t.sum - t.c + 1;
    if (x > t.g) t.g = x, t.lm = l.sum - l.c + 1;
    else if (x == t.g && t.lm > l.sum - l.c + 1) t.lm = l.sum - l.c + 1;
    return t;
}

void update(int i, int lo, int hi, int u, int x) {
    if (u > hi || u < lo) return;
    if (lo == hi) {
        t[i].sum = 1;
        t[i].f = x; t[i].vt = lo;
        if (x == 1) {
            t[i].d = t[i].g = t[i].c = 1;
            t[i].lm = 1;
        } else {
            t[i].d = t[i].g = t[i].c = 0;
            t[i].lm = 0;
        }
        return;
    }
    int mid = (lo + hi) / 2;
    update(i*2, lo, mid, u, x); update(i*2+1, mid+1, hi, u, x);
    t[i] = join(t[i*2], t[i*2+1]);
}

node get(int i, int lo, int hi, int u, int v) {
    if (u <= lo && hi <= v) return t[i];
    if (u > hi || v < lo) {
        node res; res.f = -1; return res;
    }
    int mid = (lo + hi) / 2;
    node res, l, r;
    l = get(i*2, lo, mid, u, v);
    r = get(i*2+1, mid+1, hi, u, v);
    res = join(l, r);
    return res;
}

int main() {
    freopen("input.txt","r",stdin);
    freopen("output.txt","w",stdout);
    scanf("%d%d", &n, &q);
    For(i, 1, n) {
        int x; scanf("%d", &x);
        update(1, 1, n, i, x);
    }
    For(i, 1, q) {
        int kind, u, v;
        scanf("%d%d%d", &kind, &u, &v);
        if (kind == 1) {
            node x = get(1, 1, n, u, v);
            if (x.f == 0) printf("0 %d %d\n", u, v);
            else if (x.f == 1) printf("1 %d %d\n", u + x.lm - 1, u + x.lm + x.g - 2);
            else printf("%d %d %d\n", x.f, x.vt, x.vt);
        } else update(1, 1, n, u, v);
    }
}


