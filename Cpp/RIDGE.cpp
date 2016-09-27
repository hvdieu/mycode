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
typedef long long ll;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ld long double
#define pb push_back
#define sz(s) int(s.size())
#define N 100010

int n,t,a[N],p[N],top,l[N],r[N];

void solve() {
    p[0] = 0; p[1] = 1; l[1] = 1; top = 1;
    For(i,2,n) {
        if (a[i] <= a[i-1]) {
            l[i] = 1; p[++top] = i;
        } else {
            while (top && a[p[top]] < a[i]) top--;
            l[i] = i-p[top];
            p[++top] = i;
        }
    }
    p[0] = n+1; p[1] = n; r[n] = 1; top = 1;
    Rep(i,n-1,1) {
        if (a[i] <= a[i+1]) {
            r[i] = 1; p[++top] = i;
        } else {
            while (top && a[p[top]] < a[i]) top--;
            r[i] = p[top] - i;
            p[++top] = i;
        }
    }
    ll res = 0,sum = 0;
    For(i,1,t) sum += l[i]+r[i]-2;
    res = max(res,sum);
    For(i,t+1,n) {
        sum += l[i]+r[i]-2;
        sum -= l[i-t]+r[i-t]-2;
        res = max(res,sum);
    }
    printf("%lld\n",res);
    //For(i,1,n) printf("%d ",l[i]+r[i]-2); printf("\n");
   // For(i,1,n) printf("%d ",r[i]);
}

int main() {
    freopen("RIDGE.INP","r",stdin);
    freopen("RIDGE.OUT","w",stdout);
    scanf("%d%d",&n,&t);
    For(i,1,n) scanf("%d",&a[i]);
    solve();
}
