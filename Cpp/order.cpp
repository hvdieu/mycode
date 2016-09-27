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
#define N 2410
#define inf 1000000000

struct edge {
    int v, f, c, op;
    edge (int _v, int _f, int _c, int _op){
        v = _v; f = _f; c = _c; op = _op;
    }
};

int m, n, s, t, flow;
vector<edge> ke[N];
int inq[N], t1[N], t2[N], timer, q[N], lef, righ;

void connect(int u, int v, int x) {
    ke[u].pb(edge(v, 0, x, sz(ke[v])));
    ke[v].pb(edge(u, 0, 0, sz(ke[u])-1));
}

bool FindPath(int s, int t) {
    timer++; lef = righ = 0; q[++righ] = s; inq[s] = timer;
    while (lef < righ) {
        int u = q[++lef];
        For(j, 0, sz(ke[u])-1) {
            int v = ke[u][j].v, f = ke[u][j].f, c = ke[u][j].c;
            if (inq[v] != timer && f < c) {
                inq[v] = timer;
                q[++righ] = v; t1[v] = u; t2[v] = j;
                if (v == t) return true;
            }
        }
    }
    return false;
}

void IncFlow(int s, int t) {
    int v = t, delta = inf;
    while (v != s) {
        int u = t1[v], j = t2[v];
        delta = min(delta, ke[u][j].c - ke[u][j].f);
        v = u;
    }
    flow -= delta;
    v = t;
    while (v != s) {
        int u = t1[v], j = t2[v];
        ke[u][j].f += delta;
        ke[v][ke[u][j].op].f -= delta;
        v = u;
    }
}

int main() {
   // freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    scanf("%d%d", &n ,&m);
    s = 0; t = m+n+1;
    For(i, 1, n) {
        int x; scanf("%d", &x);
        flow += x;
        connect(0, i, x);
        int k, l, v; scanf("%d", &k);
        For(j, 1, k) {
            scanf("%d%d", &v, &l);
            connect(i, n+v, l);
        }
    }
    For(i, 1, m) {
        int x; scanf("%d", &x);
        connect(i+n, t, x);
    }
    while (FindPath(s, t)) IncFlow(s, t);
    cout << flow;
}
