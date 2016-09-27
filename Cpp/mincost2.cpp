#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f,x) memset(f,x,sizeof(f))
#define all(x) x.begin(), x.end()
#define N 110
#define inf 1000000000

int n, m, k, s, t, res, d[N], t1[N], t2[N];
vector<int> ke[N], f[N], c[N], cost[N], op[N];
queue<int> q;
bool fr[N];

void connect(int u, int v, int l, int d) {
    ke[u].pb(v); f[u].pb(0); c[u].pb(l); cost[u].pb(d);
    ke[v].pb(u); f[v].pb(0); c[v].pb(0); cost[v].pb(d);
    op[u].pb(sz(ke[v])-1); op[v].pb(sz(ke[u])-1);
}

bool dd(int x) {
	if (x >= 0) return 1;
	return -1;
}

bool FindPath(int s, int t) {
    reset(fr, true);
    For(i, 1, n) d[i] = inf; d[s] = 0;
    q.push(s);
    while (!q.empty()) {
        int u = q.front(); q.pop();
        For(j, 0, sz(ke[u])-1) {
            int v = ke[u][j];
            if (f[u][j] < c[u][j] && d[v] > d[u] + cost[u][j] * dd(f[u][j])) {
                d[v] = d[u] + cost[u][j] * dd(f[u][j]);
                t1[v] = u; t2[v] = j;
                if (fr[v]) {
                    fr[v] = false; q.push(v);
                }
            }
        }
    }
    return d[t] < inf;
}

void IncFlow(int s, int t) {
    int v = t, temp = inf;
    while (v != s) {
        int u = t1[v], j = t2[v];
        temp = min(temp, c[u][j] - f[u][j]);
        v = u;
    }
    temp = min(temp, k);
    k -= temp;
    v = t;
    while (v != s) {
        int u = t1[v], j = t2[v];
        f[u][j] += temp; f[v][op[u][j]] -= temp;
        v = u;
    }
}

int main() {
    freopen("mincost.inp","r",stdin);
  //  freopen("mincost.out","w",stdout);
    scanf("%d %d %d %d %d", &n, &m, &k, &s, &t);
    For(i, 1, m) {
        int u, v, l, d;
        scanf("%d %d %d %d", &u, &v, &d, &l);
        connect(u, v, l, d);
        connect(v, u, l, d);
    }
    while (k && FindPath(s, t))
	IncFlow(s, t);
    if (k) cout << -1;
    else {
        For(u, 1, n) For(j, 0, sz(ke[u])-1) if (f[u][j] > 0) res += f[u][j] * cost[u][j];
        printf("%d\n", res);
        //For(u, 1, n) For(j, 0, sz(ke[u])-1) if (f[u][j] > 0) printf("%d %d %d\n", u, ke[u][j], f[u][j]);
        printf("0 0 0");
    }
}
