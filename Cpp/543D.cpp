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
#define N 200010
#define BASE 1000000007

int n, cha[N], f[N], kq[N], g[N];
vector<int> ke[N];
int st[N], top, truoc[N], sau[N];

void add(int &a, int b) {
    a += b; if (a >= BASE) a -= BASE;
}

void dfs(int u) {
    f[u] = 1;
    FOR(v, ke[u]) if (!cha[*v]) {
        cha[*v] = u;
        dfs(*v);
        f[u] = (ll(f[u]) * (f[*v] + 1)) % BASE;
    }
}

int poww(int a, int n) {
    int res = 1;
    if (a >= BASE) a -= BASE;
    while (n) {
        if (n & 1) res = (ll(res) * a) % BASE;
        n >>= 1;
        a = (ll(a) * a) % BASE;
    }
    return res;
}

void visit(int u) {
   // cout << u << endl;
    kq[u] = (ll(g[u] + 1) * f[u]) % BASE;
    top = 0;
    truoc[0] = 1;
    FOR(v, ke[u]) if (cha[*v] == u) {
        g[*v] = (g[u] + 1) % BASE;
        st[++top] = *v;
        truoc[top] = (ll(truoc[top-1]) * (f[*v] + 1)) % BASE;
    }
    sau[top+1] = 1;
  //  cout << u << endl;
    Rep(i, top, 1) {
        int v = st[i];
        sau[i] = (ll(sau[i+1]) * (f[v] + 1)) % BASE;
        g[v] = (ll(g[v]) * ((ll(truoc[i-1]) * sau[i+1]) % BASE)) % BASE;
    }
    FOR(v, ke[u]) if (cha[*v] == u) visit(*v);
   // For(i, 1, top) cout << truoc[i] << ' ' << sau[i] << endl;
}

void trau() {
    For(i, 1, n) {
        reset(cha, 0);
        reset(f, 0);
        cha[i] = i;
        dfs(i);
        cout << f[i] << ' ';
    }
    cout << endl;
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &n);
    For(u, 2, n) {
        int v; scanf("%d", &v);
        ke[u].pb(v); ke[v].pb(u);
    }
    //trau();
    reset(cha, 0); reset(f, 0);
    cha[1] = 1;
    g[1] = 0;
    dfs(1);
    visit(1);
    //kq[1] = f[1];
   // cout << f[2] << endl;
    For(i, 1, n) printf("%d ", kq[i]);
}

