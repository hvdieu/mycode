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
#define rI(x) scanf("%d", &x)
#define rII(x, y) scanf("%d%d", &x, &y)
#define rS(s) scanf("%s\n", s+1)
#define rL(x) scanf("%lld", &x)
#define rLL(x, y) scanf("%lld %lld", &x, &y)
#define BUG(x) cout << #x << ' = ' << x << "\n"

const int N = 50 + 5;
const int maxN = N*N;
const int inf = 1e9;

struct edge {
    int v, f, c, w, op;
    edge(int _v, int _f, int _c, int _w, int _op) {
        v = _v; f = _f; c = _c; w = _w; op = _op;
    }
};

int n, k, s, t, nn, ans;
char a[N][N];
int nodeH[N][N], nodeV[N][N];
int t1[maxN], t2[maxN], d[maxN];
vector<edge> ke[maxN];
bool fr[maxN];
queue<int> Q;

void addEdge(int u, int v, int c, int w) {
    ke[u].pb(edge(v, 0, c, w, sz(ke[v])));
    ke[v].pb(edge(u, 0, 0, -w, sz(ke[u])-1));
}

void initHorizontal(int i) {
    For(j, 1, n) {
        if (a[i][j] == '.') {
            int u = ++nn;
            nodeH[i][j] = u;
            int jj = j;
            while (jj < n && a[i][jj+1] == '.') nodeH[i][++jj] = u;
            REP(x, jj-j+1) addEdge(s, u, 1, x);
            j = jj;
        }
    }
}

void initVertical(int j) {
    For(i, 1, n) {
        if (a[i][j] == '.') {
            int v = ++nn;
            nodeV[i][j] = v;
            int ii = i;
            while (ii < n && a[ii+1][j] == '.') nodeV[++ii][j] = v;
            REP(x, ii-i+1) addEdge(v, t, 1, x);
            i = ii;
        }
    }
}

void initGraph() {
    s = 0; t = n*n + 1;
    nn = 0;
    For(i, 1, n) initHorizontal(i);
    For(j, 1, n) initVertical(j);
    For(i, 1, n) For(j, 1, n)
        if (a[i][j] == '.') addEdge(nodeH[i][j], nodeV[i][j], 1, 0);
}

bool findPath(int s, int t) {
    For(i, 0, nn) {
        fr[i] = true;
        d[i] = inf;
    }
    d[t] = inf; fr[t] = true;

    while (!Q.empty()) Q.pop();
    fr[s] = false; d[s] = 0; Q.push(s);
    while (!Q.empty()) {
        int u = Q.front(); Q.pop();
        fr[u] = true;
        REP(j, sz(ke[u])) {
            int v = ke[u][j].v, f = ke[u][j].f, w = ke[u][j].w, c = ke[u][j].c, op = ke[u][j].op;
            if (f < c) {
                if (d[v] > d[u] + w) {
                    d[v] = d[u] + w;
                    t1[v] = u;
                    t2[v] = j;
                    if (fr[v]) {
                        fr[v] = false;
                        Q.push(v);
                    }
                }
            }
        }
    }
    return d[t] < inf;
}

void incFlow(int s, int t) {
   // cout << d[t] << "\n";
    int v = t, temp = inf;
    while (v != s) {
        int u = t1[v], j = t2[v];
        temp = min(temp, ke[u][j].c - ke[u][j].f);
        v = u;
    }
    temp = min(temp, k);
    k -= temp;
    v = t;
    while (v != s) {
        int u = t1[v], j = t2[v];
        ke[u][j].f += temp; ke[v][ke[u][j].op].f -= temp;
        ans += ke[u][j].w;
        v = u;
    }
}

int main() {
   // freopen("in.txt","r",stdin);
    rII(n, k);
    //BUG(n); BUG(k);
    For(i, 1, n) rS(a[i]);
    initGraph();
    //BUG(nn);
    while (k && findPath(s, t)) {
        //cout << k << "\n";
        incFlow(s, t);
        //cout << ans << "\n";
    }
    //For(u, 0, nn) REP(j, sz(ke[u])) if (ke[u][j].f > 0) ans += ke[u][j].f * ke[u][j].w;
    printf("%d\n", ans);
    /* For(i, 1, n) {
        For(j, 1, n) cout << nodeH[i][j] << ' '; cout << "\n";
    }
    For(i, 1, n) {
        For(j, 1, n) cout << nodeV[i][j] << ' '; cout << "\n";
    } */
}


