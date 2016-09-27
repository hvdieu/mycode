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
#define N 1000010
#define ll long long
using namespace std;

char s[N];
int n;
int a[N],b[N];

int main() {
  //  freopen("VOSSEVEN.INP","r",stdin);
   // freopen("VOSSEVEN.OUT","w",stdout);
    scanf("%s",s);
    n = strlen(s);
    int i=0;
    while (i<=n-1) {
        while ((i<=n-1)&&(s[i]!='7')) i++;
        if (i<=n-1) {
            int l=0;
            while ((i<=n-1)&&(s[i]=='7')) {l++; i++;}
            a[1]-=1; a[l+1]+=1;
            b[1]+=l+1; b[l+1]-=l+1;
        }
    }
    int k;
    For(i,1,n) {
        a[i]+=a[i-1]; b[i]+=b[i-1];
        k = (ll)a[i]*i+b[i];
        if (k) printf("%d %d\n",i,k);
    }
}

