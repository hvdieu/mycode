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
#define ld long double
#define pb push_back
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 51

int ntest, n, g, m, h[N][N], pnt[N], res, q[N*N], lef, righ, t1[N*N], t2[N*N];
vector<int> ke[N*N], op[N*N], f[N*N], c[N*N];
bool fr[N*N];

bool FindPath(int s, int t) {
    reset(fr, true); lef = 0; righ = 1; q[1] = s; fr[s] = false;
    while (lef < righ) {
        int u = q[++lef];
        For(j, 0, sz(ke[u])-1) {
            int v = ke[u][j];
            if (fr[v] && f[u][j] < c[u][j]) {
                fr[v] = false; q[++righ] = v;
                t1[v] = u; t2[v] = j;
            }
        }
    }
    return !fr[t];
}

void IncFlow(int s, int t) {
    int v = t, temp = 1000000;
    while (v != s) {
        int u = t1[v], j = t2[v];
        temp = min(temp, c[u][j] - f[u][j]);
        v = u;
    }
    v = t;
    while (v != s) {
        int u = t1[v], j = t2[v];
        f[u][j] += temp;
        f[v][op[u][j]] -= temp;
        v = u;
    }
    res += temp;
}

void connect(int u, int v, int l) {
    ke[u].pb(v); f[u].pb(0); c[u].pb(l);
    ke[v].pb(u); f[v].pb(0); c[v].pb(0);
    op[u].pb(sz(ke[v])-1);
    op[v].pb(sz(ke[u])-1);
}


bool solve() {
    if (n == 1) return true;
    int num = 0;
    For(i, 1, n) For(j, 1, i-1) if (i != 1 && j != 1) num += m - h[i][j];
    int i = 1;
    For(j, 1, n) if (i != j)
	For(t, h[i][j]+1, m) pnt[i] += 2;
    For(j, 2, n) if (pnt[1] <= pnt[j]) return false;
    if (!num) return true;
    For(i, 0, n+num+1) {
        ke[i].clear(); f[i].clear(); c[i].clear(); op[i].clear();
    }
    int dem = 0;
    For(i, 1, num) connect(0, i, 2);
    For(i, 1, n) For(j, 1, i-1) if (i != 1 && j != 1)
    For(t, h[i][j]+1, m) {
        dem++;
        connect(dem, i+num, 2);
        connect(dem, j+num, 2);
    }
    For(i, 1, n) if (i != 1) connect(i+num, num+n+1, pnt[1] - pnt[i]-1);
    res = 0;
    while (FindPath(0, num+n+1))
	IncFlow(0, num+n+1);
    return res == 2*num;
}

int main() {
    freopen("soccer.inp","r",stdin);
    //freopen("soccer.out","w",stdout);
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d%d%d", &n, &m, &g);
        reset(pnt, 0);
        reset(h, 0);
        For(i, 1, g) {
            int u, v; char c;
            cin >> u >> c >> v;
            h[u][v]++; h[v][u]++;
            if (c == '=') {
                pnt[u]++; pnt[v]++;
            } else pnt[v] += 2;
        }
        if (solve()) printf("Y\n"); else printf("N\n");
    }
}
