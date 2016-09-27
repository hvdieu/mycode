#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define FOR(i, f) for(auto i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 2000010

int n, cha[N], con[N];
vector<ii> ke[N];
ll f[N], g[N];
int ntest;

void dfs(int u) {
	con[u] = 1;
    FOR(it, ke[u]) {
        int v = it->fi, l = it->se;
        if (!cha[v]) {
            cha[v] = u;
            dfs(v);
            f[u] += f[v] + ll(l) * con[v];
            con[u] += con[v];
        }
    }
}

void visit(int u, ll sum) {
	
    FOR(it, ke[u]) {
        int v = it->fi; ll l = it->se;
        if (cha[v] == u) {
            ll x = f[u] - f[v] - l *con[v];
            g[v] = f[v] + sum + x + l * (n - con[v]);
            visit(v, sum + x + l * (n - con[v]));
        }
    }
}

void solve() {
    cha[1] = 1;
    dfs(1); g[1] = f[1];
    visit(1, 0);
    For(i, 1, n) printf("%lld\n", g[i]);
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d", &n);
        For(i, 1, n) { ke[i].clear(); cha[i] = 0; f[i] = g[i] = 0; }
        For(i, 1, n-1) {
            int u, v, l;
            scanf("%d%d%d", &u, &v, &l);
            ke[u].pb(ii(v, l)); ke[v].pb(ii(u, l));
        }
        solve();
    }
}
