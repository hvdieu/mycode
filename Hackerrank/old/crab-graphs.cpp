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
#define N 210

int ntest, n, m, t, deg[N], flow;
int t1[N], t2[N], lef, righ, q[N];
vector<int> ke[N], f[N], c[N], op[N];
bool fr[N];

void cnt(int u, int v, int l) {
    ke[u].pb(v); f[u].pb(0); c[u].pb(l); op[u].pb(sz(ke[v]));
    ke[v].pb(u); f[v].pb(0); c[v].pb(0); op[v].pb(sz(ke[u])-1);
}

bool FindPath(int s, int t) {
    lef = righ = 0; reset(fr, true);
    q[++righ] = s;
    while (lef < righ) {
        int u = q[++lef];
        REP(j, sz(ke[u])) {
            int v = ke[u][j];
            if (fr[v] && f[u][j] < c[u][j]) {
                fr[v] = false; t1[v] = u; t2[v] = j;
                if (v == t) return true;
                q[++righ] = v;
            }
        }
    }
    return false;
}

void IncFlow(int s, int t) {
    int v = t;
    int temp = 10000000;
    while (v != s) {
        int u = t1[v], j = t2[v];
        temp = min(temp, c[u][j] - f[u][j]);
        v = u;
    }
    flow += temp;
    v = t;
    while (v != s) {
        int u = t1[v], j = t2[v];
        f[u][j] += temp; f[v][op[u][j]] -= temp;
        v = u;
    }
}

void solve() {
    For(i, 1, n) {
        cnt(0, i, min(t, deg[i]));
        cnt(n+i, 2*n+1, 1);
    }
    flow = 0;
    while (FindPath(0, 2*n+1))
	IncFlow(0, 2*n+1);
    cout << flow << endl;
}

int main() {
    freopen("star.inp","r",stdin);
    freopen("star.out","w",stdout);
    cin >> ntest;
    For(test, 1, ntest) {
        cin >> n >> t >> m;
        reset(deg, 0);
        For(i, 0, 2*n+1) {
            ke[i].clear(); f[i].clear(); c[i].clear(); op[i].clear();
        }
        int u, v;
        For(i, 1, m) {
            int u, v; cin >> u >> v;
            deg[u]++; deg[v]++;
            cnt(u, n+v, 1); cnt(v, n+u, 1);
        }
        solve();
    }
}


