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
#define N 100010
#define inf 1000000000000000000LL

struct edge {
    int v, l, time;
    edge(int a, int b, int c) {
        v = a; l = b; time = c;
    }
};

int n, m;
ll d[N];
bool inq[N];
vector<edge> ke[2][N];
queue<int> q;

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("airline.inp","r",stdin);
    freopen("airline.out","w",stdout);
    scanf("%d%d", &n, &m);
    For(i, 1, m) {
        int u, v, l, kind;
        scanf("%d%d%d%d", &kind, &u, &v, &l);
        if (kind == 1) ke[0][u].pb(edge(v, l, i));
        else ke[1][v].pb(edge(u, l, i));
    }
    For(i, 1, n) d[i] = inf; d[1] = 0;
    q.push(1); inq[1] = true;
    while (!q.empty()) {
        int u = q.front(); q.pop(); inq[u] = false;
        FOR(it, ke[0][u]) {
            int v = it->v, l = it->l;
            if (d[v] > d[u] + l) {
                d[v] = d[u] + l;
                if (!inq[v]) inq[v] = true, q.push(v);
            }
        }
        FOR(it, ke[1][u]) {
            int k = it->v, l = it->l;
            FOR(it2, ke[0][k]) if (it2->time < it->time) {
                int v = it2->v;
                if (d[v] > d[u] + l + it2->l) {
                    d[v] = d[u] + l + it2->l;
                    if (!inq[v]) inq[v] = true, q.push(v);
                }
            }
        }
    }
    For(i, 2, n) if (d[i] == inf) printf("%d\n", -1);
    else printf("%lld\n", d[i]);
}
