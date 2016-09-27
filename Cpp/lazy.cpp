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
#define N 100010

struct node {
    int x, y, val;
};

int n, gt[N], t[8*N], f[8*N], m, lef[N], righ[N], k;
node a[N];
vector<ii> Q;

bool cmp(node a, node b) {
    if (a.x != b.x) return a.x < b.x;
    return a.y < b.y;
}

void down(int i) {
    int c1 = i*2, c2 = c1+1;
    t[c1] += f[i]; t[c2] += f[i];
    f[c1] += f[i]; f[c2] += f[i];
    f[i] = 0;
}

void update(int i, int lo, int hi, int u, int v, int x) {
    if (lo == u && hi == v) {
        t[i] += x;
        f[i] += x;
        return;
    }
    int mid = (lo + hi) / 2;
    down(i);
    if (u <= mid) update(i*2, lo, mid, u, min(mid, v), x);
    if (v > mid) update(i*2+1, mid+1, hi, max(mid+1, u), v, x);
    t[i] = max(t[i*2], t[i*2+1]);
}

void init() {
    sort(all(Q));
    k *= 2;
    int j = 1;
    int dem = 0;
    For(i, 0, sz(Q)-1) {
        if (!i || Q[i].fi != Q[i-1].fi) dem++;
        gt[dem] = Q[i].fi;
        while (gt[dem] - gt[j] > k) j++;
        lef[dem] = j;
        a[Q[i].se].y = dem;
    }
    m = dem; j = dem;
    Rep(i, m, 1) {
        while (gt[j] - gt[i] > k) j--;
        righ[i] = j;
    }
    sort(a+1, a+n+1, cmp);

}

void solve() {
    init();
    int res = 0;
    int j = 1;
    For(i, 1, n) {
        if (i > 1) update(1, 1, m, lef[a[i-1].y], a[i-1].y, -a[i-1].val);
        while (j <= n && a[j].x - a[i].x <= k) {
            update(1, 1, m, lef[a[j].y], a[j].y, a[j].val);
            j++;
        }
        res = max(res, t[1]);
    }
    cout << res;
}

int main() {
    freopen("lazy.in","r",stdin);
    freopen("lazy.out","w",stdout);
    scanf("%d%d", &n, &k);
    For(i, 1, n) {
        scanf("%d%d%d", &a[i].val, &a[i].x, &a[i].y);
        int u = a[i].x, v = a[i].y;
        a[i].x -= v; a[i].y += u;
        Q.pb(ii(a[i].y, i));
    }
    solve();
}
