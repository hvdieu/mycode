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

const int h[4] = {-1, 0, 1, 0};
const int c[4] = {0, 1, 0 ,-1};

char a[N][N];
int m, n, lab[N][N], sl[N*N], dem, res;
bool dd[N*N];

void dfs(int i, int j) {
    lab[i][j] = dem;
    sl[dem]++;
    For(k, 0, 3) {
        int u = i + h[k], v = j + c[k];
        if (u && v && u <= m && v <= n && !lab[u][v] && a[u][v] == '0') dfs(u, v);
    }
}

int main() {
    freopen("matrix14.inp","r",stdin);
    freopen("matrix14.out","w",stdout);
    scanf("%d %d\n", &m, &n);
    For(i, 1, m) scanf("%s\n", a[i]+1);
    For(i, 1, m) For(j, 1, n) if (a[i][j] == '0' && !lab[i][j]) {
        dem++;
        dfs(i, j);
    }
    For(j, 1, n) {
        if (a[1][j] == '0') dd[lab[1][j]] = true;
        if (a[m][j] == '0') dd[lab[m][j]] = true;
    }

    For(i, 1, m) {
        if (a[i][n] == '0') dd[lab[i][n]] = true;
        if (a[i][1] == '0') dd[lab[i][1]] = true;
    }
    For(i, 1, dem) if (!dd[i]) res = max(res, sl[i]);
    cout << res;
}
