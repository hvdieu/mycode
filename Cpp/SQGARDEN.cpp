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
#define N 100001
#define MAX 1000000

struct point {
    int x, y;
};

struct line {
    int l, r, x;
    line(int _l, int _r, int _x) {
        l = _l; r = _r; x = _x;
    }
};

bool cmp(point a, point b) {
    if (a.x != b.x) return a.x < b.x;
    return a.y < b.y;
}

int n, m, p;
point a[N];
int dd[2*MAX + 1][2];
int dai[2*MAX + 1];
vector<int> ff[2*MAX+1];
vector<line> q;
ll res = 0;

void solve() {
    p = trunc(sqrt(n));
    sort(a+1, a+n+1, cmp);
    int i = 1;
    while (i <= n) {
        int j = i;
        while (j < n && a[i].x == a[j+1].x) j++;
        q.pb(line(i, j, a[i].x));
        dai[a[i].x + MAX] = j - i + 1;
        For(ii, i, j) ff[a[ii].x + MAX].pb(a[ii].y);
        i = j + 1;
    }
    For(ii, 0, sz(q)-1) if (q[ii].r - q[ii].l + 1 >= p) {
        int l = q[ii].l, r = q[ii].r;
        For(i, l, r) dd[a[i].y + MAX][0]++;
        For(jj, 0, sz(q)-1) if (ii != jj) {
            if (q[jj].r - q[jj].l + 1 >= p && jj > ii) continue;
            int len = abs(q[ii].x - q[jj].x);
            For(i, q[jj].l, q[jj].r) {
                if (a[i].y - len >= -MAX && dd[a[i].y - len + MAX][1] && dd[a[i].y + MAX][0] && dd[a[i].y - len + MAX][0]) res++;
                dd[a[i].y + MAX][1]++;
            }
            For(i, q[jj].l, q[jj].r) dd[a[i].y + MAX][1]--;
        }
        For(i, l, r) dd[a[i].y + MAX][0]--;
    } else {
        int l = q[ii].l, r = q[ii].r;
        For(i, l, r) For(j, i+1, r) {
            int len = abs(a[i].y - a[j].y);
            if (a[i].x - len >= -MAX && dai[a[i].x - len + MAX] < p && binary_search(all(ff[a[i].x - len + MAX]), a[i].y) && binary_search(all(ff[a[i].x - len + MAX]), a[j].y)) res++;
        }
    }
    cout << res;
}

int main() {
    //ios_base::sync_with_stdio(false);
   // freopen("sqgarden.inp","r",stdin);
   // freopen("sqgarden.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d%d", &a[i].x, &a[i].y);
    solve();
}
