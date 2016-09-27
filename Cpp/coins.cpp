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
#define inf 10000000

int n,m,a[51],last[N],Q[N],s;
bool f[N];

void dp() {
    f[0] = true;
    last[0] = inf;
    For(i,1,s) last[i] = -1;
    For(i,1,n) {
      Rep(j,s,a[i]) {
        bool ok;
        f[j] = false;
        Rep(k,j / a[i],0)
          if (f[j - k*a[i]] && last[j - k*a[i]] >= k) {
            last[j] = k;
            f[j] = true;
            break;
          }
        if (!f[j]) last[j] = -1;

      }
      last[0] = -1;
  }
}

int main() {
    freopen("coins.inp","r",stdin);
   // freopen("coins.out","w",stdout);
    scanf("%d",&n);
    For(i,1,n) scanf("%d",&a[i]);
    scanf("%d",&m);
    For(i,1,m) {
        scanf("%d",&Q[i]);
        s = max(s,Q[i]);
    }
    dp();
    For(i,1,m)
     if (f[Q[i]]) printf("YES\n"); else printf("NO\n");
}
