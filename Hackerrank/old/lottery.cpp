#include <bits/stdc++.h>

using namespace std;

typedef pair<int, int> ii;

#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)

const int N = 200000 + 10;
const int inf = 100000000;

int n, m, p[N], q[N];
vector<int> ke[N];
int res, d[N];
int was[N], timer;

bool bfs() {
    queue<int> Q;
    for(int i = 1; i <= n; i++) {
        if (!p[i]) {
            d[i] = 0;
            Q.push(i);
        } else d[i] = inf;
    }
    d[0] = inf;
    while (!Q.empty()) {
        int u = Q.front(); Q.pop();
        if (u) {
            for(int j = 0; j < ke[u].size(); j++) {
                int v = ke[u][j];
                if (d[p[v]] == inf) {
                    d[p[v]] = d[u] + 1;
                    Q.push(p[v]);
                }
            }
        }
    }
    return (d[0] != inf);
}

bool dfs(int u) {
    if (u) {
        for(int j = 0; j < ke[u].size(); j++) {
            int v = ke[u][j];
            if (d[p[v]] == d[u] + 1) {
                if (dfs(p[v])) {
                    p[v] = u;
                    p[u] = v;
                    return true;
                }
            }
        }
        d[u] = inf;
        return false;
    }
    return true;
}

void KhuyenIsTheBest() {
    while (bfs())
        for(int i = 1; i <= n; i++)
            if (!p[i] && dfs(i)) res++;
    cout << m - res;
}

int main() {
    ios_base::sync_with_stdio(0);
    //ifstream cin("input.txt");
    cin >> n >> m;
    for(int i = 1; i <= n; i++) {
        int k; cin >> k;
        for(int j = 1; j <= k; j++) {
            int v; cin >> v; v += n;
            ke[i].push_back(v);
            ke[v].push_back(i);
        }
    }
    KhuyenIsTheBest();
    //cout << m - res;
}
