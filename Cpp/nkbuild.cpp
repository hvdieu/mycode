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
#define bit(x, i) ((x >> (i-1)) & 1LL)
#define onbit(x, i) (x | (1LL << (i-1)))
#define N 110

const int inf = 1000000000;
const int TT = 1 << 11;

struct node {
    int u, val, tt;
    node (int _val, int _u, int _tt) {
        val = _val; u = _u; tt = _tt;
    }
};

bool operator > (node a, node b) {
    return a.val > b.val;
}

int n, kk, m, root, res;
int c[N][N], trace[N][N];
int dd[N];
int d[N], t[N];
bool fr[N];
vector<ii> kq, path;
priority_queue< ii, vector<ii>, greater<ii> > heap;
priority_queue< node, vector<node>, greater<node> > pq;
int f[N][TT];

void truyvet(int u, int v) {
    while (u != v) {
        kq.pb(ii(u, trace[u][v]));
        u = trace[u][v];
    }
}

void prim() {
    int w = 0;
    For(i, 1, n) d[i] = inf;
    d[root] = 0;
    reset(fr, true);
    heap.push(ii(0, root));
    path.clear();
    while (!heap.empty()) {
        int u = heap.top().se, val = heap.top().fi;
        heap.pop();
        if (val == d[u]) {
            int vv = t[u], uu = u;
            if (uu > vv) swap(uu, vv);
            if (uu) path.pb(ii(uu, vv));
            w += c[u][t[u]];
            For(v, 1, n) if (dd[v] && d[v] > d[u] + c[u][v]) {
                d[v] = d[u] + c[u][v];
                t[v] = u;
                heap.push(ii(d[v], v));
            }
        }
    }
    if (w < res) {
        res = w;
        kq.clear();
        For(i, 0, sz(path)-1) truyvet(path[i].fi, path[i].se);
        sort(all(kq));
        kq.erase(unique(all(kq)), kq.end());
    }
}

void sub2() {

    int T = (1 << kk) - 1;
    For(i, 1, n) For(j, 0, T) f[i][j] = inf;
    For(i, 1, n) {
        f[i][0] = 0;
        pq.push(node(f[i][0], i, 0));
        if (dd[i]) f[i][onbit(0, dd[i])] = 0, pq.push(node(0, i, onbit(0, dd[i])));
    }
    while (!pq.empty()) {
        int val = pq.top().val, u = pq.top().u, tt = pq.top().tt;
        pq.pop();
        if (u == 2 && tt == 1) {
        	bool flag = true;
		}
        if (val == f[u][tt]) {
            For(v, 1, n) if (f[v][tt] > f[u][tt] + c[u][v]) {
                f[v][tt] = f[u][tt] + c[u][v];
                pq.push(node(f[v][tt], v, tt));
            }
            For(tt2, 0, T)
			if ((tt2 & tt) == 0) {
                int newtt = tt2 | tt;
                if (f[u][newtt] > f[u][tt] + f[u][tt2]) {
                    f[u][newtt] = f[u][tt] + f[u][tt2];
                    pq.push(node(f[u][newtt], u, newtt));
                }
            }
        }
    }
    res = inf;
    For(i, 1, n) res = min(res, f[i][T]);
    cout << res;
}

int main() {
    //freopen("nkbuild.inp","r",stdin);
    //freopen("steiner.out","w",stdout);
    cin >> n >> m >> kk;
    For(i, 1, kk) {
        int u; cin >> u; dd[u] = i;
        root = u;
    }
    For(i, 1, n) For(j, 1, n) {
        if (i == j) c[i][j] = 0; else c[i][j] = inf;
        trace[i][j] = j;
    }

    For(i, 1, m) {
        int u, v, l; cin >> u >> v >> l;
        c[u][v] = min(c[u][v], l);
        c[v][u] = min(c[v][u], l);
    }
    For(k, 1, n) For(u, 1, n) For(v, 1, n) if (c[u][v] > c[u][k] + c[k][v]) {
        c[u][v] = c[u][k] + c[k][v];
        trace[u][v] = trace[u][k];
    }
    if (kk > 10) {
        res = inf;
        prim();
        For(i, 1, n) if (!dd[i]) {
            dd[i] = true;
            prim();
            dd[i] = false;
        }
        printf("%d\n", res);
        //printf("%d\n", sz(kq));
        //For(i, 0, sz(kq)-1) printf("%d %d\n", kq[i].fi, kq[i].se);
    } else sub2();
}
