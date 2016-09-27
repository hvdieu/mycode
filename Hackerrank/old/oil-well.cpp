#include <vector>
#include <algorithm>
#include <math.h>
#include <iostream>
#include <stdio.h>
#include <string.h>
#include <cmath>
#include <cstring>
#include <queue>
#include <stack>

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
#define all(x) x.begin(), x.end()
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define two(i) (ll(1) << i)
#define bit(x, i) ( (x >> i) & 1 )
#define onbit(x, i) ( x | (1 << i ) )
#define N 51
#define inf 1000000000

int m, n, a[N][N], xmax, xmin, ymax, ymin, s[N][N];
int f[N][N][N][N];
bool was[N][N][N][N];

void input() {
    scanf("%d%d", &m, &n);
    For(i, 1, m) For(j, 1, n) {
        scanf("%d", &a[i][j]);
        s[i][j] = s[i-1][j] + s[i][j-1] - s[i-1][j-1] + a[i][j];
    }
}

int get(int i, int j, int u, int v) {
    return s[u][v] - s[u][j-1] - s[i-1][v] + s[i-1][j-1];
}

int cal(int i, int j, int u, int v) {
    if (i == u && j == v) return 0;
    if (was[i][j][u][v]) return f[i][j][u][v];
    was[i][j][u][v] = true;
    f[i][j][u][v] = inf;
    int x = 0;
    For(k, j, v) if (a[i][k]) x += max(u - i, max(k - j, v - k));
    For(k, i+1, u) if (get(k, j, k, v)) {
        f[i][j][u][v] = min(f[i][j][u][v], cal(k, j, u, v) + x);
        break;
    }

    x = 0;
    For(k, j, v) if (a[u][k]) x += max(u - i, max(k - j, v - k));
    Rep(k, u-1, i) if (get(k, j, k, v)) {
        f[i][j][u][v] = min(f[i][j][u][v], cal(i, j, k, v) + x);
        break;
    }

    x = 0;
    For(k, i, u) if (a[k][j]) x += max(max(k - i, u - k), v - j);
    For(k, j+1, v) if (get(i, k, u, k)) {
        f[i][j][u][v] = min(f[i][j][u][v], cal(i, k, u, v) + x);
        break;
    }

    x = 0;
    For(k, i, u) if (a[k][v]) x += max(max(k - i, u - k), v - j);
    Rep(k, v-1, j) if (get(i, k, u, k)) {
        f[i][j][u][v] = min(f[i][j][u][v], cal(i, j, u, k) + x);
        break;
    }
    return f[i][j][u][v];
}

void solve() {
    xmin = ymin = N;
    For(i, 1, m) For(j, 1, n) if (a[i][j]) {
        xmin = min(xmin, i); xmax = max(xmax, i);
        ymin = min(ymin, j); ymax = max(ymax, j);
    }
    int res = 0;
    if (xmax > xmin) res = cal(xmin, ymin, xmax, ymax);
    cout << res;
}

int main() {
    //freopen("input.txt","r",stdin);
  //  freopen("","w",stdout);
    input();
    solve();
}
