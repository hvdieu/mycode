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
#define bit(x, i) ((x >> (i-1)) & 1LL)
#define onbit(x, i) (x | (1LL << (i-1)))
#define N 100010
#define inf 1000000000

int n, m, b, a[N], know[N], base[N], lab[N], cnt;
int cp[N], tt[N];
int low[N], num[N], timer, st[N], top;
vector<int> ke[N], ke2[N];
bool was[N];
int f[5000];

void dfs(int u) {
    num[u] = ++timer;
    low[u] = num[u];
    st[++top] = u;
    FOR(v, ke[u]) if (!was[*v]) {
        if (!num[*v]) {
            dfs(*v);
            low[u] = min(low[u], low[*v]);
        } else low[u] = min(low[u], num[*v]);
    }
    if (num[u] == low[u]) {
        cnt++; int v;
        do {
            v = st[top--];
            was[v] = true; lab[v] = cnt;
        } while (v != u);
    }
}

bool fr[N];

void visit(int u) {
    fr[u] = true;
    FOR(v, ke2[u]) if (!fr[*v]) {
        visit(*v);
        tt[u] |= tt[*v];
    } else tt[u] |= tt[*v];
}

void build_new() {
    For(i, 1, cnt) cp[i] = inf;
    For(i, 1, n+m) {
        int u = lab[i];
        tt[u] |= know[i];
        cp[u] = min(cp[u], a[i]);
        FOR(v, ke[i]) if (lab[*v] != u) ke2[u].pb(lab[*v]);
    }
    For(i, 1, cnt)
	if (!fr[i])
    visit(i);
    For(stt, 0, two(b)-1) f[stt] = inf;
    For(i, 1, cnt) f[tt[i]] = min(f[tt[i]], cp[i]);
}

void solve() {
    For(i, 1, n+m) if (!num[i])
    dfs(i);
    //cout << cnt << endl;
    //For(i, 1, n+m) cout << lab[i] << ' '; cout << endl;
   // cout << sz(ke[3]) << endl;
   // cout << tt[1] << endl;
    build_new();
    //cout << sz(ke2[3]) << endl;
    int T = two(b)-1;
    For(tt1, 1, T) For(tt2, 1, tt1-1)
    if (f[tt1 | tt2] > f[tt1] + f[tt2]) f[tt1 | tt2] = f[tt1] + f[tt2];
    cout << f[T];
}

int main() {
    freopen("a007.inp","r",stdin);
    freopen("a007.out","w",stdout);
    scanf("%d%d%d", &b, &n, &m);
    int nn = 0;
    For(i, 1, b) {
        int k, u;
        scanf("%d", &k);
        For(j, 1, k) {
            know[++nn] = onbit(0, i);
            scanf("%d", &a[nn]);
        }
    }
    For(i, 1, m) {
        int k, u;
        scanf("%d%d", &a[n+i], &k);
        For(j, 1, k) {
            scanf("%d", &u);
            ke[n+i].pb(u);
        }
    }
    solve();
}
