#include <bits/stdc++.h>

using namespace std;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f,x) memset(f,x,sizeof(f))
#define all(x) x.begin(), x.end()

const int N = 400 + 10;

int nTest, n;
long long a[N][N];
vector<int> ke[2*N], f[2*N], c[2*N], op[2*N];
queue<int> q;
int t1[2*N], t2[2*N], flow;
bool fr[2*N];

void connect(int u, int v, int l) {
    ke[u].pb(v); ke[v].pb(u); f[u].pb(0); f[v].pb(0);
    c[u].pb(l); c[v].pb(0); op[u].pb(sz(ke[v])-1); op[v].pb(sz(ke[u])-1);
}

bool findPath(int s, int t) {
    reset(fr, true);
    q.push(s); fr[s] = false;
    while (!q.empty()) {
        int u = q.front(); q.pop();
        For(j, 0, sz(ke[u])-1) { int v = ke[u][j];
        if (f[u][j] < c[u][j] && fr[v]) {
            fr[v] = false; t1[v] = u; t2[v] = j;
            q.push(v);
        }
        }
    }
    return !fr[t];
}

void incFlow(int s, int t) {
    int v = t;
    int temp = 4*n;
    while (v != s) {
        int u = t1[v], j = t2[v];
        temp = min(temp, c[u][j] - f[u][j]);
        v = u;
    }
    flow += temp;
    v = t;
    while (v != s) {
        int u = t1[v], j = t2[v];
        f[u][j] += temp; f[v][op[u][j]] -= temp;
        v = u;
    }
}

bool check(long long val) {
    for(int i = 0; i <= 4*n + 1; i++) ke[i].clear(), f[i].clear(), c[i].clear(), op[i].clear();
    for(int i = 1; i < 2*n; i++)
        for(int j = i+1; j <= 2*n; j++)
            if (a[i][j] >= val) connect(i, 2*n + j, 1);
    int s = 0, t = 4*n + 1;
    for(int i = 1; i <= 2*n; i++) {
        connect(s, i, 1);
        connect(2*n + i, t, 1);
    }
    flow = 0;
    while (findPath(s, t)) incFlow(s, t);
    return flow >= n;
}

int main() {
    ios_base::sync_with_stdio(false);
    cin >> nTest;
    for(int iTest = 1; iTest <= nTest; iTest++) {
        cin >> n;
        memset(a, 0, sizeof(a));
        long long l = 0, r = 0, mid, ans;
        for(int i = 1; i < 2*n; i++)
            for(int j = i+1; j <= 2*n; j++)
                cin >> a[i][j], r = max(r, a[i][j]);
        while (l <= r) {
            mid = (l + r) / 2;
            if (check(mid)) {
                ans = mid;
                l = mid + 1;
            } else r = mid - 1;
        }
        cout << ans << endl;
    }
}
