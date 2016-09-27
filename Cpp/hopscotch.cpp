#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define x first
#define y second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 760
#define BASE 1000000007

int m, n, k, a[N][N], dem[N*N], p, id[N*N], q;
int f[N][N], sum[N][N], cot[N][N];
vector<int> mau;
vector<ii> ke[N*N];
vector<int> l;

inline void add(int &a, int b) {
    a += b;
    if (a >= BASE) a -= BASE;
}

inline void sub(int &a, int b) {
    a -= b;
    if (a < 0) a += BASE;
}

void trau() {
    f[1][1] = 1;
    For(i, 2, m) For(j, 2, n) For(u, 1, i-1) For(v, 1, j-1) if (a[i][j] != a[u][v]) add(f[i][j], f[u][v]);
    cout << f[m][n] << endl;
}

void solve() {
    p = trunc(sqrt(m*n));
    For(i, 1, k) if (dem[i] > p) mau.pb(i);
    For(i, 0, sz(mau)-1) id[mau[i]] = i+1;
    f[1][1] = 1; For(i, 1, max(m, n)) sum[i][1] = sum[1][i] = 1;
    if (dem[a[1][1]] > 1) For(j, 1, n) cot[j][id[a[1][1]]] = 1;
    For(i, 2, m) {
        l.clear();
        For(j, 2, n) {
            int c = a[i][j];
            f[i][j] = sum[i-1][j-1];
            if (dem[c] <= p) {
                For(jj, 0, sz(ke[c])-1) {
                    int u = ke[c][jj].x, v = ke[c][jj].y;
                    if (u >= i) break;
                    if (v < j) sub(f[i][j], f[u][v]);
                }
            } else {
                l.pb(j);
                c = id[c];
                For(v, 1, j-1) sub(f[i][j], cot[v][c]);
            }
            add(sum[i][j], sum[i-1][j]); add(sum[i][j], sum[i][j-1]);
            add(sum[i][j], f[i][j]); sub(sum[i][j], sum[i-1][j-1]);
        }

        For(jj, 0, sz(l)-1) {
            int j = l[jj], c = id[a[i][j]];
            add(cot[j][c], f[i][j]);
        }
    }
    printf("%d", f[m][n]);
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("hopscotch.in","r",stdin);
    freopen("hopscotch.out","w",stdout);
    scanf("%d%d%d", &m, &n, &k);
    For(i, 1, m) For(j, 1, n) {
        scanf("%d", &a[i][j]);
        dem[a[i][j]]++;
        ke[a[i][j]].pb(ii(i, j));
    }
    //trau();
    solve();
}
