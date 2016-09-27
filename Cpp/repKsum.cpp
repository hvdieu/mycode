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
#include <bits/stdc++.h>

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
#define bit(x, i) ( (x >> i) & 1 )
#define onbit(x, i) ( x | (1 << i ) )
#define N 100010

int n, k, ntest, m;
multiset<ll> ff;
ll a[N];

void del(int i, int j, int cnt, ll sum) {
    if (cnt == k) {
        ff.erase(ff.find(sum));
        return;
    }
    del(i, j, cnt+1, sum + a[j]);
    if (j < i) del(i, j+1, cnt, sum);
}

void nhap() {
		ll x; char c;
        while (scanf("%lld%c", &x, &c) == 2) {
            ff.insert(x);
            if (c == '\n') break;
        }
}

void solve() {
		scanf("%d%d\n", &n, &k);
        ff.clear();
		nhap();
        a[1] = *(ff.begin()) / k; ff.erase(ff.begin());
        For(i, 2, n) {
            a[i] = *(ff.begin()) - (k-1) * a[1];
            if (i < n) del(i, 1, 1, a[i]);
        }
        For(i, 1, n) printf("%lld ", a[i]);
        cout << endl;
}

int main() {
    freopen("input.txt","r",stdin);
   // freopen("output.txt","w",stdout);
    scanf("%d", &ntest);
    while (ntest) {
    	ntest--;
        solve();
    }
}
