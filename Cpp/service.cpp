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
const int N = 510;
const int M = 10010;
const ll inf = 1000000000000000000LL;

int n, m, q;
ll a[N][N], d[N];
int r1, r2, r3;
vector<ii> ke[N];
ll res;

int main() {
   // freopen("service.inp","r",stdin);
   // freopen("output.txt","w",stdout);
    scanf("%d%d%d", &n, &m, &q);
    For(i, 1, n) For(j, 1, n) {
        if (i != j) a[i][j] = inf; else a[i][j] = 0;
    }
    For(i, 1, m) {
        int u, v, l; scanf("%d%d%d", &u, &v, &l);
        a[u][v] = a[v][u] = l;
        ke[u].pb(ii(v, l)); ke[v].pb(ii(u, l));
    }
    For(k, 1, n) For(u, 1, n) For(v, 1, n) a[u][v] = min(a[u][v], a[u][k] + a[k][v]);
    int tmp;
    For(test, 1, q) {
        scanf("%d%d%d", &r1, &r2, &r3);
        For(u, 1, n) d[u] = min(a[r1][u], min(a[r2][u], a[r3][u]));
        res = 0;
        For(u, 1, n) if (u != r1 && u != r2 && u != r3) {
            tmp = 1000000001;
            FOR(it, ke[u]) if (it->se < tmp && d[u] == d[it->fi] + it->se) tmp = it->se;
            res += tmp;
        }
        printf("%lld\n", res*100);
    }
}
