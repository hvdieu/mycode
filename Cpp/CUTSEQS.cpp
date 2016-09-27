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
#define N 100010

int n,bot,top,back[N],p[N];
ll M,dp[N],a[N],mm,s[N];
multiset <ll> ff;
multiset <ll>::iterator it;

void solve() {
    dp[0] = 0; dp[1] = a[1];
    back[1] = 0;
    bot = 1; top = 1;
    p[1] = 1;
    ff.insert(a[1]);
    int j = 1;
    ll sum = a[1];
    s[1] = a[1];
    For(i,2,n) {
        sum += a[i];
        //s[i] = s[i-1] + a[i];
        while (top >= bot && a[i] >= a[p[top]]) {
        	it = ff.find(a[p[top]] + dp[back[p[top]]]);
            ff.erase(it);
            top--;
        }
        top++; p[top] = i;
        if (bot==top) back[i] = j-1;
          else back[i] = p[top-1];
      //  if ((top-bot+1)!=ff.size()) printf("%d\n",i);
        ff.insert(a[i] + dp[back[i]]);
        while (sum > M) {
            if (p[bot]==j) {
            	it = ff.find(a[p[bot]] + dp[back[p[bot]]]);
                ff.erase(it);
                it = ff.find(a[p[bot+1]] + dp[p[bot]]);
                ff.erase(it);
                ff.insert(a[p[bot+1]] + dp[j]);
                bot++; back[p[bot]] = j;
            } else {
            	it = ff.find(a[p[bot]] + dp[j-1]);
                ff.erase(it);
                ff.insert(a[p[bot]] + dp[j]);
                back[p[bot]] = j;
            }
            sum -= a[j]; j++;
        }
        it = ff.begin();
        dp[i] = *it;
    }
   // For(i,1,n) printf("%lld\n",dp[i]);
    cout << dp[n];
}

int main() {
    freopen("CUTSEQS.INP","r",stdin);
    freopen("CUTSEQS.OUT","w",stdout);
    scanf("%d %lld",&n,&M);
    For(i,1,n) {
        scanf("%lld",&a[i]);
        mm = max(mm, a[i]);
    }
    if (mm > M) printf("-1");
      else solve();
}


