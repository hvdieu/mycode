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
#define N 2000

int h, n, lose;
int a[N][N], f[N][N], g[N][N][2];

int main() {
   // freopen("input.txt","r",stdin);
   // freopen("output.txt","w",stdout);
    scanf("%d%d%d", &n, &h, &lose);
    For(i, 1, n) {
        int k; scanf("%d", &k);
        For(j, 1, k) {
            int u; scanf("%d", &u);
            a[i][u]++;
        }
    }
    For(i, 1, n) f[i][h] = a[i][h], g[i][h][0] = max(g[i-1][h][0], f[i][h]);
    Rep(i, n, 1) g[i][h][1] = max(g[i+1][h][1], f[i][h]);
    Rep(j, h-1, 0) {
        For(i, 1, n) {
            f[i][j] = f[i][j+1] + a[i][j];
            if (j + lose <= h) f[i][j] = max(f[i][j], max(g[i-1][j+lose][0], g[i+1][j+lose][1]) + a[i][j] );
            g[i][j][0] = max(g[i-1][j][0], f[i][j]);
        }
        Rep(i, n, 1) g[i][j][1] = max(g[i+1][j][1], f[i][j]);
    }
    int res = 0;
    For(i, 1, n) res = max(res, f[i][0]);
    //cout << g[2][7][0] << endl;
    cout << res;
}
