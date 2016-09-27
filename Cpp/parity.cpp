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

int n,a[N],s[N][2],dd[N];
ll res = 0;
vector<ii> q;

int main() {
    freopen("parity.inp","r",stdin);
    freopen("parity.out","w",stdout);
   q.pb(ii(0,0));
    scanf("%d",&n);
    For(i,1,n) {
        int x;
        scanf("%d",&x);
        s[i][0] = s[i-1][0]; s[i][1] = s[i-1][1];
        s[i][x % 2]++;
        q.pb(ii(s[i][0] - s[i][1],i));
    }
    sort(q.begin(),q.end());
    a[q[0].se] = 1; int dem = 1;
    For(i,1,sz(q)-1) {
        if (q[i].fi != q[i-1].fi) dem++;
        a[q[i].se] = dem;
    }
    dd[a[0]]++;
    For(i,1,n) {
        res += dd[a[i]];
        dd[a[i]]++;
    }
    cout << res;
}
