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
#define N 60
#define inf 100000

int m,n,a[N][N],s[N][N],fxmax[N][N],fymax[N][N],gxmax[N][N],gymax[N][N],mm;
int fxmin[N][N],fymin[N][N],gxmin[N][N],gymin[N][N];

void init() {
    For(i,0,m+1)
     For(j,0,n+1) if (i==0 || j == 0 || i > m || j > n) {
        fxmin[i][j] = inf; fymin[i][j] = inf; gxmin[i][j] = inf; gymin[i][j] = inf;
    }
    For(i,1,m)
      For(j,1,n) {
        fxmin[i][j] = min(fxmin[i-1][j],fxmin[i][j-1]);
        fymin[i][j] = min(fymin[i-1][j],fymin[i][j-1]);
        fxmax[i][j] = max(fxmax[i-1][j],fxmax[i][j-1]);
        fymax[i][j] = max(fymax[i-1][j],fymax[i][j-1]);
        if (a[i][j] == 2) {
            fxmin[i][j] = min(fxmin[i][j],i);
            fxmax[i][j] = max(fxmax[i][j],i);
            fymin[i][j] = min(fymin[i][j],j);
            fymax[i][j] = max(fymax[i][j],j);
        }
      }
    Rep(i,m,1)
      Rep(j,n,1) {
        gxmin[i][j] = min(gxmin[i+1][j],gxmin[i][j+1]);
        gxmax[i][j] = max(gxmax[i+1][j],gxmax[i][j+1]);
        gymin[i][j] = min(gymin[i+1][j],gymin[i][j+1]);
        gymax[i][j] = max(gymax[i+1][j],gymax[i][j+1]);
        if (a[i][j] == 2) {
            gxmin[i][j] = min(gxmin[i][j],i);
            gxmax[i][j] = max(gxmax[i][j],i);
            gymin[i][j] = min(gymin[i][j],j);
            gymax[i][j] = max(gymax[i][j],j);
        }
      }
}

int get(int i,int j,int u,int v) {
    return s[u][v] - s[u][j-1] - s[i-1][v] + s[i-1][j-1];
}

int giao(int i, int j, int u, int v, int x1, int y1, int x2, int y2) {
    int u1 = max(i,x1), v1 = max(j,y1), u2 = min(u,x2), v2 = min(v,y2);
    if (u1 <= u2 && v1 <= v2) return (u2-u1+1)*(v2-v1+1);
    return 0;
}

void solve() {
    if (mm == m+1) {
        cout << 0; return;
    }
    int res = inf;
    For(i,mm,mm)
     For(j,1,n)
       For(u,1,m)
        For(v,1,n) if (!get(i,j,u,v)) {
            int x1,x2,y1,y2;
            x1 = min(min(fxmin[i-1][n],fxmin[m][j-1]),min(gxmin[1][v+1],gxmin[u+1][1]));
            y1 = min(min(fymin[i-1][n],fymin[m][j-1]),min(gymin[1][v+1],gymin[u+1][1]));
            x2 = max(max(fxmax[i-1][n],fxmax[m][j-1]),max(gxmax[1][v+1],gxmax[u+1][1]));
            y2 = max(max(fymax[i-1][n],fymax[m][j-1]),max(gymax[1][v+1],gymax[u+1][1]));
          //  printf("%d %d %d %d\n",x1,y1,x2,y2);
            int tt;
            if (x1 <= x2 && y1 <= y2) {
                if (!get(x1,y1,x2,y2)) tt = (u-i+1)*(v-j+1) + (x2-x1+1)*(y2-y1+1) - giao(i,j,u,v,x1,y1,x2,y2);
                    else tt = inf;
            } else tt = (u-i+1)*(v-j+1);
            res = min(res,tt);
        }
    cout << res;
}

int main() {
    freopen("reccover.inp","r",stdin);
    freopen("reccover.out","w",stdout);
    scanf("%d%d",&m,&n);
    mm = m+1;
    For(i,1,m)
      For(j,1,n) {
        scanf("%d",&a[i][j]);
        int x;
        if (a[i][j] == 1) x = 1; else x = 0;
        s[i][j] = s[i-1][j] + s[i][j-1] - s[i-1][j-1] + x;
        if (a[i][j] == 2) mm = min(mm,i);
      }
    init();
    solve();
}
