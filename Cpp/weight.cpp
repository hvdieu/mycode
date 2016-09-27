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
#define N 5010

vector<ii> l, res;
int q[N], f[N], pos[N], next[N], prev[N];
int n, m, ntest, nn;
vector<int> ke[N];
bool fr[N];

void dfs(int u) {
    fr[u] = false;
    FOR(v, ke[u]) if (fr[*v]) dfs(*v);
    pos[u] = nn; q[nn--] = u;
}

void TopoSort() {
    nn = n;
    reset(fr, true);
    For(i, 1, n) if (fr[i]) dfs(i);
}

void dp(int x) {
    reset(f, 0);
    f[x] = 1;
    For(i, pos[x], n) {
        int u = q[i];
        if (f[u] >= 2) f[u] = 2;
        FOR(v, ke[u]) f[*v] += f[u];
    }
}

void solve() {
    TopoSort();
    sort(all(l));
    For(u, 1, n) next[u] = prev[u] = u;
    For(u, 1, n) FOR(v, ke[u]) {
        if (next[u] == u || pos[next[u]] > pos[*v]) next[u] = *v;
        if (prev[*v] == *v || pos[prev[*v]] < pos[u]) prev[*v] = u;
    }
    FOR(it, l) {
        int u = it->fi, v = it->se;
        if (next[u] != v && prev[v] != u) continue;
        else res.pb(ii(u, v));
    }
}

int main() {
    freopen("weight.inp","r",stdin);
  //  freopen("weight.out","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d%d", &n, &m);
        l.clear(); res.clear();
        For(i, 1, n) ke[i].clear();
        For(i, 1, m) {
            int u, v; scanf("%d%d", &u, &v);
            ke[u].pb(v);
            l.pb(ii(u, v));
        }
        solve();
        printf("Case %d: %d\n", test, sz(res));
        FOR(it, res) printf("%d %d\n", it->fi, it->se);
    }
}


