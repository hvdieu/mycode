#include <algorithm>
#include <vector>
#include <stdio.h>
#include <iostream>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 1010
#define inf 1000000000

int n, ntest, a[N], mincost, flow;
vector<int> ke[N];
int f[N][N], c[N][N], cost[N][N];
int timer, dd[N], d[N];
int lef, righ, q[N], trace[N];
bool fr[N];

void connect(int i, int j, int _c, int _cost) {
    f[i][j] = f[j][i] = 0;
    c[i][j] = _c; c[j][i] = 0;
    cost[i][j] = _cost; cost[j][i] = -_cost;
    ke[i].pb(j); ke[j].pb(i);
}

int dis(int i, int j) {
    if (i > j) swap(i, j);
    return min(j-i, n-j+i);
}

void build_graph() {
    For(i, 1, n) {
        if (a[i]) connect(0, i, a[i], 0);
        connect(i, n+1, 1, 0);
    }
    For(i, 1, n) if (a[i] > 1)
    For(j, 1, n) if (!a[j]) connect(i, j, 1, dis(i, j));
}

bool FindPath(int s, int t) {
    For(i, 0, n+1) d[i] = inf, fr[i] = true;
    d[0] = 0; fr[0] = false;
    lef = -1; righ = 0; q[0] = s;
    while (lef != righ) {
        lef = (lef + 1) % (n + 2);
        int u = q[lef]; fr[u] = true;
        FOR(v, ke[u]) if (f[u][*v] < c[u][*v]) {
            if (d[*v] > d[u] + cost[u][*v]) {
                trace[*v] = u;
                d[*v] = d[u] + cost[u][*v];
                if (fr[*v]) {
                    fr[*v] = false;
                    righ = (righ + 1) % (n + 2); q[righ] = *v;
                }
            }
        }
    }
    return d[t] < inf;
}

void IncFlow(int s, int t) {
    int v = t, temp = inf;
    while (v != s) {
        int u = trace[v];
        temp = min(temp, c[u][v] - f[u][v]);
   //     cout << v << ' ';
        v = u;
    }
   // cout << endl;
    v = t; flow += temp;
    while (v != s) {
        int u = trace[v];
        mincost += temp * (c[u][v] - f[u][v]) * cost[u][v];
        f[u][v] += temp; f[v][u] -= temp;
        v = u;
    }
}

void solve() {
    build_graph();
    flow = mincost = 0;
    while (FindPath(0, n+1)) IncFlow(0, n+1);
    cout << mincost << endl;
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("boxes.out","w",stdout);
    scanf("%d", &ntest);
   // ntest = 1;
    For(test, 1, ntest) {
    	scanf("%d", &n);
    	For(i, 1, n) {
    	    scanf("%d", a+i);
    	    ke[i].clear();
    	}
    	solve();
    }
}
