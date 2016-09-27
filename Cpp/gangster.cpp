#include <iostream>
#include <stdio.h>
#include <algorithm>
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
#define all(x) x.begin(), x.end()
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 110
#define T 30010
#define K 110
#define inf 1000000000
struct gang {
    int t, p, s;
};

int n, k, t, f[2][K], tt;
gang a[N];

bool cmp(gang a, gang b) {
    return a.t != b.t ? a.t < b.t : a.s < b.s;
}

void solve() {
    sort(a+1, a+n+1, cmp);
    For(i, 0, 1) For(j, 0, k) f[i][j] = -inf;
    f[0][0] = 0;
    int j = 1;
    while (j <= n && a[j].t == 0) {
        if (a[j].s == 0) f[0][0] += a[j].p;
        j++;
    }
    int tt = 0;
    For(i, 1, t) {
        tt = 1 - tt;
        For(stt, 0, k) {
            f[tt][stt] = -inf;
            int cp = 0;
            while (j <= n && a[j].t == i && a[j].s == stt) {
                cp += a[j].p;
                j++;
            }
            For(x, -1, 1) if (stt+x >= 0 && stt+x <= k) f[tt][stt] = max(f[tt][stt], f[1-tt][stt+x]+cp);
        }
    }
    int res = 0;
    For(stt, 0, k) res = max(res, f[tt][stt]);
    cout << res;
}

int main() {
    //freopen("gangster.inp","r",stdin);
   // freopen("output.txt","w",stdout);
    scanf("%d%d%d", &n, &k, &t);
    For(i, 1, n) scanf("%d", &a[i].t);
    For(i, 1, n) scanf("%d", &a[i].p);
    For(i, 1, n) scanf("%d", &a[i].s);
    solve();
}
