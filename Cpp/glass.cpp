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
#define N 1001

struct rec {
    int x1, y1, x2, y2, t;
};

int n, G, gx[2*N], gy[2*N], r, c, s[2*N][2*N], m;
rec a[N];
ii xx[2*N], yy[2*N];
ull res;

void init() {
    sort(xx + 1, xx + m + 1);
    sort(yy + 1, yy + m + 1);
    xx[0].fi = -1; yy[0].fi = -1;
    int d1 = 0, d2 = 0;
    For(i, 1, m) {
        if (xx[i].fi != xx[i-1].fi) d1++;
        gx[d1] = xx[i].fi;
        int j = xx[i].se;
        if (j > n) a[j - n].x2 = d1;
        else a[j].x1 = d1;

        if (yy[i].fi != yy[i-1].fi) d2++;
        gy[d2] = yy[i].fi;
        j = yy[i].se;
        if (j > n) a[j - n].y2 = d2;
        else a[j].y1 = d2;
     }
     r = d1; c = d2;
}

void IncRec(int x1, int y1, int x2, int y2, int t) {
    s[x1][y1] += t;
    s[x2][y2] += t;
    s[x1][y2] -= t;
    s[x2][y1] -= t;
}

void solve() {
    init();
    For(i, 1, n) IncRec(a[i].x1, a[i].y1, a[i].x2, a[i].y2, a[i].t);
    For(i, 1, r - 1) For(j, 1, c - 1) {
        s[i][j] = s[i][j-1] + s[i-1][j] - s[i-1][j-1] + s[i][j];
        if (s[i][j] >= G) res += (ull(gx[i + 1]) - gx[i]) * (ull(gy[j + 1]) - gy[j]);
    }
    cout << res;
}

int main() {
    freopen("glass.inp","r",stdin);
    freopen("glass.out","w",stdout);
    scanf("%d", &n);
    scanf("%d", &G);
    For(i, 1, n) {
        int x1, x2, y1, y2;
        scanf("%d%d%d%d%d", &x1, &y1, &x2, &y2, &a[i].t);
        m++; xx[m] = ii(x1, i); yy[m] = ii(y1, i);
        m++; xx[m] = ii(x2, i + n); yy[m] = ii(y2, i + n);
    }
    solve();
}
