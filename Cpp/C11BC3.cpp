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
#define N 101

int m,n,k,a[N][N],b[N][N],sum[N][N][2],SUM,kq[N][N];

int get(int i,int j,int u,int v,int t) {
    return sum[u][v][t] - sum[i-1][v][t] - sum[u][j-1][t] + sum[i-1][j-1][t];
}

inline void init() {
    For(i,1,m)
     For(j,1,n) {
        sum[i][j][0] = sum[i-1][j][0] + sum[i][j-1][0] - sum[i-1][j-1][0] + a[i][j];
        sum[i][j][1] = sum[i-1][j][1] + sum[i][j-1][1] - sum[i-1][j-1][1] + b[i][j];
     }
}

bool in(int u,int v,int i,int j) {
    if (u>=i && u <=i+k-1 && v>=j && v<=j+k-1) return true;
    return false;
}

inline void cal(int i,int j,int u,int v) {
    int xanh1,xanh2,do1,do2,do3=0,xanh3=0,res,tongxanh;
    xanh1 = get(i,j,i+k-1,j+k-1,0);
    do1 = get(i,j,i+k-1,j+k-1,1);
    xanh2 = get(u,v,u+k-1,v+k-1,0);
    do2 = get(u,v,u+k-1,v+k-1,1);
    if (in(u,v,i,j)) {
        do3 = get(u,v,i+k-1,j+k-1,1);
        xanh3 = get(u,v,i+k-1,j+k-1,0);
    } else if (in(u,v+k-1,i,j)) {
        do3 = get(u,j,i+k-1,v+k-1,1);
        xanh3 = get(u,j,i+k-1,v+k-1,0);
    }
    res = do1 - do3 + xanh3 + do2 - do3;
    tongxanh = xanh1 + xanh2 - xanh3;
    res = SUM - tongxanh + res;
    if (kq[i][j]>res) kq[i][j]=res;
    if (kq[u][v]>res) kq[u][v]=res;
}

void solve() {
    For(i,1,m-k+1)
      For(j,1,n-k+1) kq[i][j] = m*n+1;
    For(i,1,m-k+1)
      For(j,1,n-k+1) {
         For(v,j,n-k+1)
		   cal(i,j,i,v);
         For(u,i+1,m-k+1)
           For(v,1,n-k+1)
		    cal(i,j,u,v);
      }
    For(i,1,m-k+1) {
        For(j,1,n-k+1) printf("%d ",kq[i][j]);
        printf("\n");
    }
}

int main() {
    freopen("C11BC3.INP","r",stdin);
    freopen("C11BC3.OUT","w",stdout);
    scanf("%d%d%d\n",&m,&n,&k);
    For(i,1,m) {
        char c1;
        For(j,1,n) {
        scanf("%c",&c1);
        if (c1=='1') {a[i][j]=1; SUM++; }
         else if (c1=='2') { b[i][j]=1; }
        }
        scanf("\n");
    }
    init();
   // trau();
    solve();
}



