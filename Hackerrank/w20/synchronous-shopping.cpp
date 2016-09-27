#include <bits/stdc++.h>

using namespace std;

typedef pair<int, int> ii;

#define bit(x, i) ((x >> (i-1)) & 1)
#define onbit(x, i) (x | (1 << (i-1)))
#define FOR(v, f) for(auto v = f.begin(); v != f.end(); v++)
const int N = 1000 + 10;

struct node {
    int val, u, tt;
    node(int _val, int _u, int _tt) {
        val = _val; u = _u; tt = _tt;
    }
    bool operator > (const node &other) const {
        return val > other.val;
    }
};

int n, m, k, fish[N];
int f[N][1 << 10];
vector<ii> ke[N];
priority_queue<node, vector<node>, greater<node> > heap;

void solve() {
    memset(f, 0x7f, sizeof f);
    int MAX = f[1][fish[1]];
    f[1][fish[1]] = 0;
    heap.push(node(0, 1, fish[1]));
    while (!heap.empty()) {
        int val = heap.top().val, u = heap.top().u, tt = heap.top().tt;
        heap.pop();
        FOR(it, ke[u]) {
            int v = it->first, l = it->second;
            int newtt = tt | fish[v];
            if (f[v][newtt] > f[u][tt] + l) {
                f[v][newtt] = f[u][tt] + l;
                heap.push(node(f[v][newtt], v, newtt));
            }
        }
    }
    int ans = 1e9;
    for(int tt1 = 0; tt1 < (1 << k); tt1++)
        for(int tt2 = 0; tt2 < (1 << k); tt2++)
        if ((tt1 | tt2) == ((1 << k)-1) && f[n][tt1] < MAX && f[n][tt2] < MAX && max(f[n][tt1], f[n][tt2]) < ans) {
            ans = max(f[n][tt1], f[n][tt2]);
        }
    cout << ans;
}

int main() {
    cin >> n >> m >> k;
    for(int i = 1; i <= n; i++) {
        int c, x;
        cin >> c;
        while (c--) {
            cin >> x;
            fish[i] = onbit(fish[i], x);
        }
    }
    for(int i = 1; i <= m; i++) {
        int u, v, l;
        cin >> u >> v >> l;
        ke[u].push_back(ii(v, l));
        ke[v].push_back(ii(u, l));
    }
    solve();
}
