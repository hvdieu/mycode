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
using namespace std;
struct mat {
    ll h[4][4];
};
ll n,m;
mat a,b,c;

ll bigmod(ll a,ll b) {
    if (b==0) return 0;
    if (b==1) return a%m;
    ll c=bigmod(a,b/2);
    c = (c+c)%m;
    if (b%2==1) return (a+c)%m;
    return c;
}

mat nhan(mat a,mat b) {
    mat c;
    For(i,1,3) For(j,1,3) {
        c.h[i][j]=0;
        For(k,1,3) c.h[i][j]=(c.h[i][j]+bigmod(a.h[i][k],b.h[k][j]))%m;
    }
    return c;
}

mat mu(mat a,ll b) {
    if (b==1) return a;
    mat c = mu(a,b/2);
    c = nhan(c,c);
    if (b%2==1) return nhan(a,c);
    return c;
}

int main() {
   // freopen("C11SEQ4.INP","r",stdin);
    //freopen("output.txt","w",stdout);
    scanf("%lld %lld",&n,&m);
    ll sc = n/2+1,sl=(n+1)/2;
    a.h[1][1]=(sc-1)%m; a.h[1][2]=sl%m; a.h[1][3]=sl%m;
    b.h[1][1]=(sc-1)%m; b.h[1][2]=sl%m; b.h[1][3]=sl%m;
    b.h[2][1]=sc%m; b.h[2][2]=(sl-1)%m; b.h[2][3]=(sl-1)%m;
    b.h[3][1]=0; b.h[3][2]=0; b.h[3][3]=1;
    c = mu(b,n-1);
    c = nhan(a,c);
    printf("%lld",c.h[1][3]);
}

