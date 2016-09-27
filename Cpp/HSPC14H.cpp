#include <stdio.h>
#include <iostream>
#include <algorithm>
#include <math.h>
#include <vector>
#include <string>
#include <cstring>
#include <map>
#include <set>
#define For(i,a,b) for(int i=a;i<=b;i++)
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ll long long
#define pb push_back
#define N 1510
using namespace std;
int m,n,a[N][N],b[N][N],c[N][N],d[N][N],f[N][N],g[N][N];

void solve() {
    For(j,1,n) {
        For(i,1,m) d[i][j]=d[i-1][j]+b[i][j];
        Ford(i,m,1) c[i][j]=c[i+1][j]+a[i][j];
    }
    For(i,0,m) f[i][0]=-9999999;
    f[0][0]=0;
    For(j,1,n) {
        For(i,1,m) {
            f[i][j]=max(f[i][j-1]+c[i+1][j]+d[i-1][j],f[i-1][j-1]+c[i+1][j]+d[i-1][j]);
            f[i][j]=max(g[i-1][j]+c[i+1][j],f[i][j]);
            g[i][j]=max(g[i-1][j],max(f[i][j-1],f[i-1][j-1])+d[i-1][j]);
        }
    }
    printf("%d",f[m][n]);
}

int main() {
    freopen("input.txt","r",stdin);
    freopen("output.txt","w",stdout);
    scanf("%d%d\n",&m,&n);
    char c1,c2,c3;
    int x;
    For(i,1,m) {
        For(j,1,n) {
            scanf("%c%c%c",&c1,&c2,&c3);
            if ((c3==' ')||(c3=='\n')) x=(int)c2-int('0'); else 
			  { x=((int)c2-int('0'))*10+(int)c3-int('0'); 
			    if (j<n) scanf("%c",&c3); }
            if (c1=='A') a[i][j]=x; else b[i][j]=x;
        }
        scanf("\n");
    }
    solve();
}

