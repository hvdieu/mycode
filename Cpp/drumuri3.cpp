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
#define N 101
#define K 5001
#define BASE 10007

int n, k, q, m, f[N][K], res[K], g[N][K];
vector<int> ke[N];
vector<ii> query[N];

void Do(int start) {
    reset(f, 0); reset(g, 0);
    f[start][1] = 1; g[start][1] = 1;
    For(j, 2, k) For(u, 1, n) {
        For(jj, 0, sz(ke[u])-1) {
            int v = ke[u][jj];
            f[u][j] = (f[v][j-1] + f[u][j]) % BASE;
        }
        g[u][j] = (g[u][j-1] + f[u][j]) % BASE;
    }
}

int main() {
    freopen("drumuri3.in","r",stdin);
    freopen("drumuri3.out","w",stdout);
    scanf("%d %d %d %d", &n, &m, &k, &q);
    For(i, 1, m) {
        int u, v;
        scanf("%d %d", &u, &v);
        ke[u].pb(v); ke[v].pb(u);
    }

    For(i, 1, q) {
        int u, v;
        scanf("%d %d", &u, &v);
        if (u > v) swap(u, v);
        query[u].pb(ii(v, i));
    }

    For(u, 1, n) if (sz(query[u])) {
        Do(u);
        For(j, 0, sz(query[u])-1) {
            int v = query[u][j].fi;
            res[query[u][j].se] = g[v][k];
        }
    }

    For(i, 1, q) printf("%d\n", res[i]);
}
