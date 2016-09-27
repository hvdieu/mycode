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
int dp[N][N];
int mx[N], my[N];

inline void dfs(int t, int u) {
    For(j, 0, sz(ke[t][u])-1) {
        int v = ke[t][u][j];
        if (!cha[t][v]) {
            con[t][u]++;
            cha[t][v] = u;
            dfs(t, v);
        }
    }
}

int q[N], lef, righ, trace[N];
int a[N][N];
int res;

inline void init(int i, int j) {
    reset(mx, 0); reset(my, 0);
    For(j1, 0, sz(ke[0][i])-1) {
        int u = ke[0][i][j1];
        if (cha[0][u] == i) {
            For(j2, 0, sz(ke[1][j])-1) {
                int v = ke[1][j][j2];
                if (cha[1][v] == j && dp[u][v] > 0 && !my[v]) {
                    mx[u] = v; my[v] = u;
                    break;
                }
            }
        }
    }
}

inline int FindPath(int i, int j) {
    reset(trace, 0); lef = righ = 0;
    For(j1, 0, sz(ke[0][i])-1) {
        int u = ke[0][i][j1];
        if (cha[0][u] == i && !mx[u]) q[++righ] = u;
    }
    while (lef < righ) {
        int u = q[++lef];
        For(j2, 0, sz(ke[1][j])-1) {
            int v = ke[1][j][j2];
            if (cha[1][v] == j && dp[u][v] > 0 && !trace[v]) {
                trace[v] = u;
                if (!my[v]) return v;
                q[++righ] = my[v];
            }
        }
    }
    return 0;
}

inline void IncFlow(int f) {
    int next, x;
    do {
        x = trace[f];
        next = mx[x];
        mx[x] = f;
        my[f] = x;
        f = next;
    } while (f);
}

inline void visit(int t, int u) {
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
        int res = 0, f;
        if (dp[i][j] < 0) {
            init(i, j);
            while (1) {
                f = FindPath(i, j);
                if (!f) break;
                IncFlow(f);
            }
            For(j2, 0, sz(ke[1][j])-1) {
                int v = ke[1][j][j2]; if (my[v]) res++;
            }
            if (con[1][j] == res) dp[i][j] = true;
        }
    }
}

inline void solve() {
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
    	reset(dp, -1);
        reset(cha[1], 0); reset(con[1], 0);
        cha[1][root] = root;
        visit(1, root);
        For(i, 1, n) if (dp[i][root] > 0) {
            printf("YES\n"); return;
        }
    }
    printf("NO\n");
}

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
    	printf("Case #%d: ", test);
        solve();
    }
}

