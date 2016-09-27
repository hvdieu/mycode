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

const int N = 60 + 5;
const int inf = 1e9;


int n, m, r, w[N][N][N], a[N][N], f[N][N][N];

void solve() {
    For(u, 1, n) For(v, 1, n) a[u][v] = inf;
    For(t, 1, m) For(k, 1, n) For(u, 1, n) For(v, 1, n)
        w[t][u][v] = min(w[t][u][v], w[t][u][k] + w[t][k][v]);
    For(u, 1, n) For(v, 1, n) For(t, 1, m) a[u][v] = min(a[u][v], w[t][u][v]);
    For(u, 1, n) For(v, 1, n) For(k, 0, n) f[u][v][k] = inf;
    For(u, 1, n) For(v, 1, n) f[u][v][0] = a[u][v];
    For(k, 0, n-1) For(u, 1, n) For(v, 1, n)
        For(vv, 1, n) f[u][vv][k+1] = min(f[u][vv][k+1], min(f[u][v][k] + a[v][vv], f[u][vv][k]));
}

int main() {
    ios_base::sync_with_stdio(false);
    //freopen("in.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> n >> m >> r;
    For(i, 1, m) For(u, 1, n) For(v, 1, n) cin >> w[i][u][v];
    solve();
    For(i, 1, r) {
        int s, t, l;
        cin >> s >> t >> l;
        if (l > n) l = n;
        cout << f[s][t][l] << "\n";
    }
}


