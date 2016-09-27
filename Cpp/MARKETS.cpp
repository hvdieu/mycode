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
#define inf 100000000
const int M = (1 << 20);
const int MQ = 10000;

int n,m,s,f,c[11][11],w[11][M],lef,righ;
bool fr[11][102];
int qx[MQ],qy[MQ],qz[MQ];
int d[11][102];


void init() {
    For(tt,1,(1 << m)-1) {
        For(j,1,m) if (tt & (1 << (j-1)))
        For(i,1,n) w[i][tt] += c[i][j];
    }
}

void push(int u,int v) {
    if (fr[u][v]) {
        fr[u][v] = false;
        qx[++righ] = u; qy[righ] = v;
    }
}

void pop(int &u,int &v) {
    lef++; u = qx[lef]; v = qy[lef];
}

void solve() {
    if (s >= f) {
        cout << 0;
        return;
    }
    memset(fr,true,sizeof(fr));
    For(i,1,n) For(j,0,f) d[i][j] = inf;
    For(i,1,n) d[i][s] = 0;
    For(i,1,n) push(i,s);
    while (lef < righ) {
        int u,S;
        pop(u,S);
        For(tt,1,(1 << m)-1)
          if (S >= w[u][tt])
          For(v,1,n) if (u != v)if ((tt == 0) || (w[v][tt] >= w[u][tt])){
              int X = S - w[u][tt] + w[v][tt];
              if (X > f) X = f;
              int ts; if (tt > 0) ts = 1; else ts = 0;
              if (d[v][X] > d[u][S] + ts) {
                d[v][X] = d[u][S] + ts;
                if (fr[v][X]) qx[righ+1] = d[u][S]+ts;
                push(v,X);
                For(j,1,n) {
                    if (d[j][X] > d[v][X]) {
                        d[j][X] = d[v][X];
                        push(j,X);
                    }
                }
              }
          }
    }
    int res = inf;
    For(i,1,n) if (!fr[i][f]) res = min(res,d[i][f]);
    if (res == inf) printf("-1"); else printf("%d",res);
}

int main() {
    freopen("markets.inp","r",stdin);
    freopen("markets.out","w",stdout);
    scanf("%d%d%d%d",&n,&m,&s,&f);
    For(i,1,n) For(j,1,m) scanf("%d",&c[i][j]);
    init();
    solve();
}
