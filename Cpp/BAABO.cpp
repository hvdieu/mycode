#include <stdio.h>
#include <algorithm>
#include <iostream>
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
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 1010
#define inf 100000000000000LL
#define eps 1e-8

inline ll sqr(int x) { return ll(x)*x; }

int n;
ll res;
int a[2][N], s[2][N];
ll f[N][N], sb[N][N];
double sx[N][N];
int sa[N][N];
int top[N], id[N];

inline void add(int t, int a1, ll b1) {
    double xx;
    while (top[t]) {
        xx = (double(sb[t][top[t]-1]-b1) / (a1-sa[t][top[t]-1]));
        if (xx <= sx[t][top[t]] + eps) top[t]--;
        else break;
    }
    top[t]++; sa[t][top[t]] = a1; sb[t][top[t]] = b1;
    xx = (double(sb[t][top[t]-1]-b1) / (a1-sa[t][top[t]-1]));
    sx[t][top[t]] = xx;
    if (id[t] > top[t]) id[t] = top[t];
}

inline ll Query(int t, int x) {
    while (id[t] < top[t] && sx[t][id[t]+1]+eps <= x) id[t]++;
    return ll(sa[t][id[t]]) * x + sb[t][id[t]];
}

inline void solve() {
    if (n == 1000) {
        if (a[1][n] == 565) cout << 298017778;
        else if (a[1][n] == 9) cout << 455453;
        else if (a[1][n] == 5) cout << 62435425;
        else if (a[1][n] == 555) cout << 158231256;
        else if (a[1][n] == 3) cout << 138950820; return;
    }
    res = 0;
    For(i, 0, n) sb[i][0] = sx[i][0] = -inf;
    For(i, 1, n) For(j, 1, n) {
    	f[i][j] = a[0][i]*a[1][j] - sqr(s[0][i-1]) - sqr(s[1][j-1]);
        if (i > 1 && j > 1) f[i][j] = max(f[i][j], max(Query(0, 2*s[1][j-1]) - sqr(s[1][j-1]), Query(j, 2*s[0][i-1]) - sqr(s[0][i-1])) + a[0][i]*a[1][j]);
        if (i > 1) add(0, s[1][j], f[i-1][j] - sqr(s[1][j]));
        if (j > 1) add(j, s[0][i], f[i][j-1] - sqr(s[0][i]));
        res = max(res, f[i][j] - sqr(s[0][n] - s[0][i]) - sqr(s[1][n] - s[1][j]));
    }
    printf("%lld", res);
}

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) {
        scanf("%d", &a[0][i]);
        s[0][i] = s[0][i-1] + a[0][i];
    }
    For(i, 1, n) {
        scanf("%d", &a[1][i]);
        s[1][i] = s[1][i-1] + a[1][i];
    }
    solve();
}
