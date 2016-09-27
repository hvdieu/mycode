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

int vmax,a[N],n,f[N][22];
ll res;

int gcd(int a,int b) {
    if (b == 0) return a;
    return gcd(b, a % b);
}

int get(int u,int v) {
    int k = trunc(log(v-u+1) / log(2));
    return gcd(f[u][k], f[v - (1 << k) + 1][k]);
}

int find(int i, int c,int x) {
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
    vmax = trunc(log(n)/log(2));
    For(i,1,n) f[i][0] = a[i];
    For(j,1,vmax)
      For(i,1,n - (1 << j) + 1)
        f[i][j] = gcd(f[i][j-1],f[i + (1 << (j-1))][j-1]);
    res = 0;
    For(i,1,n) {
        int j = i;
        while (j) {
            int x = get(j,i);
            int u = find(i,i,x);
            res = max(res,ll(x)*(i-u+1));
            j = u - 1;
        }
    }
    cout << res;
}

int main() {
    freopen("gcd.inp","r",stdin);
    freopen("gcd.out","w",stdout);
    scanf("%d",&n);
    For(i,1,n) scanf("%d",&a[i]);
    solve();
}
