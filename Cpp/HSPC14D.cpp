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
using namespace std;
int ntest;
ll n,p;

ll tinh(ll n,ll p) {
    if (n==1) return 0;
    ll temp=1;
    For(i,1,60) if (temp*2<n) temp*=2;
    ll mau=tinh(n-temp,p);
    if (mau==p-1) return 0; else return mau+1;
}

int main() {
   // freopen("input.txt","r",stdin);
   // freopen("output.txt","w",stdout);
    scanf("%d",&ntest);
    while (ntest) {
        ntest--;
        scanf("%lld %lld",&n,&p);
        printf("%lld\n",tinh(n,p));
    }
}

