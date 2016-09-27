#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define REP(i, n) for(int i = 0; i < n; i++)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define getbit(x, i) ((x >> (i-1)) & 1LL)
#define onbit(x, i) (x | (1LL << (i-1)))
#define offbit(x, i) (x & ~(1 << (i-1)))
#define N 10010
#define inf 1000000000

int n, m, p, s, t, d[2][N], res, ntest;
vector<ii> ke[2][N];
priority_queue<ii, vector<ii>, greater<ii> > heap;

void ShortestPath(int k, int s) {
    For(i, 1, n) d[k][i] = inf; d[k][s] = 0;
    while (!heap.empty()) heap.pop();
    heap.push(ii(0, s));
    while (!heap.empty()) {
        int val = heap.top().fi, u = heap.top ().se;
        heap.pop();
        if (val == d[k][u]) {
            FOR(it, ke[k][u]) {
                int v = it->fi, c = it->se;
                if (d[k][v] > d[k][u] + c) {
                    d[k][v] = d[k][u] + c;
                    heap.push(ii(d[k][v], v));
                }
            }
        }
    }
}

void solve() {
    res = -1;
    For(u, 1, n) FOR(it, ke[0][u]) {
        int v = it->fi, c = it->se;
        if (d[0][u] + c + d[1][v] <= p) res = max(res, c);
    }
}

int main() {
    freopen("toll2015.inp","r",stdin);
   // freopen("toll2015.out","w",stdout);
    For(test, 1, 1) {
        scanf("%d%d%d%d%d", &n, &m, &s, &t, &p);
        For(i, 1, n) ke[0][i].clear(), ke[1][i].clear();
        For(i, 1, m) {
            int u, v, c;
            scanf("%d%d%d", &u, &v, &c);
            ke[0][u].pb(ii(v, c));
            ke[1][v].pb(ii(u, c));
        }
        ShortestPath(0, s);
        ShortestPath(1, t);
        solve();
        printf("%d", res);
    }
}


