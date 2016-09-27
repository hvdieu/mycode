#include <bits/stdc++.h>


using namespace std;

const int N = 200000 + 10;

int n, m, p[N], cnt;
vector<int> ke[N];
bool ans[N];
bool was[N];
int root[N];

int get_root(int u) {
    return (root[u] != u) ? root[u] = get_root(root[u]) : u;
}

void solve() {
    for(int i = 1; i <= n; i++) root[i] = i;
    cnt = 0;
    for(int i = n; i >= 0; i--) {
        //cout << cnt << "\n";
        ans[i+1] = (cnt == 1);
        if (!i) break;
        cnt++;
        int u = p[i];
        was[u] = true;
        for(auto v = ke[u].begin(); v != ke[u].end(); v++)
            if (was[*v]) {
                int uu = get_root(u);
                int vv = get_root(*v);
                if (uu != vv) {
                    cnt--;
                    root[uu] = vv;
                }
            }
    }

}

int main() {
    ios_base::sync_with_stdio(false);
    ifstream cin("closing.in");
    ofstream cout("closing.out");
    cin >> n >> m;
    for(int i = 0; i < m; i++) {
        int u, v;
        cin >> u >> v;
        ke[u].push_back(v);
        ke[v].push_back(u);
    }
    for(int i = 1; i <= n; i++) cin >> p[i];
    solve();
    for(int i = 1; i <= n; i++)
        cout << ((ans[i]) ? "YES\n" : "NO\n");
}
