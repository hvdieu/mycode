#include <vector>
#include <string>
#include <cstring>
#include <iostream>
#include <cstdio>
#include <cmath>
#include <algorithm>
#include <queue>
#include <stack>
#include <set>
#include <map>
#include <ctime>
using namespace std;
#define FOR(i,a,b) for(int i=a; i<=b; i++)
#define REP(i,a,b) for(int i=a; i>=b; i--)
#define FORAD(i,u) for(int i=0; i < (int)u.size(),i++)
#define BUG(x) cout << x << endl
#define ll long long
#define fi first
#define se second
#define pb push_back
#define two(i) 1 << i
#define length(x) (int)x.size()
#define e 1e-12
#define bit(s,i) (s >> (i-1)) & 1
#define Nmax 100100
const int base = 1000000007 ;
const double pi = acos(-1);
typedef vector<int> vi ;
typedef pair<int,int> pii ;
int n,m,sl,l[100],d[100] ;
ll f[100][100],g[10][100] ;
void ktao(int ok,int u) {
  sl = 0;
  while (u <=n) {
    l[++sl] = u ;
    if (u<n) d[sl] = 2; else d[sl] = 1 ;
    u+=2 ;
  }
  FOR(i,0,sl) FOR(j,0,m) f[i][j] = 0 ;
  f[0][0] = 1;
  FOR(i,0,sl-1) FOR(j,0,m) if (f[i][j]){
    int vt = l[i+1] - j;
    f[i+1][j] = (f[i+1][j] + f[i][j]) % base;
    f[i+1][j+1] = (f[i+1][j+1] + f[i][j] * vt * d[i+1]) % base ;
    if (d[i+1]>1) (f[i+1][j+2] = f[i+1][j+2] + f[i][j] * vt * (vt-1)) % base ;
  }
  FOR(i,0,m) g[ok][i] = f[sl][i] ;
}
int main()
 {
     freopen("CHESS.INP","r",stdin);
     freopen("CHESS.OUT","w",stdout);
     while (1){
        n = 0 ;
        scanf("%d%d",&n,&m) ;
        if (n==0) break ;
        ktao(0,1) ;
        ktao(1,0) ;
        ll res = 0;
        FOR(i,0,m) {
          //if (g[0][i] * g[1][m-i]<0) cout << g[0][i] << ' ' << g[1][m-i] << endl ;
          res= (res+g[0][i]*g[1][m-i])% base ;
          }
        printf("%ld\n",res) ;
     }
     return 0;
 }
