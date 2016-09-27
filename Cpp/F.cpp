#include <bits/stdc++.h>
#define FOR(i, a, b) for(int i = (a); i < (b); ++i)
#define REP(i, a, b) for(int i = (a); i <=(b); ++i)
#define REPD(i, a, b) for(int i = (a); i >= (b); --i)
#define TR(i, a) for(__typeof(a.begin()) i = a.begin(); i != a.end(); ++i)
#define SZ(a) (int(a.size()))
#define ALL(a) a.begin(), a.end()
#define long long long
#define II pair<int, int>
#define X first
#define Y second
#define MP make_pair
#define PB push_back
#define RESET(a, v) memset(a, v, sizeof(a))
#define endl '\n'

const int N = 38;

using namespace std;

int n, m, best;
int d[N][N], gain[N];
bool was[N];
bool ok;
vector<int> a[N];

void bfs(int source, int d[N]) {
    queue<int> Q;
    Q.push(source);
    REP(i, 1, n) was[i] = d[i] = 0;
    was[source] = 1;
    while (!Q.empty()) {
        int u = Q.front(); Q.pop();
        TR(v, a[u]) if (!was[*v]) {
            was[*v] = 1;
            d[*v] = d[u] + 1;
            Q.push(*v);
        }
    }
}

void dfs(int u, long mask) {
    if (ok) return;
    was[u] = 1;
    if (u == 1) {
        ok = 1; return;
    }
    TR(v, a[u])
    if (!(mask & (1LL << *v - 1)) && !was[*v])
        dfs(*v, mask);
}

int getSum(int mask, int k) {
    vector<int> M;
    FOR(i, 0, n)
    if (!(mask & (1LL << i)))
        M.PB(gain[i + 1]);
    sort(ALL(M), greater<int>());
    int ret = 0;
    FOR(i, 0, min(SZ(M), k))
        ret += M[i];
    return ret;
}

void findPath(int u, int dist, int money, long maskVisit, long maskGet) {
    //cout << u << ' ' << dist << ' ' << money << endl;
    ok = 0; RESET(was, 0);
    dfs(2, maskGet); if (!ok) return;
    if (money + getSum(maskVisit, d[1][2] - dist) <= best) return;
    //cout << u << ' ' << dist << ' ' << money << endl;
    if (u == 2) {
        best = max(best, money);
        return;
    }
    TR(it, a[u]) {
        int v = *it;
        if (maskVisit & (1LL << v - 1)) continue;
        if (dist + 1 + d[v][2] == d[1][2]) {
            findPath(v, dist + 1, money + gain[v], maskVisit | (1LL << v - 1), maskGet | (1LL << v - 1));
            findPath(v, dist + 1, money, maskVisit | (1LL << v - 1), maskGet);
        }
    }
}

int main() {
    ios :: sync_with_stdio(0); cin.tie(0);
    //freopen("F.in", "r", stdin);
    while (cin >> n >> m) {
        if (n == 0) break;
        REP(i, 1, n) a[i].clear();
        REP(i, 3, n) cin >> gain[i];
        int u, v;
        FOR(i, 0, m) {
            cin >> u >> v;
            a[u].PB(v); a[v].PB(u);
        }
        REP(i, 1, n) bfs(i, d[i]);
        REP(i, 1, n) was[i] = 0;
        best = 0;
        findPath(1, 0, 0, 0, 0);
        cout << best << endl;
    }
    return 0;
}
