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
#define N 100010

int n, k, a[N], t[N], m, res;
ll s[N];
vector<lli> Q;

void update(int i, int val) {
    for(i; i <= m; i += i & (-i)) t[i] = min(t[i], val);
}

int get(int i) {
    int s = n + 1;
    for(i; i; i -= i & (-i)) s = min(s, t[i]);
    return s;
}

void solve() {
    For(i, 0, n) Q.pb(lli(s[i], i));
    sort(all(Q));
    m = 0;
    For(i, 0, sz(Q)-1) {
        if (!i || Q[i].fi != Q[i-1].fi) m++;
        a[Q[i].se] = m;
    }
    For(i, 1, m) t[i] = n+1;
    res = 0;
    update(a[0], 0);
    For(i, 1, n) {
        int j = get(a[i]-1);
        if (j <= n) res = max(res, i - j);
        update(a[i], i);
    }
    cout << res << endl;
    //For(i, 0, n) cout << a[i] << ' ';
}

int main() {
    freopen("ave.inp","r",stdin);
    freopen("ave.out","w",stdout);
    scanf("%d%d", &n, &k);
    For(i, 1, n) {
        int x;
        scanf("%d", &x);
        s[i] = s[i-1] + x - k;
    }
    solve();
}
