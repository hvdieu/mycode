#include <bits/stdc++.h>

using namespace std;

typedef pair<int, int> ii;

const int N = 100 + 5;
const int inf = 1e9;

int ntest, m, n, K1, K2;
bool a[N][N];
int d[N][N][2];
queue<ii> Q;
int bfs(int x0, int y0, int K, int t) {
    d[x0][y0][t] = 0;
    Q.push(ii(x0, y0));
    while (!Q.empty()) {
        int i = Q.front().first, j = Q.front().second;
        Q.pop();
        for(int d1 = -1; d1 <= 1; d1 += 2)
        for(int d2 = -1; d2 <= 1; d2 += 2)
        for(int d3 = 0; d3 <= K; d3++)
        for(int d4 = 0; d4 <= K - d3; d4++) {
            int u = i + d1*d3, v = j + d2*d4;
            if (u > 0 && v > 0 && u <= m && v <= n && !a[u][v] && d[u][v][t] > d[i][j][t] + 1) {
                d[u][v][t] = d[i][j][t] + 1;
                Q.push(ii(u, v));
            }
        }
    }
}

int main() {
    //ifstream cin("in.txt");
    cin >> ntest;
    while (ntest--) {
        cin >> m >> n >> K1 >> K2;
        for(int i = 1; i <= m; i++)
            for(int j = 1; j <= n; j++) {
                cin >> a[i][j];
                d[i][j][0] = d[i][j][1] = inf;
            }
        bfs(1, 1, K1, 0);
        bfs(1, n, K2, 1);
        int ans = inf;
        for(int i = 1; i <= m; i++)
            for(int j = 1; j <= n; j++) ans = min(ans, max(d[i][j][0], d[i][j][1]));
        if (ans == inf) cout << -1 << "\n"; else cout << ans << "\n";
    }
}
