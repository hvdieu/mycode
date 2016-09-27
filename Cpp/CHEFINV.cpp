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
#define N 200010

int n, q, a[N], t[20][N], b[N];
ll res;

void init(int tt, int l, int r) {
    if (l == r) {
        t[tt][l] = a[l]; return;
    }
    int mid = (l + r) / 2;
    init(tt + 1, l, mid);
    init(tt + 1, mid+1, r);
    int i = l, j = mid + 1, k = 0;
    while (1) {
        if (i > mid && j > r) break;
        if (i > mid || (i <= mid && j <= r && t[tt+1][j] < t[tt+1][i])) {
            b[++k] = t[tt+1][j]; j++;
        } else {
            b[++k] = t[tt+1][i]; i++;
            res += j - mid - 1;
        }
    }
    For(i, l, r) t[tt][i] = b[i-l+1];
}

int Query(int tt, int l, int r, int u, int v, int x) {
    int res = 0;
    if (u > v) return 0;
    if (l == u && r == v) {
        int d = l, c = r, mid, ans = l-1;
        while (d <= c) {
            mid = (d + c) / 2;
            if (t[tt][mid] < x) {
                ans = mid; d = mid + 1;
            } else c = mid - 1;
        }
        return ans - l + 1;
    }
    int mid = (l + r) / 2;
    if (u <= mid) res += Query(tt+1, l, mid, u, min(mid, v), x);
    if (v > mid) res += Query(tt+1, mid+1, r, max(u, mid+1), v, x);
    return res;
}

int Query2(int tt, int l, int r, int u, int v, int x) {
    int res = 0;
    if (u > v) return 0;
    if (l == u && r == v) {
        int d = l, c = r, mid, ans = l-1;
        while (d <= c) {
            mid = (d + c) / 2;
            if (t[tt][mid] <= x) {
                ans = mid; d = mid + 1;
            } else c = mid - 1;
        }
        return ans - l + 1;
    }
    int mid = (l + r) / 2;
    if (u <= mid) res += Query2(tt+1, l, mid, u, min(mid, v), x);
    if (v > mid) res += Query2(tt+1, mid+1, r, max(u, mid+1), v, x);
    return res;
}

int main() {
    freopen("chefinv.inp","r",stdin);
    freopen("chefinv.out","w",stdout);
    scanf("%d%d", &n, &q);
    For(i, 1, n) scanf("%d", &a[i]);
    init(1, 1, n);
    while (q) {
        q--; int u, v;
        scanf("%d %d", &u, &v);
        if (u > v) swap(u, v);
        if (u == v) printf("%lld\n", res);
        else {
            int len = v - u - 1;
            int x = Query(1, 1, n, u+1, v-1, a[u]);
            int y = Query(1, 1, n, u+1, v-1, a[v]);
            int x1 = len - Query2(1, 1, n, u+1, v-1, a[u]);
            int y1 = len - Query2(1, 1, n, u+1, v-1, a[v]);
            ll kq = res - x + x1 + y - y1;
            if (a[u] < a[v]) kq++;
            if (a[u] > a[v]) kq--;
            printf("%lld\n", kq);
        }
    }
}
