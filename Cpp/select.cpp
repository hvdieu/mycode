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
#define N 1010

int n, ntest;
int last1, last2;
ii a[N];

bool cmp(ii a, ii b) {
    if (a.fi != b.fi) return a.fi < b.fi;
    return a.se < b.se;
}

int main() {
    freopen("select.inp","r",stdin);
    freopen("select.out","w",stdout);
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d", &n);
        For(i, 1, n) scanf("%d%d", &a[i].fi, &a[i].se);
        int res = 0;
        sort(a+1, a+n+1, cmp);
        last1 = last2 = -1000000000;
        For(i, 1, n) {
            int u = a[i].fi, v = a[i].se;
            if (u > last1) {
                last1 = v;
                res++;
            } else if (u > last2) {
                last2 = v;
                res++;
            } else {
                if (v < last2) last2 = v;
                else if (v < last1) last1 = v;
            }
            if (last1 > last2) swap(last1, last2);
        }
        printf("%d\n", res);
    }
}
