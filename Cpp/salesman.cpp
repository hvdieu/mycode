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
#define N 500010
#define MAX 500001
#define inf 1000000000

struct market {
    int time, pos, money;
};

bool cmp(market a, market b) {
    if (a.time != b.time) return a.time < b.time;
    return a.pos < b.pos;
}

int n, U, D, S;
market a[N];
int t[2][N];
int f[N], g[N][2];
int h[N][2];

void update(int tt, int i, int val) {
    for(i; i <= MAX; i += i & (-i)) t[tt][i] = max(t[tt][i], val);
}

int get(int tt, int i) {
    int s = -inf;
    for(i; i; i -= i & (-i)) s = max(t[tt][i], s);
    return s;
}

int main() {
  //  freopen("input.txt","r",stdin);
   // freopen("salesman.out","w",stdout);
    scanf("%d%d%d%d", &n, &U, &D, &S);
    For(i, 1, n) scanf("%d%d%d", &a[i].time, &a[i].pos, &a[i].money);
    ++n; a[n].time = MAX; a[n].pos = S; a[n].money = 0;
    sort(a+1, a+n+1, cmp);
    For(i, 1, MAX) t[0][i] = t[1][i] = f[i] = -inf;
    update(0, S, S * D);
    update(1, MAX - S + 1, -S * U);
    int l = 1;
    while (l <= n) {
        int r = l;
        while (r < n && a[r+1].time == a[l].time) r++;
        g[l][0] = a[l].money;
        For(i, l+1, r) g[i][0] = max(a[i].money, g[i-1][0] - (U + D) * (a[i].pos - a[i-1].pos) + a[i].money);
        g[r][1] = a[r].money;
        Rep(i, r-1, l) g[i][1] = max(a[i].money, g[i+1][1] - (U + D) * (a[i+1]. pos - a[i].pos) + a[i].money);
        For(i, l, r) {
            int x = a[i].pos;
            h[i][0] = max(get(0, x) - x*D, get(1, MAX - x + 1) + x*U) + a[i].money;
            h[i][1] = h[i][0];
            if (i > l) h[i][1] = max(h[i][0] + g[i][0] - a[i].money, h[i-1][1] - (a[i].pos - a[i-1].pos) * D + a[i].money);
            f[i] = max(h[i][0], h[i][1]);
        }
        Rep(i, r, l) {
            int x = a[i].pos;
            h[i][1] = h[i][0];
            if (i < r) h[i][1] = max(h[i][0] + g[i][1] - a[i].money, h[i+1][1] - (a[i+1].pos - a[i].pos) * U + a[i].money);
            f[i] = max(f[i], h[i][1]);
        }
        For(i, l, r) {
            int x = a[i].pos;
            update(0, x, f[i] + x * D);
            update(1, MAX - x + 1, f[i] - x * U);
        }
        l = r + 1;
    }
    cout << f[n];
}
