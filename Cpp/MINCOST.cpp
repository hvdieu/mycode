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

int n, m, k, s, t, res, d[N], t1[N], t2[N], cost[N][N], f[N][N], c[N][N];
int q[N], lef, righ;
vector<int> ke[N];
bool fr[N], b[N][N];

int dd(int x) {
	if (x >= 0) return 1;
	return -1;
}

bool FindPath(int s, int t) {
    reset(fr, true);
    For(i, 1, n) d[i] = inf; d[s] = 0;
    lef = -1; righ = 0; fr[s] = false; q[righ] = s;
    while (lef != righ) {
    	lef = (lef + 1) % n;
        int u = q[lef]; fr[u] = true;
        For(j, 0, sz(ke[u])-1)  {
            int v = ke[u][j];
            if (f[u][v] < c[u][v]) {
                int cp;
                if (f[u][v] >= 0) cp = cost[u][v];
                else cp = -cost[u][v];
                if (d[v] > d[u] + cp) {
                    d[v] = d[u] + cp;
                    t1[v] = u;
                   if (fr[v]) {
                        fr[v] = false;
						righ = (righ + 1) % n; q[righ] = v;
                    }
                }
            }
        }
    }
    return d[t] < inf;
}

void IncFlow(int s, int t) {
    int v = t, temp = inf;
    while (v != s) {
        int u = t1[v];
        if (f[u][v] >= 0) temp = min(temp, c[u][v] - f[u][v]);
        else temp = min(temp, - f[u][v]);
        v = u;
    }
    temp = min(temp, k);
    k -= temp;
    v = t;
    while (v != s) {
        int u = t1[v];
        f[u][v] += temp; f[v][u] -= temp;
        v = u;
    }
    //res += temp * d[t];
}

int main() {
    freopen("mincost.inp","r",stdin);
  //  freopen("mincost.out","w",stdout);
    scanf("%d %d %d %d %d", &n, &m, &k, &s, &t);
    For(i, 1, m) {
        int u, v, l, d;
        scanf("%d %d %d %d", &u, &v, &d, &l);
        c[u][v] = l; cost[u][v] = d;
        c[v][u] = l; cost[v][u] = d;
        if (!b[u][v]) {
            ke[u].pb(v); ke[v].pb(u);
            b[u][v] = b[v][u] = true;
        }
    }
    while (k && FindPath(s, t))
	IncFlow(s, t);
    if (k) cout << -1;
    else {
        For(u, 1, n) For(v, 1, n) if (f[u][v] > 0) res += cost[u][v] * f[u][v];
        printf("%d\n", res);
        For(u, 1, n) For(v, 1, n) if (f[u][v] > 0) printf("%d %d %d\n", u, v, f[u][v]);
        printf("0 0 0");
    }
}


