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
#define N 100010

int a[N], b[N], k, n;
ll s[N], ss[N];

int main() {
    //freopen("angry.inp","r",stdin);
    //freopen("angry.out","w",stdout);
    scanf("%d", &n);
    scanf("%d", &k);
    For(i, 1, n) scanf("%d", &a[i]);
    sort(a+1, a+n+1);
    k--; n--;
    For(i, 1, n) {
        b[i] = a[i+1] - a[i];
       //cout << b[i] << ' ';
        s[i] = s[i-1] + b[i];
        ss[i] = ss[i-1] + s[i];
    }
    ll res = 1000000000000000000LL;
    ll sum = 0;
    For(i, 1, k) {
        sum += ll(s[i]) * (2*i - k);
    }
    res = sum;
    For(i, k+1, n) {
        sum += s[i-k-1] * k;
        sum -= (ss[i-1] - ss[i-k-1]) * 2;
        sum += s[i] * k;
        res = min(res, sum);
    }
    cout << res;
}
