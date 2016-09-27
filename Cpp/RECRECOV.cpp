#include <bits/stdc++.h>

using namespace std;

const int N = 100 + 10;

int ntest, n, m, q[N], cnt;
vector<int> adj[N];
bool fr[N];
int res, match[N];

void dfs(int u) {
    fr[u] = false;
    for(int v : adj[u]) if (fr[v]) dfs(v);
    q[cnt--] = u;
}

bool visit(int u) {
    if (!fr[u]) return false;
    fr[u] = false;
    for(int v : adj[u])
    if (!match[v] || visit(match[v])) {
        match[v] = u;
        return true;
    }
    return false;
}

void solve() {
    cnt = n;
    fill(fr + 1, fr + n + 1, true);
    for(int i = 1; i <= n; i++)
        if (fr[i]) dfs(i);
    int res = 0;
    fill(match + 1, match + n + 1, 0);
    for(int i = n; i >= 1; i--) {
        int u = q[i];
        bool found = false;
        for(int v : adj[u])
        if (!match[v]) {
            match[v] = u; found = true;
            break;
        } else {
            fill(fr + 1, fr + n + 1, true);
            if (visit(match[v])) {
                match[v] = u; found = true;
                break;
            }
        }
        if (!found) res++;
    }
    printf("%d\n", res);
}

int main() {
    //freopen("input.txt", "r", stdin);
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d%d", &n, &m);
        for(int i = 1; i <= n; i++) adj[i].clear();
        for(int i = 1; i <= m; i++) {
            int u, v;
            scanf("%d%d", &u, &v);
            adj[u].push_back(v);
        }
        solve();
    }
}
