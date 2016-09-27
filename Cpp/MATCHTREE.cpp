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
#define N 1500001

int n, BASE;
int f[N][2], g[N][2], cha[N];
vector<int> ke[N];
int a[N], b[N], c[N], d[N];
int maxM, cntM;

void add(int &a, int b) {
    a += b; if (a >= BASE) a -= BASE;
}

void mul(int &a, int b) {
    a = (ll(a) * b) % BASE;
}

void dfs(int u) {
    g[u][0] = 1;
    FOR(v, ke[u]) {
        if (!cha[*v]) {
            cha[*v] = u;
            dfs(*v);
        }
    }
    int m = 0;
    a[0] = 0; b[0] = 1;
    FOR(v, ke[u]) if (cha[*v] == u) {
        ++m; b[m] = b[m-1];
        int MAX = max(f[*v][0], f[*v][1]);
        a[m] = a[m-1] + MAX;
        f[u][0] += MAX;
        int x = 0;
        if (MAX == f[*v][0]) add(x, g[*v][0]);
        if (MAX == f[*v][1]) add(x, g[*v][1]);
        mul(g[u][0], x);
        mul(b[m], x);
    }
    m++;
    c[m] = 0; d[m] = 1;
    Rep(j, sz(ke[u])-1, 0) {
        int v = ke[u][j]; if (cha[v] == u) {
            --m; d[m] = d[m+1];
            int MAX = max(f[v][0], f[v][1]);
            c[m] = c[m+1] + MAX;
            int x = 0;
            if (MAX == f[v][0]) add(x, g[v][0]);
            if (MAX == f[v][1]) add(x, g[v][1]);
            mul(d[m], x);
        }
    }
    m--;
    FOR(v, ke[u]) if (cha[*v] == u) {
        m++;
        int x = a[m-1] + c[m+1] + f[*v][0] + 1;
        int y = (((ll(b[m-1]) * (d[m+1])) % BASE) * g[*v][0]) % BASE;
        if (x > f[u][1]) {
            f[u][1] = x;
            g[u][1] = y;
        } else if (x == f[u][1]) add(g[u][1], y);
    }
}

int main() {
    //ios_base::sync_with_stdio(false);
  //  freopen("matchtree.inp","r",stdin);
  //  freopen("matchtree.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n-1) {
        int u, v; scanf("%d%d", &u, &v);
        ke[u].pb(v); ke[v].pb(u);
    }
    scanf("%d", &BASE);
    cha[1] = 1;
    dfs(1);
    maxM = max(f[1][0], f[1][1]);
    cntM = 0;
    if (maxM == f[1][0]) add(cntM, g[1][0]);
    if (maxM == f[1][1]) add(cntM, g[1][1]);
    cout << maxM << endl << cntM;
}
