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
#define N 2001
#define inf 1000000000000000LL

struct node {
    ll val;
    int u;
    node(ll a, int b) {
        val = a; u = b;
    }
};

bool operator > (const node &a, const node &b) {
    return a.val > b.val;
}

int n, c[4], L, k[N], m, g[N], nn ;
vector<int> dd[N];
bool ke[N][N];
ii b[N];
ll d[N];
priority_queue<node, vector<node>, greater<node> > heap;

void init() {
    sort(b+1, b+m+1);
    int dem = 0;
    b[0].fi = -1;
    For(i, 1, m) {
        if (b[i].fi != b[i-1].fi) dem++;
        g[dem] = b[i].fi;
        dd[b[i].se].pb(dem);
    }
    For(i, 1, L) {
        For(x, 0, k[i]-1) For(y, 0, x - 1) {
            int u = dd[i][x], v = dd[i][y];
            ke[u][v] = true; ke[v][u] = true;
        }
    }
    nn = n; n = dem;
}

void solve() {
    init();
    For(i, 1, n) d[i] = inf;
    d[1] = 0;
    heap.push(node(0, 1));
    while (!heap.empty()) {
        int u = heap.top().u;
        ll gt = heap.top().val;
        heap.pop();
        if (gt == d[u]) {
            ll cp;
            For(v, 1, n) if (u != v) {
                if (ke[u][v]) cp = c[2] + c[3];
                else {
                    if (u > v) cp = c[1] * (g[u] - g[v]);
                    else cp = c[0] * (g[v] - g[u]);
                }
                if (d[v] > d[u] + cp) {
                    d[v] = d[u] + cp;
                    heap.push(node(d[v], v));
                 }
            }
        }
    }
    ll res = inf;
    For(i, 1, n) {
        ll cp;
        if (g[i] > nn) cp = ll(c[1]) * (g[i] - nn);
        else cp = ll(c[0]) * (nn - g[i]);
        res = min(res, d[i] + cp);
    }
    cout << res;
}

int main() {
    freopen("lift.inp","r",stdin);
    freopen("lift.out","w",stdout);
    scanf("%d", &n);
    For(i, 0, 3) scanf("%d", &c[i]);
    scanf("%d", &L);
    b[++m] = make_pair(1, 0);
    For(i, 1, L) {
        scanf("%d", &k[i]);
        For(j, 1, k[i]) {
            int x;
            scanf("%d", &x);
            b[++m] = make_pair(x, i);
        }
    }
    solve();
}
