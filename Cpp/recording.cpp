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

int n,res,last[2];
ii a[N];

bool cmp(ii A, ii B) {
    return A.se < B.se;
}

void solve() {
    sort(a+1,a+n+1,cmp);
    For(i,1,n) {
        if (last[0] < last[1]) swap(last[0],last[1]);
        if (a[i].fi >= last[0]) {
            res++; last[0] = a[i].se;
        } else if (a[i].fi >= last[1]) {
            res++; last[1] = a[i].se;
        }
    }
    cout << res;
}

int main() {
    freopen("recording.inp","r",stdin);
    freopen("recording.out","w",stdout);
    scanf("%d",&n);
    For(i,1,n) scanf("%d %d",&a[i].fi,&a[i].se);
    solve();
}
