#include <stdio.h>
#include <iostream>
#include <algorithm>
#include <math.h>
#include <vector>
#include <string>
#include <cstring>
#include <map>
#include <set>
#include <queue>
#include <stack>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ld long double
#define pb push_back
#define sz(s) int(s.size())
#define N 251
#define M 250010
#define inf 1000000000

int n,m,d[N][3],x[M],y[M],z[M],i1[M],i2[M];
vector<int> ke[N],w[N];
priority_queue< ii, vector<ii>, greater<ii> > heap;

void dij(int t) {
    while (!heap.empty()) {
        int gt = heap.top().fi, u = heap.top().se;
        heap.pop();
        if (gt == d[u][t]) {
            For(j,0,sz(ke[u])-1) {
                int v = ke[u][j];
                int ts = w[u][j];
                if (d[v][t] > d[u][t] + ts) {
                    d[v][t] = d[u][t] + ts;
                    heap.push(ii(d[v][t],v));
                }
            }
        }
    }
}

void solve() {
    For(i,1,n) For(j,0,1) d[i][j] = inf;
    d[1][0] = 0;
    heap.push(ii(0,1));
    dij(0);
    d[n][1] = 0;
    heap.push(ii(0,n));
    dij(1);
    int res = 0;
    For(i,1,m) {
        int u = x[i], v = y[i], l = z[i];
        if (d[u][0] + l + d[v][1] == d[n][0] || d[u][1] + l + d[v][0] == d[n][0]) {
            For(j,1,n) d[j][2] = inf;
            d[1][2] = 0;
            w[u][i1[i]] *= 2;
            w[v][i2[i]] *= 2;
            heap.push(ii(0,1));
            dij(2);
            w[u][i1[i]] /= 2;
            w[v][i2[i]] /= 2;
            res = max(res,d[n][2] - d[n][0]);
        }
    }
    printf("%d",res);
}

int main() {
    freopen("bai2.inp","r",stdin);
    freopen("bai2.out","w",stdout);
    scanf("%d%d",&n,&m);
    For(i,1,m) {
        int u,v,l;
        scanf("%d%d%d",&u,&v,&l);
        x[i] = u; y[i] = v; z[i] = l;
        ke[u].pb(v); ke[v].pb(u);
        w[u].pb(l); w[v].pb(l);
        i1[i] = sz(ke[u])-1; i2[i] = sz(ke[v])-1;
    }
    solve();
}
