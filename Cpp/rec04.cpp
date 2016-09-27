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
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 5001
#define inf 1 << 31

struct point {
    int x, y;
};

int n, m, dd[N], g[2*N];
ll smin, smax, cmin, cmax, res;
point a[N];
ii b[2*N];

bool cmp(point a, point b) {
    if (a.x != b.x) return a.x < b.x;
    return a.y < b.y;
}

void solve() {
    sort(b + 1, b + n + 1);
    smin = 1LL << 62;
    b[0].fi = inf;
    int dem = 0;
    For(i, 1, n) {
        if (b[i].fi != b[i-1].fi) dem++;
        g[dem] = b[i].fi;
        a[b[i].se].y = dem;
    }
    sort(a + 1, a + n + 1, cmp);
    int i = 1;
    while (i <= n) {
        int j = i;
        while (j < n && a[i].x == a[j+1].x) j++;
        For(k, i, j) dd[a[k].y] = 1;
        int mi, ma, dem = 0;
        For(k, j + 1, n) if (a[k].x != a[k - 1].x) {
            if (dd[a[k].y]) {
                mi = g[a[k].y]; ma = g[a[k].y];
                dem = 1;
            } else {
                mi = inf; ma = -inf; dem = 0;
            }
        } else {
            if (dd[a[k].y]) {
                res += dem; dem++;
                ll len = a[k].x - a[i].x;
                if (mi != inf) {
                    ll S = len * (g[a[k].y] - mi);
                    if (S == smax) cmax++;
                    else if (S > smax) { smax = S; cmax = 1; };
                }

                if (ma != -inf) {
                    ll S = len * (g[a[k].y] - ma);
                    if (S == smin) cmin++;
                    else if (S < smin) { smin = S; cmin = 1; };
                }
                mi = min(mi, g[a[k].y]); ma = max(ma, g[a[k].y]);
            }
        }
        For(k, i, j) dd[a[k].y] = 0;
        i = j + 1;
    }
    if (res) {
    cout << smax;
   // cout << smin << ' ' << cmin << endl;
    }
}

int main() {
    freopen("castle.inp","r",stdin);
    //freopen("castle.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) {
        int x, y;
        scanf("%d %d", &x, &y);
        a[i].x = x;
        b[i] = make_pair(y, i);
    }
    solve();
}

