#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 100010
#define LOG 20

int n, f[N][LOG], m, u, v, vmax;

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d", &f[i][0]);
    vmax = trunc(log(n) / log(2));
    For(j, 1, vmax) For(i, 1, n - two(j) + 1)
    f[i][j] = max(f[i][j-1], f[i + two(j-1)][j-1]);
    scanf("%d%d%d", &m, &u, &v);
    unsigned long long res = 0;
    For(test, 1, m) {
        int i = min(u, v) + 1, j = max(u, v) + 1;
        //cout << i << ' ' << j << ' ';
        int k = trunc(log(j-i+1) / log(2));
        res += max(f[i][k], f[j - two(k) + 1][k]);
        //cout << res << endl;
        u += 7; while (u >= n-1) u -= n-1;
        v += 11; while (v >= n) v -= n;
    }
    cout << res;
}
