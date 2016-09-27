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
    int d, c;
};

int n, q;
char s[N];
node t[4*N];
ll g[4*N], mem[4*N];
int f[4*N];

void join(int i, int lo, int hi) {
    int c1 = i*2, c2 = i*2+1;
    int mid = (lo + hi) / 2;
    t[i].d = t[c1].d; t[i].c = t[c2].c;
    if (t[c1].d == mid-lo+1) t[i].d = t[c1].d + t[c2].d;
    if (t[c2].c == hi-mid) t[i].c = t[c2].c + t[c1].c;
    t[i].val = t[c1].val + t[c2].val + ll(t[c1].c) * t[c2].d;
}

void init(int i, int lo, int hi) {
    if (lo == hi) {
        t[i].d = t[i].c = t[i].val = s[lo] - '0';
        return;
    }
    int mid = (lo + hi) / 2;
    init(i*2, lo, mid);
    init(i*2+1, mid+1, hi);
    join(i, lo, hi);
}

void full(int i, int len, int tt) {
    if (!tt) {
        t[i].d = t[i].c = t[i].val = 0;
    } else {
        t[i].d = t[i].c = len;
        t[i].val = ll(len)*(len+1) / 2;
    }
}

void down(int i, int lo, int hi) {
    if (!t[i].mem) return;
    int c1 = i*2, c2 = i*2+1;
    f[c1] = f[c2] = f[i];
    int mid = (lo + hi) / 2;
    full(c1, mid-lo+1, f[i]-1);
    full(c2, hi-mid, f[i]-1);
    f[i] = 0;
}

void Fill(int i, int lo, int hi, int u, int v, int x) {
    int len = (hi - lo + 1);
    if (u > hi || v < lo) return;
    if (u <= lo && hi <= v) {
        full(i, hi-lo+1, x); f[i] = x+1;
        return;
    }
    int mid = (lo + hi) / 2;
    down(i, lo, hi);
    update(i*2, lo, mid, u, v, x);
    update(i*2+1, mid+1, hi, u, v, x);
    join(i, lo, hi);
}

void update(int i, int lo, int hi, int u, int v) {
    int len = (hi - lo + 1);
    if (u > hi || v < lo) return;
    if (u <= lo && hi <= v) {
        g[i] = ll(len)*(len+1) / 2;

    }
}

int main() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d\n", &n, &q);
    scanf("%s\n", s+1);
    init(1, 1, n);
    printf("%lld\n", t[1].val);
    REP(i, q) {
        int u, v, x;
        scanf("%d%d%d", &u, &v, &x);
        update(1, 1, n, u, v, x);
        printf("%lld\n", t[1].val);
    }
}
