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
#define N 31

int n, pnt[N], q[N*N], t1[N*N], t2[N*N], m, id[N], res, lef, righ;
bool fr[N*N];
int s[N][N];
vector<int> ke[N*N], op[N*N], f[N*N], c[N*N];

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

bool Do(int i) {
    int pp = pnt[i], num = 0;
    For(j, 1, n) if (s[i][j] == 2) pp++;
    For(j, 1, n) if (pp < pnt[j]) return false;
    For(ii, 1, n) For(jj, 1, n) if (ii != i && jj != i && s[ii][jj] == 2) num++;
    num /= 2;
    if (!num) return true;
    For(ii, 0, num+n+1) {
        ke[ii].clear(); f[ii].clear(); c[ii].clear(); op[ii].clear();
    }
    For(ii, 1, num) connect(0, ii, 1);
    int dem = 0;
    For(ii, 1, n) For(jj, 1, ii-1) if (ii != i && jj != i && s[ii][jj] == 2) {
        dem++;
        connect(dem, ii+num, 1);
        connect(dem, jj+num, 1);
    }
    For(ii, 1, n) if (ii != i) connect(ii+num, num+n+1, pp - pnt[ii]);
    res = 0;
    while (FindPath(0, num+n+1))
	IncFlow(0, num+n+1);
    return res == num;
}

void solve() {
    For(i, 1, n) For(j, 1, n) if (s[i][j] == 1) pnt[i]++;
    For(i, 1, n) printf("%d", int(Do(i)));
}

int main() {
    freopen("bongda.inp","r",stdin);
    //freopen("bongda.out","w",stdout);
    scanf("%d\n", &n);
    For(i, 1, n) For(j, 1, n) cin >> s[i][j];
    solve();
}
