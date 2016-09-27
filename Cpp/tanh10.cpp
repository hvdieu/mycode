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
#define N 50010

int n, res, b[N], vt;
ii a[N];

bool cmp(ii a, ii b) {
    return a.fi-a.se < b.fi-b.se;
}

int main() {
   // freopen("","r",stdin);
   // freopen("","w",stdout);
    while (scanf("%d", &n) != -1) {
        For(i, 1, n) {
            scanf("%d", &b[i]);
            a[i] = ii(b[i], i);
        }
        sort(a+1, a+n+1, cmp);
        int dem = 1, res = 1, vt = 1;
        For(i, 2, n) {
            if (a[i].fi-a[i].se == a[i-1].fi-a[i-1].se) dem++;
            else dem = 1;
            if (dem > res) {
                res = dem;
                vt = i;
            }
        }
        printf("%d\n", n-res);
        vt = a[vt].fi - a[vt].se + 1;
        For(i, vt, vt+n-2) printf("%d ", i);
        printf("%d\n", vt+n-1);
    }
}
