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
#define bit(x, i) ( (x >> i) & 1 )
#define onbit(x, i) ( x | (1 << i ) )
#define N 20010

int ntest, n, a[N];
ll res, t[100001][2];

void update(int i, int j, ll val) {
    for(i; i <= 100000; i += i & (-i)) t[i][j] += val;
}

ll get(int i, int j) {
    ll s = 0;
    for(i; i; i -= i & (-i)) s += t[i][j];
    return s;
}

void Cal() {
    reset(t, 0);
    For(i, 1, n) {
        ll f1 = 1;
        ll f2 = get(a[i]-1, 0);
        ll f3 = get(a[i]-1, 1);
        res += f3;
        update(a[i], 0, f1); update(a[i], 1, f2);
    }
}

void solve() {
    res = 0;
    Cal();
    reverse(a+1, a+n+1);
    Cal();
    cout << res << endl;
}

int main() {
   // freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    scanf("%d", &ntest);
    while (ntest) {
        ntest--; scanf("%d", &n);
        For(i, 1, n) scanf("%d", &a[i]);
        solve();
    }
}
