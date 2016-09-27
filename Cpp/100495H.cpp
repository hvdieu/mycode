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
#define N 110
const int h[5] = {0,-1,0,1,0};
const int c[5] = {0,0,1,0,-1};

int ntest,n,m,a[N][N][N],b[N][N][N],f[N][N][N],g[N][N][N],r1,r2;

void solve() {
    For(t,1,100)
     For(i,0,100)
      For(j,0,100) {
         int u,v;
         For(k,0,4) {
            u=i+h[k]; v=j+c[k];
            if (u>=0 && v>=0 && u<=100 && v<=100) {
                f[t][i][j]=max(f[t][i][j],f[t-1][u][v]+a[t][i][j]);
                g[t][i][j]=max(g[t][i][j],g[t-1][u][v]+b[t][i][j]);
            }
         }
         r1=max(r1,f[t][i][j]);
         r2=max(r2,g[t][i][j]);
      }
      printf("%d %d\n",r2,r1);
}

int main() {
    freopen("H.inp","r",stdin);
    freopen("H.out","w",stdout);
    scanf("%d",&ntest);
    int dem=0;
    while (ntest){
        ntest--;
        dem++;
        printf("Case #%d: ",dem);
        scanf("%d",&m);
        r1=0; r2=0;
        For(i,0,100) For(j,0,100) {
            a[0][i][j]=0; b[0][i][j]=0;
            f[0][i][j]=0; g[0][i][j]=0;
        }
        For(t,1,100) For(i,0,100) For(j,0,100) {
            a[t][i][j]=0; b[t][i][j]=0;
            f[t][i][j]=-110; g[t][i][j]=-110;
        }
        For(i,1,m) {
            int t,x,y; char c1,c2;
            scanf("%d %d %d %c1\n",&t,&x,&y,&c1);
            if (c1=='a') {
                a[t][x][y]=1; b[t][x][y]=-110; } else {
                    b[t][x][y]=1; a[t][x][y]=-110; }
        }
        solve();
    }

}


