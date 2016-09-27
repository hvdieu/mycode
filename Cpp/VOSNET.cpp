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
#define N 3010
#define inf 1000000000
#define eps 0.0001

int n,m,d[N][N],q[N],res,kq[N],mm;
vector<int> ke[N];
bool fr[N];

void bfs(int i) {
    int u,v,j,left,right;
    d[i][i]=0; left=0; right = 1;
    memset(fr,true,sizeof(fr));
    q[right] = i;
    while (left<right) {
        u = q[++left];
        For(j, 0, sz(ke[u])-1 ) {
            v = ke[u][j];
            d[i][v] = min(d[i][v],d[i][u]+1);
            if (fr[v]) {
                fr[v]=false;
                q[++right] = v;
            }
        }
    }
}

void solve() {
    For(i,1,n)
      For(j,1,n) d[i][j]=inf;
    For(i,1,n) bfs(i);
    For(i,1,n)
	 For(j,1,i-1) if (d[i][j]!=inf && d[i][j]!=1) {
        res = (int)(log(d[i][j])/log(2));
        double x = res - log(d[i][j])/log(2);
        if (x < 0) x*=-1;
        if (x>eps ) res++;
        kq[res]++; mm = max(mm,res);
    }
    For(i,1,mm) printf("%d ",kq[i]);
    printf("0");
}

int main() {
    freopen("VOSNET.INP","r",stdin);
    freopen("VOSNET.OUT","w",stdout);
    scanf("%d%d",&n,&m);
    For(i,1,m) {
        int u,v;
        scanf("%d%d",&u,&v);
        ke[u].pb(v); ke[v].pb(u);
    }
    solve();
}



