#include <iostream>
#include <stdio.h>
#include <algorithm>
#define FOR(i,a,b) for(long i=a;i<=b;i++)
const long maxn=1010;
using namespace std;
long n,r1,r2,r3,x[2*maxn],y[2*maxn],id[maxn];
long long a,b,c,a1[maxn],b1[maxn],c1[maxn];

long long gcd(long long a,long long b){
    if (b==0) return a; else return gcd(b,a%b);
}

void xay(long x1,long y1,long x2,long y2){
    a=y2-y1; b=x1-x2; c=(long long)(y1)*(x2-x1)-(long long)(x1)*(y2-y1);
    if (a<0) {a*=-1; b*=-1; c*=-1;};
    long long t=0;
    if (a!=0) t=a; if (b!=0) t=b; if (c!=0) t=c;
    if (t!=0){
        if (a!=0) t=gcd(t,a); if (b!=0) t=gcd(t,b); if (c!=0) t=gcd(t,c);
        a/=t; b/=t; c/=t;
    }
}

void sort(int l,int h){
    if (l>=h) return;
    long i=l, j=h, k=l+rand()%(h-l+1);
    long long k1=a1[k], k2=b1[k], k3=c1[k];
    do{
       while ((a1[i]<k1)||((a1[i]==k1)&&(b1[i]<k2))||((a1[i]==k1)&&(b1[i]==k2)&&(c1[i]<k3))) i++;
       while ((a1[j]>k1)||((a1[j]==k1)&&(b1[j]>k2))||((a1[j]==k1)&&(b1[j]==k2)&&(c1[j]>k3))) j--;
       if (i<=j){
        swap(a1[i],a1[j]); swap(b1[i],b1[j]); swap(c1[i],c1[j]); swap(id[i],id[j]);
        i++; j--;
       }
    } while (i<=j);
    sort(l,j); sort(i,h);
}

void sub2(){
    r1=r2=r3=-1;
    FOR(i,1,n){
     FOR(j,n+1,2*n){
       xay(x[i],y[i],x[j],y[j]);
       a1[j-n]=a; b1[j-n]=b; c1[j-n]=c; id[j-n]=j;
     }
     sort(1,n);
     FOR(j,2,n){
       if ((a1[j]==a1[j-1])&&(b1[j]==b1[j-1])&&(c1[j]==c1[j-1])){
        r1=i; r2=id[j]; r3=id[j-1]; return;
       }
     }
    }
    FOR(i,n+1,2*n){
     FOR(j,1,n){
       xay(x[i],y[i],x[j],y[j]);
       a1[j]=a; b1[j]=b; c1[j]=c; id[j]=j;
     }
     sort(1,n);
     FOR(j,2,n){
       if ((a1[j]==a1[j-1])&&(b1[j]==b1[j-1])&&(c1[j]==c1[j-1])){
        r1=i; r2=id[j]; r3=id[j-1]; return;
       }
     }
    }
}

int main(){
    //freopen("BALLGAME.INP","r",stdin);
    //freopen("BALLGAME.OUT","w",stdout);
    scanf("%d",&n);
    FOR(i,1,2*n) scanf("%d%d",&x[i],&y[i]);
    sub2;
    if (r1==-1) printf("%d",-1); else{cout <<r1<<" "<<r2<<" "<<r3;}
    return 0;
}

