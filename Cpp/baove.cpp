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
#define N 5001
#define inf 1000000000

int n, q[N], t1[N], t2[N], res, lef, righ;
vector<int> ke[N], f[N], c[N], op[N];
bool fr[N];

bool FindPath(int s, int t) {
    reset(fr, true);
    lef = 0; righ = 1; q[1] = s;
    fr[s] = false;
    while (lef < righ) {
        int u = q[++lef];
        For(j, 0, sz(ke[u])-1) {
            int v = ke[u][j];
            if (fr[v] && f[u][j] < c[u][j]) {
                q[++righ] = v; fr[v] = false;
                t1[v] = u; t2[v] = j;
            }
        }
    }
    if (fr[t]) return false;
    return true;
}

void IncFlow(int s, int t) {
    int v = t, temp = inf;
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

int main() {
    //freopen("baove.inp","r",stdin);
    //freopen("baove.out","w",stdout);
    scanf("%d\n", &n);
    int u, v, l;
    while (scanf("%d %d %d\n", &u, &v, &l) != -1) {
        ke[u].pb(v); c[u].pb(l); f[u].pb(0);
        ke[v].pb(u); c[v].pb(0); f[v].pb(0);
        op[u].pb(sz(ke[v])-1); op[v].pb(sz(ke[u])-1);
    }
    while (FindPath(n, 1))
	IncFlow(n, 1);
    cout << res;
}
