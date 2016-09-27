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
#define N 2001
#define T 131072
#define inf 1000000000000000LL

int bit(int x, int i) {
    return (x >> i) & 1;
}

int n, m, k, TT;
ll d[18][N], f[18][T];
vector<int> ke[N], w[N];
int dd[N];

priority_queue < lli, vector<lli>, greater<lli> > heap;

void Dij(int i) {
    For(j, 1, n) d[i][j] = inf;
    d[i][dd[i]] = 0;
    heap.push(lli(0,dd[i]));
    while (!heap.empty()) {
        int u = heap.top().se;
        ll gt = heap.top().fi;
        heap.pop();
        if (gt == d[i][u]) {
            For(j, 0, sz(ke[u]) - 1) {
                int v = ke[u][j];
                ll x = d[i][u] + w[u][j];
                if (d[i][v] > x) {
                    d[i][v] = x;
                    heap.push(lli(x,v));
                }
            }
        }
    }
}

void solve() {
    TT = (1 << k) - 1;
    For(i, 1, k) Dij(i);
    For(i, 1, k) For(tt, 0, TT) f[i][tt] = inf;
    f[1][1] = 0;
    For(tt, 1, TT) {
        For(u, 1, k) if (f[u][tt] < inf) {
            For(v, 1, k) if (u != v && !bit(tt,v-1)) {
                int t1 = tt | (1 << (v-1));
                if (f[v][t1] > f[u][tt] + d[u][dd[v]]) f[v][t1] = f[u][tt] + d[u][dd[v]];
            }
        }
    }
    cout << f[k][TT];
}

int main() {
    freopen("graph14.inp","r",stdin);
    freopen("graph14.out","w",stdout);
    scanf("%d %d", &n, &m);
    scanf("%d ",&k);
    dd[1] = 1;
    For(i, 2, k+1) {
        int u; scanf("%d", &u); dd[i] = u;
    }
    dd[k+2] = n; k += 2;
    For(i, 1, m) {
        int u, v, l;
        scanf("%d %d %d",&u, &v, &l);
        ke[u].pb(v); ke[v].pb(u); w[u].pb(l); w[v].pb(l);
    }
    solve();
}
