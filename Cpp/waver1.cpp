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
#define N 10010

int n, e, k;
vector<ii> ke[2][N];
int f[N][1001], d[N], kq[N];
bool in[N][1001];
queue<ii> q;
priority_queue<ii, vector<ii>, greater<ii> > heap;

inline void init() {
    reset(d, 0x7f);
    reset(f, 0x7f);
    reset(kq, 0x7f);
    f[0][0] = 0;
    For(i, 1, n) if (sz(ke[0][i]) <= 1) ke[0][0].pb(ii(i, 0));
    d[0] = 0; heap.push(ii(0, 0));
    while (!heap.empty()) {
        int val = heap.top().fi, u = heap.top().se; heap.pop();
        if (d[u] == val) {
            FOR(it, ke[0][u]) {
                int v = it->fi, w = it->se;
                if (d[v] > d[u] + w) {
                    d[v] = d[u] + w;
                    heap.push(ii(d[v], v));
                }
            }
        }
    }
}

inline void solve() {
    q.push(ii(0, 0)); in[0][0] = true;
    while (!q.empty()) {
        int u = q.front().fi, j = q.front().se; q.pop();
        kq[u] = min(kq[u], f[u][j]);
        in[u][j] = false;
        FOR(it, ke[0][u]) {
            int v = it->fi, w = it->se;
            if (f[v][j] > f[u][j] + w && f[u][j] + w <= d[v])
                if (!j || (j && f[u][j]+w < f[v][j-1])) {
                if (!in[v][j]) q.push(ii(v, j)), in[v][j] = true;
                f[v][j] = f[u][j] + w;
            }
        }
        if (j < k) FOR(it, ke[1][u]) {
            int v = it->fi, w = it->se;
            if (f[v][j+1] > f[u][j] + w && f[u][j]+w < f[v][j] && f[u][j] + w <= d[v] && f[u][j] + w < kq[v]) {
                f[v][j+1] = min(f[v][j+1], f[u][j] + w);
                if (!in[v][j+1]) q.push(ii(v, j+1)), in[v][j+1] = true;
            }
        }
    }
}

int main() {
   // freopen("input.txt","r",stdin);
   // freopen("output.txt","w",stdout);
    scanf("%d%d%d", &n, &e, &k);
    For(i, 1, n-1) {
        int u, v, w; scanf("%d%d%d", &u, &v, &w);
        ke[0][u].pb(ii(v, w));
        ke[0][v].pb(ii(u, w));
    }
    For(i, 1, e) {
        int u, v, w; scanf("%d%d%d", &u, &v, &w);
        ke[1][u].pb(ii(v, w));
        ke[1][v].pb(ii(u, w));
    }
    init();
    solve();
    For(i, 1, n) printf("%d\n", kq[i]);
}


