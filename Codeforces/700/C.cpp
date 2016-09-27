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

const int N = 1000 + 5;

vector<ii> ke[N];
vector<ii> op[N];
vector<int> vt[N];
int n, m, s, t, low[N], num[N], timer, cha[N], trace[N];
ii id[N], ban, id2[N];
int low2[N], num2[N], cha2[N];
int res3, res1, res2;

void dfs(int u) {
    num[u] = ++timer; low[u] = num[u];
    REP(j, sz(ke[u])) {
        int v = ke[u][j].fi, w = ke[u][j].se;
        if (!cha[v]) {
            cha[v] = u;
            id[v] = ii(u, j);
            dfs(v);
            low[u] = min(low[u], low[v]);
        } else if (op[u][j].fi != id[u].fi || op[u][j].se != id[u].se) low[u] = min(low[u], num[v]);
    }
}

void dfs2(int u) {
    low2[u] = ++timer; num2[u] = low2[u];
    REP(j, sz(ke[u])) if (ii(u, j) != ban && op[u][j] != ban){
        int v = ke[u][j].fi, w = ke[u][j].se;
        if (!cha2[v]) {
            cha2[v] = u;
            id2[v] = ii(u, j);
            dfs2(v);
            low2[u] = min(low2[u], low2[v]);
        } else if (op[u][j].fi != id2[u].fi || op[u][j].se != id2[u].se) low2[u] = min(low2[u], num2[v]);
    }
}

int main() {
    //freopen("in.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> n >> m;
    cin >> s >> t;
    For(i, 1, m) {
        int u, v, w;
        cin >> u >> v >> w;
        ke[u].pb(ii(v, w));
        ke[v].pb(ii(u, w));
        vt[u].pb(i);
        vt[v].pb(i);
        op[u].pb(ii(v, sz(ke[v])-1));
        op[v].pb(ii(u, sz(ke[u])-1));
    }
    cha[s] = s;
    dfs(s);
    int ans = 2e9 + 1;
    if (!cha[t]) cout << 0 << "\n" << 0;
    else {
        int v = t;
        while (v != s) {
            int u = cha[v];
           // cout << "first: " << u << ' ' << v << "\n";
            int ans1 = ke[id[v].fi][id[v].se].se;
            if (low[v] >= num[v]) {
                if (ans > ans1) {
                    ans = ans1;
                    res3 = 1;
                    res1 = vt[id[v].fi][id[v].se];
                }
            }
            else {
                ban = id[v];
                //cout << "ban: " << ban.fi << ' ' << ban.se << "\n";
                timer = 0;
                reset(cha2, 0);
                cha2[s] = s;
                dfs2(s);
               // For(i, 1, n) cout << num2[i] << ' '; cout << "\n";
              //  For(i, 1, n) cout << low2[i] << ' ' ; cout << "\n";
                int vv = t;
                while (vv != s) {
                    int uu = cha2[vv];
                    int ans2 = ke[id2[vv].fi][id2[vv].se].se;
                    //cout << "second: " << uu << ' ' << vv << "\n";
                   // cout << low2[vv] << ' ' << num2[vv] << "\n";
                    if (low2[vv] >= num2[vv] && ans > ans1 + ans2) {
                        ans = ans1 + ans2;
                        res3 = 2;
                        res1 = vt[id[v].fi][id[v].se]; res2 = vt[id2[vv].fi][id2[vv].se];
                    }
                    vv = uu;
                }
            }
            v = u;
        }
        if (ans > 2e9) cout << -1;
        else {
            cout << ans << "\n" << res3 << "\n" << res1;
            if (res3 == 2) cout << ' ' << res2;
        }
    }
}


