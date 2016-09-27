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
#define bit(x, i) ((x >> (i-1)) & 1LL)
#define onbit(x, i) (x | (1LL << (i-1)))
#define offbit(x, i) (x & ~(1 << (i-1)))
#define N 5010
#define inf 1000000000000000LL
struct node {
    int u;
    ll val;
    node(ll _val, int _u) {
        val = _val; u = _u;
    }
};

bool operator > (node a, node b) {
    return a.val > b.val;
}

int n, m, ntest, k;
vector<ii> ke[N];
int id[N], gt[N];
ll f[11][N], g[11][1200];
int T;
priority_queue<node, vector<node>, greater<node> > heap;

void Dij(int s, int vt) {
    For(i, 1, n) f[vt][i] = inf;
    f[vt][s] = 0; heap.push(node(0, s));
    while (!heap.empty()) {
        ll val = heap.top().val; int u = heap.top().u;
        heap.pop();
        if (val == f[vt][u]) {
            FOR(it, ke[u]) {
                int v = it->fi, l = it->se;
                if (f[vt][v] > f[vt][u] + l) {
                    f[vt][v] = f[vt][u] + l;
                    heap.push(node(f[vt][v], v));
                }
            }
        }
    }
}

void solve() {
    T = (1 << k) - 1;
    For(i, 1, k) For(j, 0, T) g[i][j] = inf;
    For(i, 1, k) g[i][onbit(0, i)] = f[0][gt[i]];
    For(tt, 0, T) For(i, 1, k) if (bit(tt, i)) {
        int u = gt[i];
        For(j, 1, k) if (!bit(tt, j)) {
            int newtt = onbit(tt, j), v = gt[j];
            g[j][newtt] = min(g[j][newtt], g[i][tt] + f[i][v]);
        }
    }
    ll res = inf;
    For(i, 1, k) res = min(res, g[i][T] + f[i][1]);
    if (res == inf) cout << -1 << endl; else cout << res << endl;
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d%d%d", &n, &m, &k);
        For(i, 1, n) ke[i].clear();
        reset(id, 0);
        gt[0] = 1;
        For(i, 1, k) {
            int x; scanf("%d", &x);
            id[x] = i; gt[i] = x;
        }
        For(i, 1, m)  {
            int u, v, l; scanf("%d%d%d", &u, &v, &l);
            ke[u].pb(ii(v, l)); ke[v].pb(ii(u, l));
        }
        For(i, 0, k) Dij(gt[i], i);
        solve();
    }
}


