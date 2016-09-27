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
#define N 200010
#define M 210
#define inf 100000000

int f[2][M], c[M][M], a[N], n, m, k, ntest;

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d%d%d", &m, &k, &n);
        For(i, 1, m) For(j, 1, m) if (i == j) c[i][j] = 0; else c[i][j] = inf;
        For(i, 1, k) {
            int u, v; scanf("%d%d", &u, &v);
            c[u][v] = c[v][u] = 1;
        }
        For(i, 1, n) scanf("%d", a+i);
       // For(i, 1, n) cout << a[i] << ' '; cout << endl;
        For(k, 1, m) For(i, 1, m) For(j, 1, m) if (i != j && c[i][k] == 1 && c[k][j] == 1) c[i][j] = 1;
        int t = 0;
        f[0][0] = f[1][0] = inf;
        For(j, 1, m) f[0][j] = min(c[a[1]][j], f[0][j-1]);
        For(i, 2, n) {
            t = 1 - t;
            For(j, 1, m) f[t][j] = min(f[t][j-1], f[1-t][j] + c[a[i]][j]);
        }
        if (f[t][m] < inf) printf("%d\n", f[t][m]);
        else printf("-1\n");
    }
}
