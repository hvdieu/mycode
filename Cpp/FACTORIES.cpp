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

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ll long long
#define ld long double
#define pb push_back
#define sz(s) int(s.size())
#define inf 1000000000000000LL
#define N 500010

int n,q,vmax,cha[N],f[N][20],tin[N],tout[N],timer,a[N];
vector<int> ke[N],w[N];
ll d[N],res;
bool fr[N];
priority_queue<lli, vector<lli>, greater<lli> > heap;

void sub1() {
    while (q) {
        q--;
        int s,t;
        scanf("%d%d",&s,&t);
        For(i,0,n-1) d[i] = inf;
        For(i,1,s) {
            int u;
            scanf("%d",&u);
            d[u] = 0;
			heap.push(lli(0,u));
        }
        ll du; int u;
        while (!heap.empty()) {
            du = heap.top().fi;
            u = heap.top().se;
            heap.pop();
            if (du==d[u]) {
            For(j,0,sz(ke[u])-1) {
                int v = ke[u][j];
                if (d[v] > d[u] + w[u][j]) {
                    d[v] = d[u] + w[u][j];
                    heap.push(lli(d[v],v));
                }
            }
            }
        }
        res = inf;
        For(i,1,t) {
            int u;
            scanf("%d",&u);
            res = min(res,d[u]);
        }
        printf("%lld\n",res);
    }
}

void dfs(int u) {
    fr[u] = false;
    tin[u] = ++timer;
    For(j,0,vmax) f[u][j] = f[f[u][j-1]][j-1];
    int v;
    For(j,0,sz(ke[u])-1) {
        v = ke[u][j];
        if (fr[v]) {
            cha[v] = u; f[v][0] = u;
            d[v] = d[u] + w[u][j];
            dfs(v);
        }
    }
    tout[u] = ++timer;
}

int check(int u,int v) {
    return (tin[u] <= tin[v] && tout[u] >= tout[v]);
}

int lca(int u,int v) {
    if (check(u,v)) return u;
    if (check(v,u)) return v;
    For(j,vmax,0)
      if (check(f[u][j],v) == false) u = f[u][j];
    return cha[u];
}

ll dis(int u,int v) {
    int p = lca(u,v);
    return d[u] + d[v] - d[p]*2;
}

void solve() {
    vmax = int(log(n)/log(2))+1;
    cha[0] = 0;
    f[0][0] = 0;
    memset(fr,true,sizeof(fr));
    dfs(0);
    while (q) {
        q--;
        int s,t;
        scanf("%d%d",&s,&t);
        res = inf;
        For(i,1,s) scanf("%d",&a[i]);
        For(i,1,t) {
            int u;
            scanf("%d",&u);
            For(j,1,s) res = min(res,dis(a[j],u));
        }
        printf("%lld\n",res);
    }
    //For(i,0,n-1) printf("%lld ",d[i]);
}

int main() {
   // freopen("FACTORIES.INP","r",stdin);
   // freopen("FACTORIES.OUT","w",stdout);
    scanf("%d%d",&n,&q);
    For(i,1,n-1) {
        int u,v,l;
        scanf("%d%d%d",&u,&v,&l);
        ke[u].pb(v); ke[v].pb(u);
        w[u].pb(l); w[v].pb(l);
    }
    solve();
}



