#include <bits/stdc++.h>
using namespace std;
typedef pair<double, double> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define t first
#define v second
#define ld long double
#define pb push_back
#define all(x) x.begin(), x.end()
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 510

int l, n,root[N], f[N], res;
ii a[N];

bool check(double t1, double v1, double t2, double v2) {
    if (v1 >= v2) return false;
    double t = ((t2 - t1) * v1) / (v2 - v1);
    double s = max((t2 - t1 + t) * v1, t * v2);
    if (s <= l) return true;
    return false;
}

void solve() {
    res = 1;
    For(i, 1, n) {
        root[i] = i; f[i] = 1;
    }
    sort(a+1, a+1+n);
    int res = 0;
    For(i, 1, n) {
        f[i] = 1;
        For(j, 1, i-1)
		if (check(a[j].t, a[j].v, a[i].t, a[i].v)) f[i] = max(f[i], f[j]+1);
        res = max(res, f[i]);
    }
    cout << res;
}

int main() {
    freopen("walk.inp","r",stdin);
    freopen("walk.out","w",stdout);
    scanf("%d%d", &l, &n);
    For(i, 1, n) scanf("%lf%lf", &a[i].t, &a[i].v);
    solve();
}
