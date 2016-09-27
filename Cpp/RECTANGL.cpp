#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define x first
#define y second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 250010

int n, p, dem[N];
ii a[N];
ll res;
vector<ii> q;
vector<ii> line;
unordered_map<ii, int> ff;

inline bool cmp(ii a, ii b) { if (a.x != b.x) return a.x < b.x; return a.y < b.y; }

inline ll C2(int n) {
    return ll(n)*(n-1)/2;
}

inline void solve() {
    sort(a+1, a+n+1, cmp);
    For(i, 1, n) q.pb(ii(a[i].y, i));
    sort(all(q));
    int sl = 0;
    For(i, 0, sz(q)-1) {
        if (!i || q[i].x != q[i-1].x) sl++;
        a[q[i].y].y = sl;
    }
    int p = trunc(sqrt(n));
    int i = 1;
    while (i <= n) {
        int j = i; while (j < n && a[i].x == a[j+1].x) j++;
        line.pb(ii(i, j));
        i = j+1;
    }
    For(jj, 0, sz(line)-1) {
        int l = line[jj].x, r = line[jj].y;
        if (r-l+1 >= p) {
            For(i, l, r) dem[a[i].y]++;
            For(ii, 0, sz(line)-1) if (ii != jj) {
                if (ii > jj && line[ii].y - line[ii].x + 1 >= p) continue;
                int cnt = 0;
                For(i, line[ii].x, line[ii].y) if (dem[a[i].y]) cnt++;
                res += C2(cnt);
            }
            For(i, l, r) dem[a[i].y]--;
        } else {
            For(i, l, r) For(j, i+1, r) {
                res += ff[ii(a[i].y, a[j].y)];
            }
            For(i, l, r) For(j, i+1, r) ff[ii(a[i].y, a[j].y)]++;
        }
    }
    cout << res;
}

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("rectangl.inp","r",stdin);
    //freopen("rectangl.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d%d", &a[i].x, &a[i].y);
    solve();
}
