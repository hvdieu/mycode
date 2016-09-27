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
#define eps 1e-8

double a[N], b[N], sum;
int n;

bool check(double x) {
    b[n+1] = 10000000.0;
    sum = 0;
    Rep(i, n, 1) {
        sum += a[i] - x;
        b[i] = min(b[i+1], sum);
    }
    sum = 0;
    For(i, 1, n-2) {
        sum += a[i] - x;
        if (sum + b[i+2] <= 0) return true;
    }
    return false;
}

int main() {
    freopen("14.in","r",stdin);
    freopen("sabotage.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%lf", &a[i]);
    double d = 0.0, c = 10000.0, mid, ans;
    while (c - d > eps) {
        mid = (d + c) / 2;
        if (check(mid)) {
            ans = mid; c = mid - eps;
        } else d = mid + eps;
    }
    printf("%.3lf", ans);
}
