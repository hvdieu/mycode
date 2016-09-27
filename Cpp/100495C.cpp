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
#define M 1000000007
const int c[11][11] = {
{0,0,0,0,0,0,0,0,0,0,0},
{0,460923927,1,0,0,0,0,0,0,0,0},
{0,713305125,0,1,0,0,0,0,0,0,0},
{0,470204132,0,0,1,0,0,0,0,0,0},
{0,478562771,0,0,0,1,0,0,0,0,0},
{0,966920277,0,0,0,0,1,0,0,0,0},
{0,90989036 ,0,0,0,0,0,1,0,0,0},
{0,870933729,0,0,0,0,0,0,1,0,0},
{0,825532803,0,0,0,0,0,0,0,1,0},
{0,907909733,0,0,0,0,0,0,0,0,1},
{0,680766114,0,0,0,0,0,0,0,0,0}};

struct mat {
    int h[11][11];
};

int ntest,n,x;
int a[11],Tribo[40],Fibo[40],FFF[11],G[11];
mat b,d;

int mu(int a,int b) {
    if (b==0) return 1;
    if (b==1) return a%M;
    int temp = mu(a,b/2);
    temp = ((ll)temp*temp)%M;
    if (b%2) return ((ll)temp*a)%M;
    return temp;
}

int FrFF(int i) {
    return mu(Fibo[i+25],Tribo[i+20]);
}

void init() {
    Tribo[0]=0; Tribo[1]=1; Tribo[2]=1;
    Fibo[0]=0; Fibo[1]=1; Fibo[2]=1;
    For(i,3,40) {
        Tribo[i] = Tribo[i-1]+Tribo[i-2]+Tribo[i-3];
        Fibo[i] = Fibo[i-1]+Fibo[i-2];
    }
    Ford(i,10,1) FFF[i]=(FFF[i+1]+FrFF(i))%M;
    For(i,1,10) printf("%d\n",FFF[i]);
}

mat nhan(mat a,mat b) {
    mat c;
    For(i,1,10)
     For(j,1,10) {
        c.h[i][j]=0;
        ll dem=0;
        For(k,1,10) dem = dem+((ll)a.h[i][k]*b.h[k][j]);
        c.h[i][j]=dem%M;
     }
     return c;
}

mat Mu(mat a,int b) {
    if (b==1) return a;
    mat temp=Mu(a,b/2);
    temp=nhan(temp,temp);
    if (b%2) return nhan(temp,a);
    return temp;
}

int main() {
    freopen("C.INP","r",stdin);
   // freopen("C.OUT","w",stdout);
    n=10;
    scanf("%d",&ntest);
    //init();
    int dem=0;
    while (ntest){
        ntest--;
        dem++; printf("Case #%d: ",dem);
        For(i,0,9) scanf("%d",&a[i]);
        scanf("%d",&x);
        if (x < 10) printf("%d\n",a[x]); else {
            For(i,1,10) b.h[1][i]=a[10-i];
            For(i,1,10) For(j,1,10) d.h[i][j]=c[i][j];
            d=Mu(d,x-9);
            d=nhan(b,d);
            printf("%d\n",d.h[1][1]);
        }
    }
}


