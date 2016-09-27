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
#define N 50001

int n, a[N], b[N], m, f[N][20], vmax, s[N], res, u, v;

int gcd(int a, int b) {
    if (b == 0) return a;
    return gcd(b, a % b);
}

int get(int i, int j) {
    int k = trunc(log(j-i+1) / log(2));
    return gcd(f[i][k], f[j - (1 << k) + 1][k]);
}

void solve() {
    n = m; vmax = trunc(log(n-1) / log(2));
    For(i, 1, n - 1) b[i] = abs(a[i] - a[i+1]);
    For(i, 1, n - 1) f[i][0] = b[i];
    For(j, 1, vmax) For(i, 1, n - (1 << j)) f[i][j] = gcd(f[i][j-1], f[i + (1 << (j-1))][j-1]);
    For(i, 2, n - 1) {
        int d = 1, c = i, mid, ans = -1;
        while (d <= c) {
            mid = (d + c) / 2;
            if (get(i - mid + 1, i) != 1) {
                ans = mid; d = mid + 1;
            } else c = mid - 1;
        }
        if (ans != -1) {
            int len = s[i+1] - s[i-ans];
            if (len > res) {
                res = len; u = s[i-ans]+1; v = s[i+1];
            }
        }
    }
    cout << u << ' ' << v;
}

int main() {
    freopen("capso.inp","r",stdin);
    freopen("capso.out","w",stdout);
    scanf("%d", &n);
    int last = 0;
    For(i, 1, n) {
        int x;
        scanf("%d", &x);
        if (x == last) s[m]++;
        else {
            a[++m] = x; s[m] = s[m-1] + 1;
            last = x;
        }
    }
    solve();
}
