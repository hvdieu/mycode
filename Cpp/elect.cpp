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
#define N 16010
 
int n,m,timer,low[N],num[N],top,st[N],lab[N],cnt,mark[N],L[N],root[N];
vector<int> ke[N],ke2[N];
bool fr[N];
 
int re(int u) {
    if (u % 2) return u+1;
    return u-1;
}
 
void BuildNewGraph() {
    For(u,1,2*n) {
        int v;
        For(j,0,sz(ke[u])-1) {
            v = ke[u][j];
            if (lab[u] != lab[v]) ke2[lab[u]].pb(lab[v]);
        }
    }
}
 
void visit(int u) {
    int v;
    fr[u] = false;
    For(j,0,sz(ke2[u])-1) {
        v = ke2[u][j];
        if (fr[v]) visit(v);
    }
    L[++timer] = u;
}
 
void TopoSort() {
    timer = 0;
    memset(fr,true,sizeof(fr));
    For(i,1,cnt)
      if (fr[i]) visit(i);
}
 
void dfs(int u) {
    int v;
    num[u] = ++timer; low[u] = num[u];
    st[++top] = u;
    For(j,0,sz(ke[u])-1) {
        v = ke[u][j];
        if (fr[v]) {
            if (!num[v]) {
                dfs(v);
                low[u] = min(low[u],low[v]);
            } else low[u] = min(low[u],num[v]);
        }
    }
    if (low[u] == num[u]) {
        cnt++; root[cnt] = u;
        do {
            v = st[top--];
            fr[v] = false;
            lab[v] = cnt;
        } while (u != v);
    }
}
 
void solve() {
    memset(fr,true,sizeof(fr));
    For(i,1,2*n)
      if (!num[i]) {
        top = 0;
        dfs(i);
      }
    for(int u = 1; u <= 2*n; u += 2)
      if (lab[u] == lab[re(u)]) {
          cout << 0;
          return;
      }
    BuildNewGraph();
    TopoSort();
    For(u,1,cnt) {
        int ok = 0;
        if (mark[u] == 0) {
        For(j,0,sz(ke2[u])-1) {
            int v = ke2[u][j];
            if (mark[v] == 1) ok = 1;
            else if (mark[v] == -1) ok = -1;
        }
        if (ok == 0) {
            mark[u] = 1;
            mark[lab[re(root[u])]] = -1;
        } else {
            mark[u] = ok;
            if (mark[u] == 1) {
                mark[lab[re(root[u])]] = -1;
            }
        }
    	}
    }
    printf("1\n");
    for(int u = 1; u <= 2*n; u+=2)
        if (mark[lab[u]] == 1) printf("%d ",u);
        else printf("%d ",re(u));
}
 
int main() {
    //freopen("ELECT.INP","r",stdin);
   // freopen("ELECT.OUT","w",stdout);
    scanf("%d%d",&n,&m);
    For(i,1,m) {
        int u,v;
        scanf("%d%d",&u,&v);
        ke[u].pb(re(v));
        ke[v].pb(re(u));
    }
    solve();
}