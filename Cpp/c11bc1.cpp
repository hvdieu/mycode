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
#define K 52
#define M 790972

int n,k;
int f[N][K][2],g[N][K][2];
ii q[N];
int res,mm;

void solve() {
    sort(q+1,q+n+1);
    int L=1;
    f[1][1][0]=q[1].se; g[1][1][0]=q[1].se;
    For(i,2,n) {
        if (q[i].fi!=q[i-1].fi) L=i;
        ll x,y;
        x = q[i].se;
        f[i][1][0] = x;
        g[i][1][0] = (g[i-1][1][0] + f[i][1][0]) % M;
        For(j,2,k) {
            y = g[i-1][j-1][1]+g[L-1][j-1][0];
            y = (y*x) % M;
            f[i][j][1] = y;
            g[i][j][1] = (g[i-1][j][1] + f[i][j][1]) % M;
            f[i][j][0] = 0;
            if (L!=i) {
                y = g[i-1][j-1][0] - g[L-1][j-1][0];
                if (y<0) y = y+M;
                y = (y*x) % M;
                f[i][j][0] = y;
            }
            g[i][j][0] = (g[i-1][j][0] + f[i][j][0]) % M;
        }
    }
    res = 0;
    For(i,1,n) res = (res + f[i][k][1]) % M;
    printf("%d",res);
}

int main() {
   // freopen("C11BC1.INP","r",stdin);
   // freopen("C11BC1.OUT","w",stdout);
    scanf("%d%d",&n,&k);
    For(i,1,n) scanf("%d%d\n",&q[i].se,&q[i].fi);
    solve();
}



