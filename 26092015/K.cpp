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
#define getbit(x, i) ((x >> (i-1)) & 1LL)
#define onbit(x, i) (x | (1LL << (i-1)))
#define offbit(x, i) (x & ~(1 << (i-1)))
#define N 10010

int n, t;
vector<int> a[N];
vector<int> b;
vector<ii> q;
int dd[N];
vector<int> backup;

void solve() {
    sort(all(q));
    int i = 0;
    int res = 0;
    q.pb(ii(1000000001, n+1));
    while (i < sz(q)) {
        int j = i;
        while (j < sz(q) && q[i].fi == q[j].fi) {
            dd[q[j].se] = 1;
            j++;
        }
        int dem = 0;
        For(k, j, sz(q) - 1) if (q[k].fi == q[k-1].fi) {
            if (dd[q[k].se]) {
                dem++;
                dd[q[k].se] = 0;
                backup.pb(q[k].se);
            }
        } else {
            if (dem >= t) res++;
            dem = 0;
            REP(jj, sz(backup)) dd[backup[jj]] = 1;
            backup.clear();
            if (dd[q[k].se]) {
                dem++;
                dd[q[k].se] = 0;
                backup.pb(q[k].se);
            }
        }
        For(k, i, j-1) dd[q[k].se] = 0;
        i = j;

    }
    cout << res;
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d", &n, &t);
    For(i, 1, n) {
        int m; scanf("%d", &m);
        For(j, 1, m) {
            int x; scanf("%d", &x);
            q.pb(ii(x, i));
        }
    }
    solve();
}


