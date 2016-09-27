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
#define N 1000010
#define M 1000000007

int n,k;
ll s[N],f[N],res;

int mu(int a,int b) {
    if (b==0) return 1;
    if (b==1) return a % M;
    ll x = mu(a,b/2);
    x = (x*x) % M;
    if (b%2) return (x*a) % M;
    return x;
}

int C(int k,int n) {
    if (n==0) return 0;
    if (k==0) return 1;
    if (k>n) return 0;
    ll t1=1,t2=1,t3=1;
    For(i,1,n) {
        t1 = (t1*i) % M;
        if (i==n-k) t2=t1;
        if (i==k) t3=t1;
    }
    t2 = (t2*t3) % M;
    return (t1*mu(t2,M-2)) % M;
}

int main() {
    freopen("QTDIVSEQ.INP","r",stdin);
    freopen("QTDIVSEQ.OUT","w",stdout);
    scanf("%d%d",&n,&k);
    For(i,1,n) {
        int x;
        scanf("%d",&x);
        s[i] = s[i-1]+x;
    }
    if ((s[n]%k)!=0 && k>n) printf("0"); else {
        ll X = s[n] / k;
        if (X==0) {
            int dem=0;
            For(i,1,n-1) if (!s[i]) dem++;
            printf("%d",C(k-1,dem));
        } else {
            f[0] = 1;
            For(i,1,n-1) if (s[i]!=0 && s[i]%X==0 && s[i]!=s[n]) {
                int j = s[i] / X;
                if (j>=0 && j<=k){
                f[j] = (f[j] + f[j-1]) % M;
                }
            }
            printf("%d",f[k-1]);
        }
    }
}


