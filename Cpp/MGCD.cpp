#include <vector>
#include <algorithm>
#include <math.h>
#include <iostream>
#include <stdio.h>
#include <string.h>
#include <cmath>
#include <cstring>
#include <queue>
#include <stack>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ld long double
#define pb push_back
#define all(x) x.begin(), x.end()
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define two(i) (ll(1) << i)
#define N 100010

int n, ntest, vmax;
ll a[N], f[N][21];

ll gcd(ll a, ll b) {
    if (!b) return a;
    return gcd(b, a % b);
}

ll get(int i, int j) {
    int k = trunc(log(j-i+1) / log(2));
    return gcd(f[i][k], f[j - two(k) + 1][k]);
}

int find(int i, int c,ll x) {
    int mid,d = 1,ans;
    while (d <= c) {
        mid = (d+c) / 2;
        ll y = get(mid,i);
        if (y == x) {
            ans = mid; c = mid-1;
        } else if (y > x) c = mid-1;
        else d = mid+1;
    }
    return ans;
}



void solve() {
    ll res = 0;
    vmax = trunc(log(n) / log(2));
    For(i, 1, n) f[i][0] = a[i];
    For(j, 1, vmax) For(i, 1, n - two(j) + 1)
    f[i][j] = gcd(f[i][j-1], f[i + two(j-1)][j-1]);
    For(i, 1, n) {
        int j = i;
        while (j) {
            ll x = get(j, i);
            int u = find(i, i, x);
            res = max(res,ll(x)*(i-u+1));
            j = u - 1;
        }
    }
    cout << res << endl;
}

int main() {
  //  freopen("mgcd.inp","r",stdin);
   // freopen("mgcd.out","w",stdout);
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d", &n);
        For(i, 1, n) scanf("%lld", &a[i]);
        solve();
    }
}
