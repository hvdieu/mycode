#include <bits/stdc++.h>

using namespace std;

typedef long long ll;
typedef long double ld;
typedef pair<int, int> ii;

#define For(i, a, b) for(int i = a; i <= b; i++)
#define Rep(i, a, b) for(int i = a; i >= b; i--)
#define all(x) x.begin(), x.end()
#define sz(x) int(x.size())
#define pb push_back
#define fi first
#define se second
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1LL << i))
#define N 1010
#define inf 1000000000000LL

int m, n, a[N][N], k;
ll s[N][N];

ll get(int i, int j, int u, int v) {
    return s[u][v] - s[u][j-1] - s[i-1][v] + s[i-1][j-1];
}

void sub1() {
    while (k) {
        int x1, x2, y1, y2;
        k--;
        scanf("%d%d%d%d", &x1, &y1, &x2, &y2);
        ll res = inf;
        For(i, x1, x2-1) {
            ll x = get(x1, y1, i, y2);
            ll y = get(i+1, y1, x2, y2);
            res = min(res, abs(x - y));
        }

        For(j, y1, y2-1) {
            ll x = get(x1, y1, x2, j);
            ll y = get(x1, j+1, x2, y2);
            res = min(res, abs(x-y));
        }

        printf("%lld\n", res);
    }
}

int Find(int x1, int y1, int x2, int y2) {
    int d = x1, c = x2-1, mid, ans = x1;
    while (d <= c) {
        int mid = (d + c) / 2;
        ll x = get(x1, y1, mid, y2);
        ll y = get(mid+1, y1, x2, y2);
        if (x == y) return mid;
        if (x < y) {
            ans = mid; d = mid + 1;
        } else c = mid - 1;
    }
    return ans;
}

int Find2(int x1, int y1, int x2, int y2) {
    int d = y1, c = y2-1, mid, ans = y1;
    while (d <= c) {
        int mid = (d + c) / 2;
        ll x = get(x1, y1, x2, mid);
        ll y = get(x1, mid+1, x2, y2);
        if (x == y) return mid;
        if (x < y) {
            ans = mid; d = mid + 1;
        } else c = mid - 1;
    }
    return ans;
}

void sub2() {
    while (k) {
        int x1, y1, x2, y2;
        k--;
        scanf("%d%d%d%d", &x1, &y1, &x2, &y2);
        ll res = inf;
        int ii = Find(x1, y1, x2, y2);
        For(i, ii, ii+1) if (i < x2) {
            ll x = get(x1, y1, i, y2);
            ll y = get(i+1, y1, x2, y2);
            res = min(res, abs(x - y));
        }

        int jj = Find2(x1, y1, x2, y2);
        For(j, jj, jj+1) if (j < y2) {
            ll x = get(x1, y1, x2, j);
            ll y = get(x1, j+1, x2, y2);
            res = min(res, abs(x-y));
        }

        printf("%lld\n", res);
    }
}

int main() {
    freopen("MINCUT.INP", "r", stdin);
    freopen("MINCUT.OUT", "w", stdout);
    scanf("%d%d%d", &m, &n, &k);
    For(i, 1, m) For(j, 1, n) {
        scanf("%d", &a[i][j]);
        s[i][j] = s[i-1][j] + s[i][j-1] - s[i-1][j-1] + a[i][j];
    }
    if (m <= 100 && n <= 100)
    sub1();
    else
    sub2();
}
