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
#define N 110
#define M 1000000007

const int h[4] = {-1,0,1,0};
const int c[4] = {0,1,0,-1};

int m,n,xa,ya,xb,yb,xc,yc,res;
int g[N][N],ja[2*N][N],jc[2*N][N],f[2*N][N][N];

void init() {
    g[1][1] = 1;
    For(i,1,max(m,n))
      For(j,1,max(m,n))
       g[i][j] = (g[i][j] + (g[i-1][j] + g[i][j-1]) % M) % M;
    For(i,1,m)
      For(j,1,n) {
          int k;
          if (abs(i-xa) + abs(j-ya) + abs(i-xb) + abs(j-yb) == abs(ya-yb) + abs(xa-xb)) k = abs(i-xb) + abs(j-yb); else k = -1;
          if (k != -1) ja[k][i] = j;
          if (abs(i-xc) + abs(j-yc) + abs(i-xb) + abs(j-yb) == abs(yc-yb) + abs(xc-xb)) k = abs(i-xb) + abs(j-yb); else k = -1;
          if (k != -1) jc[k][i] = j;
      }
}

void up(int i, int j, int u, int v, ll x) {
    if (i == xa && j == ya) res = (res + (x*g[abs(u-xc)+1][abs(v-yc)+1]) % M) % M;
    else res = (res + (x*g[abs(i-xa)+1][abs(j-ya)+1]) % M) % M;
}

void solve() {
    if (xa == xb && xb == xc) {
        swap(m,n); swap(xa,ya); swap(xb,yb); swap(xc,yc);
    }
    if (ya == yb && yb == yc) {
        if ((xa < xb) == (xb < xc)) {
            cout << 1; return;
        }
        int cs = 0;
        if (ya > 1) cs++;
        if (ya < n) cs++;
        cout << cs * abs(xa-xc);
        return;
    }
    init();
    f[0][xb][xb] = 1;
    For(k,0,m+n) For(i,1,m) For(u,1,m) if (f[k][i][u] != 0) {
        int i1,j1,u1,v1;
        int j = ja[k][i], v = jc[k][u];
        if ((i == xa && j == ya) || (u == xc && v == yc)) up(i,j,u,v,f[k][i][u]);
        else
        For(t,0,3) {
            i1 = i + h[t]; j1 = j + c[t];
            if (abs(i1-xa) + abs(j1-ya)+1 == abs(i-xa) + abs(j-ya)) {
                For(t1,0,3) {
                    u1 = u + h[t1]; v1 = v + c[t1];
                    if (abs(u1-xc) + abs(v1-yc)+1 == abs(u-xc) + abs(v-yc)) {
                        if ((i1 != u1) || (j1 != v1)) f[k+1][i1][u1] = (f[k+1][i1][u1] + f[k][i][u]) % M;
                    }
                }
            }
        }
    }
    printf("%d\n",res);
  //  printf("%d ",f[1][2][3]);
}

int main() {
    freopen("sqgame.inp","r",stdin);
    freopen("sqgame.out","w",stdout);
    cin >> m >> n;
    cin >> xa >> ya;
    cin >> xb >> yb;
    cin >> xc >> yc;
    solve();
}
