#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define p first
#define s second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 100010
#define inf 1000000001

int n, vmax;
ii a[N];
int f[N][20], g[N][20];

int get(int i, int j) {
    int k = trunc(log(j-i+1) / log(2));
    return min(f[i][k], f[j-two(k)+1][k]);
}

int get2(int i, int j) {
    int k = trunc(log(j-i+1) / log(2));
    return max(g[i][k], g[j-two(k)+1][k]);
}

bool check(int i, int j) {
    while (1) {
        int u = i, v = j;
        int d = j, c = n, mid, ans = -1;
        while (d <= c) {
            mid = (d + c) / 2;
            if (get(j, mid) > a[i].p) {
                ans = mid; d = mid + 1;
            } else c = mid - 1;
        }
        if (ans != -1) j = ans + 1;
        d = 1, c = i, mid, ans = -1;
        while (d <= c) {
            int mid = (d+c) / 2;
            if (get2(mid, i) < a[j].p) {
                ans = mid; c = mid - 1;
            } else d = mid + 1;
        }
        if (ans != -1) i = ans - 1;
        if (i == u && j == v) break;
    }
    if (i == 1 || j == n) return true;
    return false;
}

int main() {
    freopen("trapped.in","r",stdin);
    freopen("trapped.out","w",stdout);
    scanf("%d", &n);
    a[1] = ii(0, inf);
    For(i, 2, n+1) scanf("%d%d", &a[i].s, &a[i].p);
    a[n+2] = ii(inf, inf);
    n += 2;
    sort(a+1, a+n+1);
    For(i, 1, n) {
        f[i][0] = a[i].p - a[i].s;
        g[i][0] = a[i].p + a[i].s;
    }
    vmax = trunc(log(n) / log(2));
    For(j, 1, vmax) For(i, 1, n - two(j) + 1) {
        f[i][j] = min(f[i][j-1], f[i + two(j-1)][j-1]);
        g[i][j] = max(g[i][j-1], g[i + two(j-1)][j-1]);
    }
    int res = 0;
    For(i, 2, n-2) if (!check(i, i+1)) res += a[i+1].p - a[i].p;
    cout << res;
}
