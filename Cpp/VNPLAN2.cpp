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
#define N 82
#define M 1000000007
using namespace std;
int a[N][N],n;
ll d[N],c[N];
ll C[N][N],res,dem;
bool fr[N];

void dfs(int u) {
    dem++; fr[u]=false;
    For(v,1,n)
     if ((a[u][v]) && (fr[v])) dfs(v);
}

ll mu(int a, int b) {
    if (b==0) return 1;
    if (b==1) return a;
    ll temp=mu(a,b/2);
    temp = (temp*temp)%M;
    if (b%2) return (temp*a)%M;
    return temp;
}

int main() {
   // freopen("input.txt","r",stdin);
   // freopen("output.txt","w",stdout);
    scanf("%d",&n);
    For(i,1,n)
      For(j,1,n) scanf("%d",&a[i][j]);
    For(i,0,n) C[0][i]=1;
    For(j,1,n) For(i,1,j) C[i][j]=(C[i][j-1]+C[i-1][j-1])%M;
    For(i,1,n) {
        d[i]=mu(2,i*(i-1));
        ll sum=0;
        For(k,1,i-1) sum = (sum + (((C[k][i]*c[k])%M)*((d[i-k]*k)%M))%M)%M;
        c[i]=(d[i]-(sum*mu(i,M-2))%M+M)%M;
    }
    //For(i,1,n) printf("%lld %lld\n",c[i],s[i]);
    memset(fr,true,sizeof(fr));
    res = 1;
    For(i,1,n) if (fr[i]) {
        dem=0;
        dfs(i);
        res = (res*c[dem])%M;
    }
    printf("%lld",res);
}



