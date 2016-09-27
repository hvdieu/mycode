#include <bits/stdc++.h>

using namespace std;

const int N = 100000 + 10;

int ntest, n, a[N], l, r, q[N];
int res[N], cnt;
vector<int> adj[N];
vector<int> id;

void bfs(int i) {
    l = r = 0; q[++r] = i;
    for(int l = 1; l <= r; l++) {
    	int u = q[l];
        for(int v : adj[u]) if (!res[v]) {
            if (abs(a[u]) == v) res[v] = res[u] * v / a[u];
            else if (a[v] == res[u]*u) res[v] = 1; else res[v] = -1;
            if (res[v] == 1) cnt++;
            q[++r] = v;
        }
    }
}

void solve() {
    fill(res+1, res+n+1, 0);
    for(int i = 1; i <= n; i++) if (!res[i]) {
        res[i] = 1; cnt = 1;
        bfs(i);
        if (cnt < r - cnt) for(int j = 1; j <= r; j++) res[q[j]] = -res[q[j]];
    }
    for(int i = 1; i <= n; i++) if (res[i] == 1) printf("A"); else printf("B");
    printf("\n");
}

int main() {
   // freopen("input.txt", "r", stdin);
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d", &n);
        for(int i = 1; i <= n; i++) adj[i].clear();
        for(int i = 1; i <= n; i++) {
            scanf("%d", a + i);
            adj[i].push_back(abs(a[i]));
            adj[abs(a[i])].push_back(i);
        }
        solve();
    }
}
