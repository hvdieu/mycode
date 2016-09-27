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
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 50010
#define inf 1000000000

int n, a[N], f[N][4], res, m, t[N][8];
ii Q[N];

void roirac() {
    sort(Q+1, Q+1+n);
    Q[0].fi = -1;
    int dem = 0;
    For(i, 1, n) {
        if (Q[i].fi != Q[i-1].fi) dem++;
        a[Q[i].se] = dem;
    }
    m = dem;
}

void sub1() {
    For(i, 0, n) For(j, 0, 3) f[i][j] = -inf;
    f[0][0] = 0;
    For(i, 1, n) For(j, 0, i-1) {
        if (a[j] < a[i]) f[i][0] = max(f[i][0], f[j][0]+1);
        if (a[j] > a[i]) f[i][1] = max(f[i][1], max(f[j][0]+1, f[j][1]+1));
        if (a[j] < a[i]) f[i][2] = max(f[i][2], max(f[j][1]+1, f[j][2]+1));
        if (a[j] > a[i]) f[i][3] = max(f[i][3], max(f[j][2]+1, f[j][3]+1));
    }
    For(i, 1, n) res = max(res, f[i][3]);
    printf("%d", res);
}

void update(int i, int j, int val) {
    for(i; i <= m; i += i & (-i)) t[i][j] = max(t[i][j], val);
}

int get(int i, int j) {
    int s = -inf;
    for(i; i > 0; i -= i & (-i)) s = max(s, t[i][j]);
    return s;
}

void solve() {
    For(i, 1, n) For(j, 0, 7) t[i][j] = -inf;
    For(i, 1, n) {
        int low = a[i]-1, high = m - a[i];
        f[i][0] = max(1, get(low, 0)+1);
        int x = get(high, 0+4), y = get(high, 1+4);
        f[i][1] = max(x, y) + 1;
        x = get(low, 1); y = get(low, 2);
        f[i][2] = max(x, y) + 1;
        x = get(high, 2+4); y = get(high, 3+4);
        f[i][3] = max(x, y) + 1;
        low = a[i]; high = m - a[i] + 1;
        For(j, 0, 3) {
            update(low, j, f[i][j]);
            update(high, j+4, f[i][j]);
        }
    }
    For(i, 1, n) res = max(res, f[i][3]);
    printf("%d", res);
}

int main() {
    freopen("M.INP","r",stdin);
    //freopen("M.OUT","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) {
        scanf("%d", &a[i]);
        Q[i] = ii(a[i], i);
    }
    roirac();
    if (n <= 1000) sub1(); else
    solve();
}




