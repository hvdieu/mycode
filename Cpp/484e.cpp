#include <bits/stdc++.h>
using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ld long double
#define pb push_back
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 100001

struct node {
    int l, r, val;
};

struct query {
    int d, c, mid, w, u, v, id;
};

int n, mm, m, res[N];
ii a[N];
query q[N];
node t[4*N];

bool cmp(query a, query b) {
    return a.mid < b.mid;
}

void init(int i, int lo, int hi) {
    t[i].val = 0; t[i].l = 0; t[i].r = 0;
    if (lo == hi) return;
    int mid = (lo + hi) / 2;
    init(i*2, lo, mid);
    init(i*2+1, mid+1, hi);
}

void update(int i, int lo, int hi, int u) {
    if (u > hi || u < lo) return;
    if (lo == hi) {
        t[i].val = 1; t[i].l = 1; t[i].r = 1;
        return;
    }
    int mid = (lo + hi) / 2;
    update(i*2, lo, mid, u);
    update(i*2+1, mid+1, hi, u);
    t[i].l = t[i*2].l;
    if (t[i*2].l == mid - lo + 1) t[i].l = t[i*2+1].l + t[i*2].l;
    t[i].r = t[i*2+1].r;
    if (t[i*2+1].r == hi - mid) t[i].r = t[i*2+1].r + t[i*2].r;
    t[i].val = max(max(t[i].l, t[i].r), max(t[i*2].val, t[i*2+1].val));
    t[i].val = max(t[i].val, t[i*2].r + t[i*2+1].l);
}

node get(int i, int lo, int hi, int u, int v) {
    node res;
    res.l = 0; res.r = 0; res.val = 0;
    if (lo > v || hi < u) return res;
    if (u <= lo && hi <= v) return t[i];
    int mid = (lo + hi) / 2;
    node c1 = get(i*2, lo, mid, u, v);
    node c2 = get(i*2+1, mid+1, hi, u, v);
    res.l = c1.l;
    if (c1.l == mid-lo+1) res.l = c1.l + c2.l;
    res.r = c2.r;
    if (c2.r == hi-mid) res.r = c1.r + c2.r;
    res.val = max(max(c1.val, c2.val), max(res.l, res.r));
    res.val = max(res.val, c1.r + c2.l);
    return res;
}

int main() {
    freopen("484e.inp","r",stdin);
   // freopen("484e.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) {
        scanf("%d", &a[i].fi); a[i].se = i;
        mm = max(mm, a[i].fi);
    }
    sort(a+1, a+1+n);
    scanf("%d", &m);
    For(i, 1, m) {
        scanf("%d %d %d",&q[i].u, &q[i].v, &q[i].w);
        q[i].d = 1; q[i].c = n; q[i].id = i;
    }

    while (1) {
        bool stop = true;
        For(i, 1, m) if (q[i].d <= q[i].c) {
            q[i].mid = (q[i].d + q[i].c) / 2;
            stop = false;
        } else q[i].mid = 0;
        if (stop) break;
        sort(q+1, q+1+m, cmp);
        int j = n+1;
        init(1, 1, n);
        Rep(i, m, 1) if (!q[i].mid) break; else {
            while (j > 1 && a[j-1].fi >= a[q[i].mid].fi) {
                j--;
                update(1, 1, n, a[j].se);
            }
            node x = get(1, 1, n, q[i].u, q[i].v);
            if (x.val >= q[i].w) {
                res[q[i].id] = a[q[i].mid].fi; q[i].d = q[i].mid + 1;
            } else q[i].c = q[i].mid - 1;
        }
    }
    For(i, 1, m) printf("%d\n", res[i]);
}
