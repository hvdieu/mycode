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
#define N 1010

int n, m, ntest, timer, res;
int f[N];
bool indfs[N], dd[N];
vector<int> ke[N];
bool cycle;

void dfs(int u) {
    indfs[u] = true; dd[u] = true;
    f[u] = 1;
    FOR(v, ke[u]) {
        if (!dd[*v]) {
            dfs(*v); f[u] = max(f[u], f[*v] + 1);
        } else if (indfs[*v]) cycle = true;
        else f[u] = max(f[u], f[*v] + 1);
    }
    res = max(res, f[u]);
    indfs[u] = false;
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &ntest);
    for(int test = 1; test <= ntest; test++) {
        int u, v; scanf("%d%d", &n, &m);
        for(int i = 0; i < n; i++) ke[i].clear(), f[i] = dd[i] = 0;
        for(int i = 1; i <= m; i++) {
            scanf("%d%d", &u, &v);
            ke[u].push_back(v);
        }
        cycle = false;
        res = 0;
        for(int i = 0; i < n; i++) if (!dd[i]) {
            dfs(i);
        }
        if (!cycle) printf("Case %d: %d semester(s)\n", test, res);
        else printf("Case %d: Never Ends\n", test);
    }
}


