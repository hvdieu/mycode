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
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f,x) memset(f,x,sizeof(f))
#define N 31
#define BASE 1000000009

int m,n,a[N],k,f[901][N][N],g[11][N][N],ff[901][N][N],gt[901],res,c[N][N];

int val(string s) {
    int res = 0;
    For(i,0,sz(s)-1) res = res * 10 + int(s[i]) - int('0');
    return res;
}

int Pow(int a,int n) {
    int res = 1;
    while (n) {
        if (n & 1) res = (ll(res) * a) % BASE;
        n >>= 1;
        a = (ll(a) * a) % BASE;
    }
    return res;
}

void init() {
    For(i,0,30) c[0][i] = 1;
    For(j,1,30) For(i,1,j) c[i][j] = (c[i][j-1] + c[i-1][j-1]) % BASE;
    f[0][0][0] = 1;
    gt[0] = 1;
    For(k,1,900) {
        gt[k] = (ll(gt[k-1]) * Pow(k,BASE-2)) % BASE;
        For(i,1,30) For(j,1,30) {
            f[k][i][j] = (ll(f[k-1][i-1][j-1]) + ((f[k-1][i-1][j] + f[k-1][i][j-1]) % BASE)) * (i * j) % BASE;
            f[k][i][j] = (f[k][i][j] + (ll(f[k-1][i][j]) * (i * j - k + 1)) % BASE) % BASE;
            ff[k][i][j] = (ll(f[k][i][j]) * gt[k]) % BASE;
            //if (ff[k][i][j] < 0) printf("%d %d %d\n",k,i,j);
        }
    }
}

int main() {
    freopen("colorook.inp","r",stdin);
   // freopen("colorook.out","w",stdout);
    init();
    while (1) {
        string s;
        cin >> s;
        if (s == "[END]") break;
        cin >> m; cin >> n;
        cin >> s;
        k = 0;
        while (1) {
            cin >> s;
            if (s == ">>") break;
            a[++k] = val(s);
        }
       // For(i,1,k) printf("%d ",a[i]); printf("\n");
        reset(g,0);
        For(i,0,m) For(j,0,n) g[0][i][j] = 1;
        For(i,1,k) For(x,1,m) For(y,1,n)
            For(xx,1,x) For(yy,1,y) if (g[i-1][x - xx][y - yy] && ff[a[i]][xx][yy]) {
                int sc = (ll(c[xx][x]) * c[yy][y]) % BASE;
                g[i][x][y] = (ll(g[i][x][y]) + (ll(g[i-1][x - xx][y - yy]) * ((ll(ff[a[i]][xx][yy]) * sc) % BASE)) % BASE) % BASE;
               // if (g[i][x][y] < 0) printf("%d %d %d\n",i,x,y);
            }
        res = 0;
        //For(x,1,m) For(y,1,m) res = (ll(res) + g[k][x][y]) % BASE;
        printf("%d\n",g[k][m][n]);
    }
}
