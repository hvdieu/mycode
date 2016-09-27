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
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ll long long
#define ld long double
#define pb push_back
#define sz(s) int(s.size())
#define N 1000010

int p[2*N],s[2*N],ntest;
ll n;

void init() {
    p[1] = 1;
    For(i,2,int(sqrt(2000000))) if (!p[i]) {
        int j = i*i;
        while (j <= 2000000) {
            p[j] = 1;
            j = j+i;
        }
    }
    For(i,2,2000000) {
        s[i] = s[i-1];
        if (!p[i]) s[i]++;
    }
}

void solve() {
    ll res = 0,r1;
    For(i,1,n) {
        ll d1 = s[i+n] - s[i];
        if (!p[i+i]) d1--;
        ll d2 = n-1-d1;
        res += d1*d2;
    }
    res = n*(n-1)*(n-2)/6 - res/2;
    printf("%lld\n",res);
}

int main() {
    freopen("coltri.inp","r",stdin);
    freopen("coltri.out","w",stdout);
    scanf("%d",&ntest);
    init();
    while (ntest) {
        ntest--;
        scanf("%lld",&n);
        solve();
    }
}



