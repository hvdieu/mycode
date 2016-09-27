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
#define N 200010

struct edge {
    int x, y1, y2, open;
    edge(int _open, int _x, int _y1, int _y2) {
        open = _open; x = _x; y1 = _y1; y2 = _y2;
    }
};

bool cmp(edge a, edge b) {
    return a.x < b.x;
}

int n, ntest;
int a[N], lef[N], righ[N], vt[N];
int t[10*N], f[10*N];
vector<ii> q;
vector<edge> Q;

void update(int i, int lo, int hi, int u, int v, int x) {
    if (u <= lo && hi <= v) {
        f[i] += x;
        if (f[i]) t[i] = hi-lo+1;
        else t[i] = t[i*2] + t[i*2+1];
        return;
    }
    if (lo > v || hi < u) return;
    int mid = (lo + hi) / 2;
    update(i*2, lo, mid, u, v, x);
    update(i*2+1, mid+1, hi, u, v, x);
    if (f[i]) t[i] = hi-lo+1;
    else t[i] = t[i*2] + t[i*2+1];
}

void solve() {
    sort(all(q));
    int dem = 0;
    For(i, 0, sz(q)-1) {
        if (!i || q[i].fi != q[i-1].fi) dem++;
        a[q[i].se] = dem;
    }
    For(i, 1, dem) vt[i] = 0;
    For(i, 1, n) {
        lef[i] = vt[a[i]]; vt[a[i]] = i;
    }
    For(i, 1, dem) vt[i] = n+1;
    Rep(i, n, 1) {
        righ[i] = vt[a[i]]; vt[a[i]] = i;
    }
    Q.clear();
    For(i, 1, n) {
        int x1, x2, y1, y2;
        x1 = lef[i] + 1; x2 = i;
        y1 = i; y2 = righ[i] - 1;
   //     cout << x1 << ' ' << y1 << ' ' << x2 << ' ' << y2 << endl;
        Q.pb(edge(1, x1, y1, y2));
        Q.pb(edge(0, x2+1, y1, y2));
    }
    sort(all(Q), cmp);
    For(i, 1, 4*dem) t[i] = f[i] = 0;
    ll res = 0;
    For(i, 0, sz(Q)-1) {
        if (i) {
            ll X = Q[i].x - Q[i-1].x;
            res += X * t[1];
        }
        if (Q[i].open) update(1, 1, n, Q[i].y1, Q[i].y2, 1);
        else update(1, 1, n, Q[i].y1, Q[i].y2, -1);
    }
   // cout << res << endl;
    if (res == ll(n)*(n+1)/2) printf("non-boring\n");
    else printf("boring\n");
}

int main() {
  //  freopen("input.txt","r",stdin);
  //  freopen("output.txt","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d", &n);
        q.clear();
        For(i, 1, n) {
            int x;
            scanf("%d", &x);
            q.pb(ii(x, i));
        }
        solve();
    }
}
