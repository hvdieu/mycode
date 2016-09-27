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
#define N 260
#define inf 1000000000

int n, res, t1[N], t2[N], a[N][N];
vector<int> ke[N], f[N], c[N], op[N];
int q[N], lef, righ;
int fr[N], dem;

void connect(int u, int v, int l) {
    ke[u].pb(v); ke[v].pb(u); f[u].pb(0); f[v].pb(0);
    c[u].pb(l); c[v].pb(0); op[u].pb(sz(ke[v])-1); op[v].pb(sz(ke[u])-1);
}

bool FindPath(int s, int t) {
    dem++; lef = righ = 0;
    q[++righ] = s; fr[s] = dem;
    while (lef < righ) {
        int u = q[++lef];
        For(j, 0, sz(ke[u])-1) {
            int v = ke[u][j];
            if (f[u][j] < c[u][j] && fr[v] != dem) {
                fr[v] = dem; t1[v] = u; t2[v] = j;
                q[++righ] = v; if (v == t) return true;
            }
        }
    }
    return false;
}

void IncFlow(int s, int t) {
    int v = t, temp = inf;
    while (v != s) {
        int u = t1[v], j = t2[v];
        temp = min(temp, c[u][j] - f[u][j]);
        v = u;
    }
    res += temp;
    v = t;
    while (v != s) {
        int u = t1[v], j = t2[v];
        f[u][j] += temp; f[v][op[u][j]] -= temp;
        v = u;
    }
}

int main() {
    freopen("mobivina.inp","r",stdin);
   // freopen("mobivina.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) {
        int x; scanf("%d", &x);
        connect(0, i, x);
    }

    For(i, 1, n) {
        int x; scanf("%d", &x);
        connect(i, n+1, x);
    }
    For(i, 1, n) For(j, 1, n) scanf("%d", &a[i][j]);
    For(i, 1, n) For(j, i+1, n) {
        int x = a[i][j];
        if (x) {
            ke[i].pb(j); ke[j].pb(i); c[i].pb(x); c[j].pb(x);
            f[i].pb(0); f[j].pb(0);
            op[i].pb(sz(ke[j])-1); op[j].pb(sz(ke[i])-1);
        }
    }

    while (FindPath(0, n+1)) IncFlow(0, n+1);
    cout << res;
}
