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
#define onbit(x, i) (x | (1LL << (i-1)))
#define N 30010

int n, a[N][12];
ll f[1 << 12];

void gen(int i, int j, ll s, int tt) {
    if (j > 11) {
        f[tt] = max(f[tt], s);
        return;
    }
    gen(i, j+1, s, tt);
    gen(i, j+1, s + a[i][j], onbit(tt, j));
}

int main() {
   // freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &n);
    ll res = 0;
    For(i, 1, n) For(j, 1, 11) scanf("%d", &a[i][j]);
    For(i, 1, n) gen(i, 1, 0, 0);
    int T = (1 << 11) - 1;
    ///cout << T << endl;
    int r1, r2, r3;
    For(t1, 0, T) For(t2, 0, T) if ((t1 & t2) == 0) {
        int t3 = T & (~(t1 | t2));
        if (f[t1] + f[t2] + f[t3] > res) {
            res = f[t1] + f[t2] + f[t3];
            r1 = t1; r2 = t2; r3 = t3;
        }
    }
   // cout << r1 << ' ' << r2 << ' ' << r3 << endl;
   // cout << f[r1] << ' ' << f[r2] << ' ' << f[r3] << endl;
    cout << res;
}
