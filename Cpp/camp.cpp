#include <bits/stdc++.h>

using namespace std;

const int N = 17;
const long long inf = 1000000000000000000;

int n, m, T;
long long d[N][N], w, f[N][1 << N], g[1 << N];

int main() {
    freopen("camp.inp", "r", stdin);
    freopen("camp.out", "w", stdout);
    cin >> n >> m >> w;
    for (int i = 0; i <= n+1; i++)
      for (int j = 0; j <= n+1; j++)
        if (i != j) d[i][j] = inf; else d[i][j] = 0;
    for (int i = 1; i <= m; i++) {
        int u, v; long long l;
        cin >> u >> v >> l;
        d[u][v] = min(d[u][v], l);
        d[v][u] = min(d[v][u], l);
    }
    for (int k = 0; k <= n+1; k++)
      for (int i = 0; i <= n+1; i++)
        for (int j = 0; j <= n+1; j++)
          d[i][j] = min(d[i][j], d[i][k] + d[k][j]);

    //for (int i = 0; i <= n+1; i++) {
    //    for (int j = 0; j <= n+1; j++) cout << d[i][j] << ' '; cout << endl;
    //}
    T = 1 << n;
    for (int i = 1; i <= n; i++)
      for (int tt = 0; tt < T; tt++) f[i][tt] = inf;
    for (int i = 1; i <= n; i++) f[i][1 << (i-1)] = d[0][i];
    for (int tt = 0; tt < T; tt++)
      for (int i = 1; i <= n; i++) if (f[i][tt] < inf)
        for (int j = 1; j <= n; j++) if ((tt & (1 << (j-1))) == 0) {
            int newtt = tt | (1 << (j-1));
            f[j][newtt] = min(f[j][newtt], f[i][tt] + d[i][j]);
        }
    //cout << T << endl;
    g[0] = 0;
    for (int tt = 1; tt < T; tt++) {
        g[tt] = inf;
        for (int i = 1; i <= n; i++)
            g[tt] = min(g[tt], f[i][tt] + d[i][n+1]);
       //     cout << g[tt] << ' ';
    }
    //cout << endl;
    long long kq = inf;
    for (int t1 = 0; t1 < T; t1++) if (g[t1] < inf)
    for (int t2 = 0; t2 < T; t2++) if (g[t2] < inf && (t1 & t2 == 0) && g[T-1-t1-t2] < inf)
        kq = min(kq, max(max(g[t1], g[t2]), g[T-t1-t2]));
    cout << kq + w*n;
}
