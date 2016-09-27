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
#define N 100010
#define M 1000000007

int n,m,counter,cha[N];
vector<int> ke[N];
bool fr[N],iscycle;
ll res;

void dfs(int u) {
    int v; counter++;
    fr[u] = false;
    For(j,0,sz(ke[u])-1) {
        v = ke[u][j];
        if (fr[v]) {
            cha[v] = u;
            dfs(v);
        } else if (v != cha[u]) iscycle = true;
    }
}

void solve() {
    memset(fr,true,sizeof(fr));
    res = 1;
    For(i,1,n)
      if (fr[i]) {
        iscycle = false;
        counter = 0;
        dfs(i);
        if (iscycle) res = (res*counter) % M;
      }
    cout << res;
}

int main() {
    freopen("NETREF.INP","r",stdin);
    freopen("NETREF.OUT","w",stdout);
    scanf("%d%d",&n,&m);
    For(i,1,m) {
        int u,v;
        scanf("%d%d",&u,&v);
        ke[u].pb(v); ke[v].pb(u);
    }
    solve();
}
