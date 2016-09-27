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
#define N 5010

int m,n,a[N],b[N];
ll f[N][N],g[N][N],res;

void sub1() {
    res = 0;
    For(i,1,m)
      For(j,1,n) if (a[i] == b[j]) {
          For(x,1,i-1)
		    For(y,1,j-1)
           if (a[x] == b[y]) f[i][j] = max(f[i][j],f[x][y] + abs(a[i] - a[x]));
      res = max(res,f[i][j]);
      }
    cout << res;
}

void sub2() {
    res = 0;
    For(i,0,m)
      For(j,0,n) {
          g[i][j] = -1;
          f[i][j] = -1;
      }
    For(i,1,m) {
        ll ma = 0;
        For(j,1,n) {
            if (a[i] == b[j]) f[i][j] = max(f[i][j],ma);
            if (g[i-1][j] != -1) ma = max(ma,g[i-1][j] + abs(a[i] - b[j]));
            g[i][j] = max(g[i-1][j],f[i][j]);
            res = max(res,f[i][j]);
        }
    }
    cout << res;
}

int main() {
    //freopen("voslis.inp","r",stdin);
    //freopen("voslis.out","w",stdout);
    scanf("%d %d",&m,&n);
    For(i,1,m) scanf("%d",&a[i]);
    For(i,1,n) scanf("%d",&b[i]);
    //if (m <= 200 && n <= 200) sub1();
    //else
    sub2();
}



