#include <bits/stdc++.h>

using namespace std;

typedef long long ll;
typedef pair<double, int> ii;
typedef long double ld;

#define For(i, a, b) for(int i = a; i <= b; i++)
#define Rep(i, a, b) for(int i = a; i >= b; i--)
#define S first
#define c second
#define all(x) x.begin(), x.end()
#define reset(f, x) memset(f, x, sizeof(f))
#define bit(x, i) ((x >> i) & 1)
#define two(x) (1LL << x)
#define onbit(x, i) (x | (1LL << i))
#define N 1010

int m, k, n, x[N], y[N], ma, dem[N];
ii a[N];
ll s;
double res;

void solve() {
    res = 0;
    a[0].S = 0;
    sort(a+1, a+m+1);
    For(i, 1, m) {
        ma = 0;
        reset(dem, 0);
        Rep(j, i, 1) {
            dem[a[j].c]++;
            ma = max(ma, dem[a[j].c]);
            int len = (i - j + 1) - ma;
            if (len <= k) res = max(res, a[i].S - a[j-1].S);
        }
    }
    printf("%.1lf", res);
}

int main() {
    freopen("TFIELD.INP", "r", stdin);
    freopen("TFIELD.OUT", "w", stdout);
    scanf("%d%d", &m, &k);
    For(j, 1, m) {
        scanf("%d%d", &n, &a[j].c);
        For(i, 1, n) scanf("%d%d", &x[i], &y[i]);
        s = 0;
        x[n+1] = x[1]; y[n+1] = y[1];
        For(i, 1, n) s += (ll(x[i]) - x[i+1]) * (y[i] + y[i+1]);
        a[j].S = double(s) / 2;
        a[j].S = abs(a[j].S);
        //printf("%.1lf\n", a[j].S);
    }
    solve();
}
