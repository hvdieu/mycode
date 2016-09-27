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
#define BASE 1000000021
#define N 556
#define inf 1000000000

int n, d[N][N], f[N][N], m;
vector<int> ke[N], w[N];
priority_queue< ii, vector<ii>, greater<ii> > heap;

void Dij(int i) {
    For(j, 1, n) d[i][j] = inf;
    d[i][i] = 0; f[i][i] = 1;
    heap.push(ii(0,i));
    while (!heap.empty()) {
        int u = heap.top().se, gt = heap.top().fi;
        heap.pop();
        if (gt == d[i][u]) {
            For(j, 0, sz(ke[u]) - 1) {
                int v = ke[u][j];
                int x = d[i][u] + w[u][j];
                if (d[i][v] > x) {
                    d[i][v] = x;
                    f[i][v] = f[i][u];
                    heap.push(ii(x,v));
                } else if (d[i][v] == x) f[i][v] = (f[i][v] + f[i][u]) % BASE;
            }
        }
    }
}

void solve() {
    For(i, 1, n) Dij(i);
    int q;
    scanf("%d",&q);
    while (q) {
    	q--;
        int u, v;
        scanf("%d %d", &u, &v);
        printf("%d ",f[u][v]);
    }
}

int main() {
    freopen("pathsb.inp","r",stdin);
    freopen("pathsb.out","w",stdout);
    scanf("%d %d", &n, &m);
    For(i, 1, m) {
        int u, v, l;
        scanf("%d %d %d",&u,&v,&l);
        ke[u].pb(v); ke[v].pb(u);
        w[u].pb(l); w[v].pb(l);
    }
    solve();
}
