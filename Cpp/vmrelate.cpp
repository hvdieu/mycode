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
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ll long long
#define ld long double
#define pb push_back
#define sz(s) int(s.size())
#define N 100010

int n,m,ntest,d[N],res,cha[N];
vector<int> ke[N];
bool indfs[N];

void dfs(int u) {
    indfs[u] = true;
    For(j,0,sz(ke[u])-1) {
        int v = ke[u][j];
        if (!cha[v]) {
            cha[v] = u; d[v] = d[u] + 1;
            dfs(v);
        } else if (v != cha[u] && indfs[v]) {
            int x = d[u] - d[v];
            if (x % 2 == 0) res = 0;
        }
    }
    indfs[u] = false;
}

int main() {
    freopen("vmrelate.inp","r",stdin);
    //freopen("","w",stdout);
    scanf("%d",&ntest);
    while (ntest) {
        ntest--;
        scanf("%d%d",&n,&m);
        For(i,1,n) ke[i].clear();
        For(i,1,m) {
            int u,v;
            scanf("%d%d",&u,&v);
            ke[u].pb(v); ke[v].pb(u);
        }
        For(i,1,n) {
            cha[i] = 0; d[i] = 0;
        }
        res = 1;
        For(i,1,n) if (!cha[i]) {
            cha[i] = i; dfs(i);
        }
        printf("%d\n",res);
    }
}
