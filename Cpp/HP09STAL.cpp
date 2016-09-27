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
#define N 2510

int n,k,p,x[N],f[N],res;

void solve() {
    sort(x+1,x+1+n);
    f[1] = 1;
    res = 1;
    For(i,2,n) {
        f[i] = 1;
        Rep(j,i-1,1) {
         if (x[i]-x[j]>p) break;
          else if (x[i]-x[j]>=k) f[i] = max(f[i],f[j]+1);
        }
        res = max(res,f[i]);
    }
    cout << n-res;
}

int main() {
    freopen("input.txt","r",stdin);
    freopen("output.txt","w",stdout);
    scanf("%d%d%d",&n,&k,&p);
    For(i,1,n) scanf("%d",&x[i]);
    solve();
}


