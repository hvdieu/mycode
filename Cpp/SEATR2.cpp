#include <bits/stdc++.h>

using namespace std;

const int N = 500 + 1;
const int M = 20000 + 1;
const int BASE = int(1e9) + 7;

int n, m, ntest, cha[N], res;
vector<int> ke[N];
int f[N][M];

void add(int &a, int b) {
    a += b; if (a >= BASE) a -= BASE;
}

void dfs(int u) {
    for(int v : ke[u]) if (!cha[v]) {
        cha[v] = u;
        dfs(v);
    }
    for(int x = 1; x <= m; x++) {
        f[u][x] = 1;
        for(int v : ke[u]) if (cha[v] == u) {
            int tmp = 0;
            for(int y = x; y <= m; y += x) add(tmp, f[v][y]);
            f[u][x] = ((long long)f[u][x] * tmp) % BASE;
        }
    }
}

int main() {
   // freopen("input.txt", "r", stdin);
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d%d", &n, &m);
        for(int i = 1; i <= n; i++) ke[i].clear();
        for(int i = 1; i < n; i++) {
            int u, v;
            scanf("%d%d", &u, &v);
            ke[u].push_back(v); ke[v].push_back(u);
        }
        fill(cha+1, cha+n+1, 0);
        cha[1] = 1;
        dfs(1);
        res = 0;
        for(int x = 1; x <= m; x++) add(res, f[1][x]);
        cout << res << "\n";
    }
}
