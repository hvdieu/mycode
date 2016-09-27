#include <bits/stdc++.h>

using namespace std;

const int N = 100000 + 10;

int ntest, n, m;
int m1[N], m2[N];
vector<pair<int, int>> ke[N];

void update(int i, int x) {
    if (x <= m1[i]) m2[i] = m1[i], m1[i] = x;
    else if (x <= m2[i]) m2[i] = x;
}

int main() {
    ios_base::sync_with_stdio(false);
    //ifstream cin("input.txt");
    cin >> ntest;
    while (ntest) {
        ntest--;
        cin >> n >> m;
        for(int i = 1; i <= n; i++) ke[i].clear();
        for(int i = 1; i <= m; i++) {
            int u, v, l;
            cin >> u >> v >> l;
            ke[u].push_back(make_pair(l, v));
            ke[v].push_back(make_pair(l, u));
        }
        int res = 1000000000;
        for(int i = 1; i <= n; i++) sort(ke[i].begin(), ke[i].end());
        for(int u = 1; u <= n; u++) if (ke[u].size() > 1) {
            for(int j = 1; j < ke[u].size(); j++) if (ke[u][j].second != ke[u][0].second)
                res = min(res, ke[u][j].first + ke[u][0].first);
        }
        cout << res << "\n";
    }
}
