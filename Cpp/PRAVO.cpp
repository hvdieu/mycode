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
#define N 1510
#define inf 10000000000LL

double x[N],y[N],a[N];
int n;
ll res;

int find(double key,int tt) {
    int d=1,c=n,mid,ans=0;
    while (d<=c) {
        mid=(d+c)/2;
        if (key==a[mid]) {
            ans=mid;
            if (tt) d=mid+1;
             else c=mid-1;
        } else if (key>a[mid]) d=mid+1;
           else c=mid-1;
    }
    return ans;
}

void solve() {
    For(i,1,n) {
        For(j,1,n) {
            double xx=x[i]-x[j], yy = y[i]-y[j];
            if (xx==0) a[j]=inf;
              else a[j]= (-yy)/xx;
        }
        a[i]=inf+1;
        sort(a+1,a+n+1);
        For(j,1,n) if (i!=j) {
            double xx=x[i]-x[j], yy=y[i]-y[j],key;
            if (!yy) key=inf; else key=xx/yy;
            int u=find(key,0), v=find(key,1);
            if (u) res+=v-u+1;
        }
    }
    cout << res/2;
}

int main() {
    freopen("PRAVO.INP","r",stdin);
    freopen("PRAVO.OUT","w",stdout);
    scanf("%d",&n);
    For(i,1,n) scanf("%lf%lf",&x[i],&y[i]);
    solve();
}


