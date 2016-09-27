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
#define reset(f,x) memset(f,x,sizeof(f))
#define all(x) x.begin(), x.end()
#define N 210
#define inf 1000000000

int res, n, m, l, t1[N], t2[N], flow, id[N], kq[N], top;
int q[N], lef, righ;
int fr[N], dem;
vector<int> ke[N], f[N], c[N], op[N];

void connect(int u, int v, int l) {
    ke[u].pb(v); ke[v].pb(u); f[u].pb(0); f[v].pb(0);
    c[u].pb(l); c[v].pb(0); op[u].pb(sz(ke[v])-1); op[v].pb(sz(ke[u])-1);
}

bool FindPath(int s, int t) {
    ++dem;
    q[1] = s; lef = 0; righ = 1; fr[s] = dem;
    while (lef < righ) {
        int u = q[++lef];
        For(j, 0, sz(ke[u])-1) {
            int v = ke[u][j];
            if (fr[v] != dem && f[u][j] < c[u][j]) {
                fr[v] = dem; q[++righ] = v;
                t1[v] = u; t2[v] = j;
                if (v == t) return true;
            }
        }
    }
    return false;
}

inline void IncFlow(int s, int t) {
    int v = t, temp = inf;
    while (v != s) {
        int u = t1[v], j = t2[v];
        temp = min(temp, c[u][j] - f[u][j]);
        v = u;
    }
    flow += temp;
    v = t;
    while (v != s) {
        int u = t1[v], j = t2[v];
        f[u][j] += temp; f[v][op[u][j]] -= temp;
        v = u;
    }
}

int main() {
    freopen("alert.inp","r",stdin);
  //  freopen("alert.out","w",stdout);
    scanf("%d", &n);
    int l; scanf("%d", &l);
    For(i, 1, l) {
        int u;
        scanf("%d", &u); id[u] = 1;
    }

    scanf("%d", &l);
    For(i, 1, l) {
        int u;
        scanf("%d", &u); id[u] = 2;
    }

    For(i, 1, n)
    if (id[i] == 1) connect(i, n+1, inf);
    else if (id[i] == 2) connect(0, i, inf);
    scanf("%d", &m); res = 0;
    For(i, 1, m) {
        int u, v, l;
        scanf("%d %d %d", &u, &v, &l);
        if (l) connect(u, v, l); c[v][sz(c[v])-1] = l;
        res += l;
    }

    while (FindPath(0, n+1)) IncFlow(0, n+1);
    For(i, 1, n) if (id[i] == 1 || (!id[i] && fr[i] != dem)) kq[++top] = i;
    printf("%d %d\n", res - flow, top);
    For(i, 1, top) printf("%d ", kq[i]);
}


