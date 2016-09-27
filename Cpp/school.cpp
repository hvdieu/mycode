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
#define N 10001
#define inf 1000000000

int n, m, k, d[3][N], res;
vector<int> ke[3][N], w[3][N];
priority_queue< ii, vector<ii>, greater<ii> > heap;

void Dij(int t, int start) {
    For(i, 1, n) d[t][i] = inf;
    d[t][start] = 0; heap.push(ii(0, start));
    while (!heap.empty()) {
        int u = heap.top().se, gt = heap.top().fi;
        heap.pop();
        For(j, 0, sz(ke[t][u])-1) {
            int v = ke[t][u][j], x = d[t][u] + w[t][u][j];
            if (d[t][v] > x) {
                d[t][v] = x;
                heap.push(ii(x, v));
            }
        }
    }
}

void solve() {
    Dij(0, 1);
    Dij(1, n);
    Dij(2, k);
    res = inf;
    For(i, 1, n) if (d[0][i] + d[2][i] < 60) res = min(res, d[0][i] + d[1][i]);
    cout << res;
}

int main() {
    freopen("school.inp","r",stdin);
    freopen("school.out","w",stdout);
    scanf("%d%d%d", &n, &m, &k);
    For(i, 1, m) {
        int u, v, l1, l0;
        scanf("%d %d %d %d", &u, &v, &l1, &l0);
        ke[0][u].pb(v); w[0][u].pb(l0);
        ke[1][v].pb(u); w[1][v].pb(l0);
        ke[2][v].pb(u); w[2][v].pb(l1);
    }
    solve();
}
