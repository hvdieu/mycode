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
#define N 110

int n, m, a[N][N], k, res;
bool fr[N][N], dd[N][N];

const int h[4] = {1, 0, -1, 0};
const int c[4] = {0, 1, 0, -1};
const int lef[4] = {3, 0, 1, 2};
const int righ[4] = {1, 2, 3, 0};

void dfs(int i, int j, int dir, int len) {
    res = max(res, len);
    fr[i][j] = false;
    int u = i + h[dir], v = j + c[dir];
    if (u >= 0 && v >= 0 && u <= m && v <= n && fr[u][v]) {
        if (!dd[u][v]) dfs(u, v, dir, len+1);
        else if (!a[u][v]) dfs(u, v, righ[dir], len+1);
        else dfs(u, v, lef[dir], len+1);
    }
}

void solve() {
    reset(fr, true);
    dfs(0, 0, 0, 0);
    reset(fr, true);
    dfs(0, 0, 1, 0);
    cout << res + 1;
}

int main() {
    freopen("path.inp","r",stdin);
    freopen("path.out","w",stdout);
    scanf("%d %d %d", &n, &m, &k);
    n--; m--;
    For(i, 1, k) {
        int u, v, l;
        scanf("%d %d %d", &u, &v, &l);
        a[v][u] = l; dd[v][u] = true;
    }
    solve();
}
