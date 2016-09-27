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
#define N 100010

int n, m, k, ntest, a[N], dem, lab[N];
vector<int> ke[N];
vector<int> ke2[N];
vector<int> scc[N];
int low[N], num[N], timer, id[N];
int st[N], top, dem2;
bool fr[N], must[N], must2[N];
int nex[N];
bool can, path[N];

void dfs(int u) {
    num[u] = low[u] = ++timer;
    st[++top] = u;
    FOR(v, ke[u]) if (fr[*v])
        if (!num[*v]) {
            dfs(*v);
            low[u] = min(low[u], low[*v]);
        } else low[u] = min(low[u], num[*v]);
    if (low[u] == num[u]) {
        dem++;
        int v;
        do {
        	v = st[top];
        	lab[v] = dem; scc[dem].pb(v); top--;
        	fr[v] = false;
		} while (u != v);
    }
}

void topo(int u) {
    fr[u] = false;
    FOR(v, ke2[u]) if (fr[*v]) topo(*v);
    st[top] = u; id[u] = top--;
}

bool cmp(int i, int j) {
    return id[i] < id[j];
}

void visit(int u, int cnt) {
    fr[u] = false;
    if (cnt == dem2) can = true;
    FOR(v, ke2[u]) if (fr[*v])
        if (must2[*v]) visit(*v, cnt+1);
        else visit(*v, cnt);
}

void solve() {
    timer = 0; dem = 0;
    reset(num, 0);
    reset(fr, true);
    For(i, 1, n) if (fr[i]) {
        top = 0;
        dfs(i);
    }
    reset(must2, false);
    dem2 = 0;
    For(i, 1, dem) ke2[i].clear();
    For(i, 1, n) {
        if (must[i]) must2[lab[i]] = true;
        FOR(j, ke[i]) {
            int u = lab[i], v = lab[*j];
            if (u != v) ke2[u].pb(v);
        }
    }
    For(i, 1, dem) if (must2[i]) dem2++;
    top = dem; reset(fr, true);
    For(i, 1, dem) sort(all(scc[i]));
    For(i, 1, dem) if (fr[i]) topo(i);
    For(i, 1, dem) sort(all(ke2[i]), cmp);
    reset(fr, true);
    int last = 0;
    For(i, 1, dem) if (must2[st[i]]) {
        nex[last] = i; last = i;
    }
    reset(path, false);
    For(i, 1, dem) if (must2[st[i]]) {
        path[i] = true; last = nex[i]; break;
    }
    can = true;
    For(i, 1, dem) {
        if (must2[st[i]]) {
            if (!path[i]) {
                can = false; break;
            }
            last = nex[i];
        }
        int u = st[i];
        if (path[i]) FOR(v, ke2[u]) if (id[*v] <= last) path[id[*v]] = true;
    }
    if (!can) cout << -1;
    else {
        For(i, 1, dem) if (must2[st[i]]) {
            FOR(u, scc[st[i]]) if (must[*u]) printf("%d ", *u);
        }
    }
    cout << endl;
    //For(i, 1, n) cout << lab[i] << ' '; cout << endl;
    //For(i, 1, dem) cout << st[i] << ' '; cout << endl;
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d%d%d", &n, &m, &k);
        For(i, 1, n) ke[i].clear(), scc[i].clear();
        reset(must, false);
        For(i, 1, k) {
            int u; scanf("%d", &u); must[u] = true;
        }
        For(i, 1, m) {
            int u, v; scanf("%d%d", &u, &v);
            ke[u].pb(v);
        }
        solve();
    }
}


