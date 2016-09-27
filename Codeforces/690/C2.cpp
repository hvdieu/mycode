#include <bits/stdc++.h>

using namespace std;

#define For(i, a, b) for(int i = a; i <= b; i++)
#define FOR(x, f) for(auto x = f.begin(); x != f.end(); x++)

const int N = 1e5 + 10;

int n, root, MAX, m;
vector<int> ke[N];
int d[N];
bool fr[N];

void dfs(int u) {
    fr[u] = false;
    if (d[u] > d[MAX]) MAX = u;
    FOR(v, ke[u])
        if (fr[*v]) {
            d[*v] = d[u] + 1;
            dfs(*v);
        }
}

int main() {
    //ifstream cin("in.txt");
    cin >> n >> m;
    For(i, 1, m) {
        int u, v;
        cin >> u >> v;
        ke[u].push_back(v);
        ke[v].push_back(u);
    }
    memset(d, 0, sizeof d);
    memset(fr, true, sizeof fr);
    dfs(1);
    memset(d, 0, sizeof d);
    memset(fr, true, sizeof fr);
    root = MAX; MAX = 0;
    dfs(root);
    cout << d[MAX] - d[root];
}
