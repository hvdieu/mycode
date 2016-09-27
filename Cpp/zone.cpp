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
#define N 51

const int h[4] = {-1,0,1,0};
const int c[4] = {0,1,0,-1};

int n, dir[N*N], dd[N][N], x, y, l, X, Y, op[4], res;
bool fr[N][N][N][N], flag, visited[N][N];

bool find(int i, int j, int u, int v,int k) {
    while (i && j && u && v && i <= n && j <= n && u <= n && v <= n) {
        if (fr[i][j][u][v]) return true;
        i += h[k]; j += c[k]; u += h[k]; v += c[k];
    }
    return false;
}

void dfs(int i, int j) {
    int u,v;
    visited[i][j] = true;
    res++;
    if (!fr[i-1][j-1][i-1][j]) {
        u = i + h[0], v = j + c[0];
        if (u && v && u <= n && v <= n && !visited[u][v]) dfs(u,v);
        flag &= find(i-1,j-1,i-1,j,0);
    }

    if (!fr[i-1][j][i][j]) {
        u = i + h[1], v = j + c[1];
        if (u && v && u <= n && v <= n && !visited[u][v]) dfs(u,v);
        flag &= find(i-1,j,i,j,1);
    }

    if (!fr[i][j-1][i][j]) {
        u = i + h[2], v = j + c[2];
        if (u && v && u <= n && v <= n && !visited[u][v]) dfs(u,v);
        flag &= find(i,j-1,i,j,2);
    }

    if (!fr[i-1][j-1][i][j-1]) {
        u = i + h[3], v = j + c[3];
        if (u && v && u <= n && v <= n && !visited[u][v]) dfs(u,v);
        flag &= find(i-1,j-1,i,j-1,3);
    }
}

void solve() {
    int bound = dd[x][y];
    x = X; y = Y;
    For(i, 1, bound) {
        int k = dir[i];
        int u = x + h[k], v = y + c[k];
        fr[x][y][u][v] = false;
        fr[u][v][x][y] = false;
        x = u; y = v;
    }
    flag = true;
    dfs(1,1);
    if (flag) cout << res; else cout << n * n - res;
}

int main() {
    freopen("zone.inp","r",stdin);
    freopen("zone.out","w",stdout);
    cin >> x >> y >> n >> l;
    X = x; Y = y;
    op[0] = 2; op[2] = 0; op[1] = 3; op[3] = 1;
    For(i, 1, l) {
        cin >> dir[i];
        dir[i]--;
        int k = dir[i];
        int u = x + h[k], v = y + c[k];
        fr[x][y][u][v] = true;
        fr[u][v][x][y] = true;
        x = u; y = v;
        if (i < l) dd[x][y] = i;
    }
    cout << l - dd[x][y] << endl;
    solve();
}
