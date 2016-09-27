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
#define inf 1000000000
#define N 101

int n, E, f[N][N];
int a[N];
vector<int> b[N][N], s[N][N];

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d", &n, &E);
    For(i, 1, n) scanf("%d", a+i);
    For(i, 0, n) For(j, 0, n) f[i][j] = inf;
    f[0][0] = 0;
    For(i, 1, n) For(j, i, n) {
        b[i][j] = b[i][j-1]; b[i][j].pb(2*a[j]);
        sort(all(b[i][j]));
        s[i][j].pb(b[i][j][0]);
        For(k, 1, sz(b[i][j])-1) s[i][j].pb(s[i][j].back() + b[i][j][k]);
    }
    int res = inf, sl = n+1;
    For(i, 1, n) {
        f[i][1] = 0;
        For(j, 1, i-1) f[i][1] += 2 * abs(a[j] - a[i]);
        int x = f[i][1];
        For(j, i+1, n) x += 2 * abs(a[j] - a[i]);
        if (x <= E && sl > 1) {
            sl = 1; res = x;
        } else if (sl == 1 && x < res) res = x;
    }
    For(i, 2, n) For(k, 2, i) {
    For(j, k-1, i-1) {
        int x = a[i] + a[j], u, cp;
        if (j+1 == i) cp = 0;
        else {
            auto it = upper_bound(all(b[j+1][i-1]), x);
            if (it == b[j+1][i-1].begin()) u = -1;
            else u = it - b[j+1][i-1].begin(), u--;
            int l, r;
            if (u == -1) l = 0; else l = s[j+1][i-1][u];
            r = s[j+1][i-1].back() - l; u++;
            cp = u * x - l + r - (i - j - 1 - u) * x;
        }
        f[i][k] = min(f[i][k], f[j][k-1] + cp);
    }
        int x = f[i][k];
        For(j, i+1, n) x += 2 * abs(a[j] - a[i]);
        if (x <= E && sl > k) {
            sl = k; res = x;
        } else if (x <= E && sl == k && x <= res) res = x;
    }
    cout << sl << ' ' << res;
}
