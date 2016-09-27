#include <stdio.h>
#include <iostream>
#include <algorithm>
#include <math.h>
#include <vector>
#include <string>
#define For(i,a,b) for(int i=a;i<=b;i++)
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define N 1000010
using namespace std;

int n,x,ntest,m1,m2,k,y;
long long res;
int mu[11];
char s[N];
int sum[N];

int main() {
    freopen("input.txt","r",stdin);
    //freopen("VOSLUCKY.OUT","w",stdout);
    scanf("%d\n",&ntest);
    while (ntest>0) {
        ntest--;
        scanf("%d %d\n",&x,&n);
        For(i,1,n) scanf("%c",&s[i]);
        y=x; m1=0; m2=0; res=0;
        while ((y!=1)&&(y%2==0)) {
            y/=2; m1++;
        }
        while ((y!=1)&&(y%5==0)) {
            y/=5; m2++;
        }
        k=max(m1,m2);
        mu[0]=1;
        For(i,1,k) mu[i]=(mu[i-1]*10)%x;
        int dem=0; res=0;
        For(i,1,n) {
            int hold=0;
            Ford(j,i,max(i-k+1,1))
			if ((j!=i)&&(s[j]=='0')) continue; else {
                int ch=int(s[j])-int('0');
                hold=(hold+ch*mu[i-j])%x;
                if (hold==0) res++;
            }
            if ((i>k) && (hold==0)) res+=sum[i-k];
            sum[i]=sum[i-1];
            if (s[i]!='0') sum[i]++;
        }
        printf("%lld\n",res);
    }
}
