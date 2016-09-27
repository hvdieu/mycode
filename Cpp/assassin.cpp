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
#define N 1010

int n, ntest, low[N], num[N], lab[N], timer, mx[N], my[N], m;
bool fr[N];
int st[N], top, cnt;
vector<int> ke[N], ke2[N];
int dd[N][N], dem;
int was[N], time2;

void init() {
    timer = 0; top = 0;
    cnt = 0;
    For(i, 1, n) {
        ke[i].clear();
        fr[i] = true;
        num[i] = 0;
        lab[i] = 0;
    }
}

void dfs(int u) {
    num[u] = ++timer; low[u] = num[u];
    st[++top] = u;
    FOR(v, ke[u]) if (fr[*v]) {
        if (!num[*v]) {
            dfs(*v);
            low[u] = min(low[u], low[*v]);
        } else low[u] = min(low[u], num[*v]);
    }
    if (low[u] == num[u]) {
        int v; cnt++;
        do {
            v = st[top--]; lab[v] = cnt; fr[v] = false;
        } while (v != u);
    }
}

void visit(int u) {
    was[u] = time2;
    int s = sz(ke2[u]) - 1;
    For(j, 0, s) {
        int v = ke2[u][j];
        if (was[v] != time2) visit(v);
        FOR(vv, ke2[v]) if (dd[u][*vv] != dem) {
            dd[u][*vv] = dem;
            ke2[u].pb(*vv);
        }
    }
}

void build_graph() {
    dem++;
    For(i, 1, cnt) {
        ke2[i].clear();
        mx[i] = my[i] = 0;
    }
    For(i, 1, n) {
        int u = lab[i];
        FOR(j, ke[i]) {
            int v = lab[*j]; if (u != v && dd[u][v] != dem) {
                dd[u][v] = dem; ke2[u].pb(v);
            }
        }
    }
    time2++;
    For(i, 1, n) if (was[i] != time2) visit(i);
}

bool Find(int u) {
    if (was[u] == time2) return false;
    was[u] = time2;
    FOR(v, ke2[u]) if (!my[*v] || Find(my[*v])) {
        mx[u] = *v; my[*v] = u;
        return true;
    }
    return false;
}

void solve() {
    For(i, 1, n) if (!num[i]) dfs(i);
    build_graph();
    int res = 0;
    For(i, 1, cnt) if (!mx[i]) {
        FOR(j, ke2[i]) {
            time2++;
            if (!my[*j] || Find(my[*j])) {
                mx[i] = *j; my[*j] = i; res++;
                break;
            }
        }
    }
    //For(i, 1, n) cout << mx[i] << ' '; cout << endl;
    printf("%d\n", cnt - res);
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        printf("Case %d: ", test);
        scanf("%d%d", &n, &m);
        init();
        For(i, 1, m) {
            int u, v;
            scanf("%d%d", &u, &v);
            ke[u].pb(v);
        }
        solve();
    }
}
