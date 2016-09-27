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

struct group {
    int l, r, id;
};

int m, n, k, a[N], p, ma[N], mi[N], vt[N];
int ma1[N], mi1[N];
int r1, r2, r3;
int L, R;
group Q[N];
set<int>::iterator MAX, MIN;
int kq[N];

bool cmp(group a, group b) {
    if (a.l/p != b.l/p) return a.l/p < b.l/p;
    return a.r < b.r;
}

int brute(int l, int r) {
    int res = 0;
    For(i, l, r) ma1[a[i]] = max(ma1[a[i]], i), mi1[a[i]] = min(mi1[a[i]], i);
    For(i, l, r) res = max(res, ma1[a[i]] - mi1[a[i]]);
    For(i, l, r) ma1[a[i]] = 0, mi1[a[i]] = n+1;
    return res;
}

void push(int x, int i) {
    ma[x] = max(ma[x], i);
    mi[x] = min(mi[x], i);
    r1 = max(r1, ma[x] - mi[x]);
}

int main() {
   // freopen("input.txt","r",stdin);
   // freopen("output.txt","w",stdout);
    scanf("%d%d%d", &n, &m, &k);
    For(i, 1, n) scanf("%d", &a[i]);
    For(i, 1, k) scanf("%d%d", &Q[i].l, &Q[i].r), Q[i].id = i;
    p = trunc(sqrt(n));
    For(i, 1, m) mi1[i] = n + 1;
    sort(Q+1, Q+k+1, cmp);
    Q[0].l = -n;
    For(i, 1, k)
        if (Q[i].r - Q[i].l + 1 <= p) kq[Q[i].id] = brute(Q[i].l, Q[i].r);
        else if (Q[i].l/p != Q[i-1].l/p || Q[i-1].r - Q[i-1].l + 1 <= p) {
            L = (Q[i].l/p)*p; R = L + p - 1;
            For(j, 1, m) mi[j] = n+1, ma[j] = 0;
            r1 = 0;
            For(j, R+1, Q[i].r) push(a[j], j);
            r2 = r3 = 0;
            Rep(j, R, Q[i].l) {
                if (ma[a[j]]) r2 = max(r2, ma[a[j]] - j);
                if (vt[a[j]]) r3 = max(r3, vt[a[j]] - j);
                else vt[a[j]] = j;
            }
            Rep(j, R, Q[i].l) vt[a[j]] = 0;
            kq[Q[i].id] = max(max(r1, r2), r3);
        } else {
            For(j, Q[i-1].r+1, Q[i].r) push(a[j], j);
            r2 = r3 = 0;
            Rep(j, R, Q[i].l) {
                if (ma[a[j]]) r2 = max(r2, ma[a[j]] - j);
                if (vt[a[j]]) r3 = max(r3, vt[a[j]] - j);
                else vt[a[j]] = j;
            }
            Rep(j, R, Q[i].l) vt[a[j]] = 0;
            kq[Q[i].id] = max(max(r1, r2), r3);
        }
    For(i, 1, k) printf("%d\n", kq[i]);
}
