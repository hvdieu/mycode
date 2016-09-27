#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 110

int ntest, n, m, cha[2][N], con[2][N];
vector<int> ke[2][N];
vector<int> can[N];
bool dp[N][N];
int mx[N], my[N];

void dfs(int t, int u) {
    For(j, 0, sz(ke[t][u])-1) {
        int v = ke[t][u][j];
        if (!cha[t][v]) {
            con[t][u]++;
            cha[t][v] = u;
            dfs(t, v);
        }
    }
}

bool fr[N];

int Find(int i, int v) {
    if (!fr[v]) return 0;
    fr[v] = false;
    For(j1, 0, sz(ke[0][i])-1) {
        int u = ke[0][i][j1];
        if (cha[0][u] == i && dp[u][v] && (!mx[u] || Find(i, mx[u]))) {
            my[v] = u; mx[u] = v;
            return 1;
        }
    }
    return 0;
}

void visit(int t, int u) {
    For(j, 0, sz(ke[t][u])-1) {
        int v = ke[t][u][j];
        if (!cha[t][v]) {
            con[t][u]++;
            cha[t][v] = u;
            visit(t, v);
        }
    }
    int j = u;
    For(i, 1, n) if (con[0][i] >= con[1][j]) {
        int res = 0;
        reset(mx, 0); reset(my, 0);
        For(j2, 0, sz(ke[1][j])-1) {
            int vv = ke[1][j][j2];
            if (cha[1][vv] == j && !my[vv]) For(j1, 0, sz(ke[0][i])-1) {
                int uu = ke[0][i][j1];
                if (cha[0][uu] == i) if (dp[uu][vv]) {
                    reset(fr, true);
                    if (!mx[uu] || Find(i, mx[uu])) {
                        res++; my[vv] = uu; mx[uu] = vv;
                        break;
                    }
                }
            }
        }
        if (res == con[1][j]) dp[i][j] = true;
    }
}

void solve() {
    scanf("%d", &n);
    For(i, 1, n) { ke[0][i].clear(); ke[1][i].clear(); }
    For(i, 1, n-1) {
        int u, v; scanf("%d%d", &u, &v);
        ke[0][u].pb(v); ke[0][v].pb(u);
    }

    scanf("%d", &m);
    For(i, 1, m-1) {
        int u, v; scanf("%d%d", &u, &v);
        ke[1][u].pb(v); ke[1][v].pb(u);
    }

    reset(cha[0], 0); reset(con[0], 0);
    cha[0][1] = 1; dfs(0, 1);
    bool flag = false;
    For(root, 1, m) {
        reset(dp, false);
        reset(cha[1], 0); reset(con[1], 0);
        cha[1][root] = root;
        visit(1, root);
        For(i, 1, n) if (dp[i][root]) {
            printf("YES\n"); return;
        }
    }
    printf("NO\n");
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("input.txt","r",stdin);
    freopen("output.out","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
    	printf("Case #%d: ", test);
        solve();
    }
}


