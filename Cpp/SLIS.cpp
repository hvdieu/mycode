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
#define N 100010
#define inf 100001

int t[N], n, a[N], res[N], dd[N], f[N], g[N];

int get(int i) {
    int s = 0;
    for(; i; i -= i & (-i)) s = max(s, t[i]);
    return s;
}

void update(int i, int val) {
    for( ; i <= inf; i += i & (-i)) t[i] = max(t[i], val);
}

void solve() {
    a[0] = 0; a[n+1] = inf;
    For(i, 1, n+1) {
        f[i] = get(a[i]-1) + 1;
        update(a[i], f[i]);
    }
    reset(t, 0); int m = f[n+1];
    g[n+1] = 0;
    Rep(i, n, 1) {
        g[i] = get(inf-a[i]) + 1;
        update(inf - a[i] + 1, g[i]);
    }
    For(i, 1, n)
	if (f[i] + g[i] != m) res[i] = 1;
    else dd[f[i]]++;
    For(i, 1, n) if (res[i]==0) if (dd[f[i]] == 1)res[i] = 3; else res[i] = 2;
    For(i, 1, n) printf("%d", res[i]);
}

int main() {
    freopen("slis.inp","r",stdin);
   // freopen("slis.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d", &a[i]);
    solve();
}
