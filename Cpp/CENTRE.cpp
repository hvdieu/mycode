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
#define ld long double
#define pb push_back
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 30001
#define inf 1000000000

int n, m, d[2][N];
ull f[2][N];
vector<int> ke[N], w[N], res;
priority_queue< ii, vector<ii>, greater<ii> > heap;

void Dij(int t, int start) {
    For(i, 1, n) d[t][i] = inf;
    d[t][start] = 0; f[t][start] = 1;
    heap.push(ii(0, start));
    while (!heap.empty()) {
        int gt = heap.top().fi, u = heap.top().se;
        heap.pop();
        if (gt == d[t][u]) {
            For(j, 0, sz(ke[u])-1) {
                int v = ke[u][j];
                if (d[t][v] > d[t][u] + w[u][j]) {
                    d[t][v] = d[t][u] + w[u][j];
                    f[t][v] = f[t][u];
                    heap.push(ii(d[t][v], v));
                } else if (d[t][v] == d[t][u] + w[u][j]) f[t][v] += f[t][u];
            }
        }
    }
}

void solve() {
    Dij(0, 1);
    Dij(1, n);
    For(u, 2, n-1)
	 if (d[0][u] + d[1][u] == d[0][n] && f[0][u] * f[1][u] == f[0][n]) continue;
     else res.pb(u);
    printf("%d\n", sz(res));
    For(j, 0, sz(res)-1) printf("%d\n", res[j]);
}

int main() {
    freopen("centre.in","r",stdin);
    freopen("centre.out","w",stdout);
    scanf("%d %d", &n, &m);
    For(i, 1, m) {
        int u, v, l;
        scanf("%d %d %d", &u, &v, &l);
        ke[u].pb(v); w[u].pb(l);
        ke[v].pb(u); w[v].pb(l);
    }
    solve();
}
