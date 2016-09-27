#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define REP(i, n) for(int i = 0; i < n; i++)
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

int n, m, res;
int d[N], h[N];

int main() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d", &n, &m);
    For(i, 1, m) scanf("%d%d", d+i, h+i);
    bool flag = true;
    res = max(h[1] + d[1] - 1, h[m] + n - d[m]);
    For(i, 2, m) {
        res = max(res, h[i]);
        int x = d[i] - d[i-1];
        if (abs(h[i] - h[i-1]) > x) flag = false;
        res = max(res, max(h[i], h[i-1]) + (x - abs(h[i] - h[i-1]))/2);
    }
    if (!flag) cout << "IMPOSSIBLE";
    else cout << res;
}
