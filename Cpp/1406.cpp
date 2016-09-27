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
#define bit(x, i) ((x >> (i-1)) & 1LL)
#define onbit(x, i) (x | (1LL << (i-1)))
#define offbit(x, i) (x & ~(1 << (i-1)))
#define N 16

int n, m, ntest, res;
vector<int> ke[N];
int f[N][1 << N];

void solve() {
    reset(f, 0x7f);
    f[0][0] = 0;
    res = N;
    int T = (1 << n) - 1;
    For(tt, 0, T) For(u, 0, n) if (!u || bit(tt, u)) {
        FOR(v, ke[u]) if (!bit(tt, *v)) {
            int newtt = onbit(tt, *v);
            f[*v][newtt] = min(f[*v][newtt], f[u][tt]);
        }
        For(v, 1, n) if (!bit(tt, v)) {
            int newtt = onbit(tt, v);
            f[v][newtt] = min(f[v][newtt], f[u][tt] + 1);
        }
    }
    For(u, 1, n) res = min(res, f[u][T]);
}

int main() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d%d", &n, &m);
        For(i, 1, n) ke[i].clear();
        For(i, 1, m) {
            int u, v; scanf("%d%d", &u, &v);
            ke[u].pb(v);
        }
        solve();
        printf("Case %d: %d\n", test, res);
    }
}


