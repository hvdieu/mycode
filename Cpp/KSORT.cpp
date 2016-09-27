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

int n,k;
ii a[N];

void solve() {
    int count = 0;
    sort(a+1,a+n+1);
    For(i,1,n) if (a[i].se == i) count++;
    if (count >= k) {
        int res = (count - k) / 2 + (count - k) % 2;
        printf("%d",res); return;
    }
}

int main() {
    freopen("ksort.inp","r",stdin);
    freopen("ksort.out","w",stdout);
    scanf("%d%d",&n,&k);
    For(i,1,n) {
        scanf("%d",&a[i].fi);
        a[i].se = i;
    }
    solve();
}
