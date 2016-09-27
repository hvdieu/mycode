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
#define N 100001
#define inf 1000000000

int s[N], a[N], res, f[101][101], n, k, mm;

void sub1() {
    For(i, 0, n) For(j, 0, k) f[i][j] = inf;
    f[0][0] = 0;
    For(i, 1, n) For(j, 1, k) For(ii, 0, i-1)
    f[i][j] = min(f[i][j], max(f[ii][j-1], s[i] - s[ii]));
    cout << f[n][k];
}

bool check(int x) {
    int dem = 1, sum = 0;
    For(i, 1, n) {
        sum += a[i];
        if (sum > x) {
            dem++; sum = a[i];
        }
    }
    if (dem <= k) return true;
    return false;
}

void sub2() {
    int d = mm, c = s[n], mid, ans;
    while (d <= c) {
        mid = (d+c) / 2;
        if (check(mid)) {
            ans = mid; c = mid - 1;
        } else d = mid + 1;
    }
    cout << ans;
}

int main() {
    freopen("smin.in","r",stdin);
    freopen("smin.out","w",stdout);
    scanf("%d%d", &n, &k);
    For(i, 1, n) {
        scanf("%d", &a[i]);
        s[i] = s[i-1] + a[i];
        mm = max(mm, a[i]);
    }
    if (n <= 100) sub1(); else
    sub2();
}
