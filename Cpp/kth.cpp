#include <vector>
#include <algorithm>
#include <math.h>
#include <iostream>
#include <stdio.h>
#include <string.h>
#include <cmath>
#include <cstring>
#include <queue>
#include <stack>

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
#define all(x) x.begin(), x.end()
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 200010

int n, q, cha[N], f[N][21], vmax, root, d[N], pos[N], what[N], ntest;
vector<int> ke[N];

void dfs(int u) {
    For(j, 1, vmax) f[u][j] = f[f[u][j-1]][j-1];
    For(j, 0, sz(ke[u])-1) {
        int v = ke[u][j];
        d[v] = d[u]+1;
        cha[v] = u; f[v][0] = u;
        dfs(v);
    }
}

void add_node(int u, int v) {
    n++;
    u = pos[u];
    pos[v] = n; what[n] = v; v = n;
    d[v] = d[u] + 1;
    f[v][0] = u; cha[v] = u;
    For(j, 1, vmax) f[v][j] = f[f[v][j-1]][j-1];
}

void delete_node(int u) {
    pos[u] = 0;
}

int find_pa(int u, int k) {
    if (!pos[u]) return 0;
    u = pos[u];
    if (d[u] < k) return 0;
    Rep(j, vmax, 0) if (k >= (1 << j)) {
        u = f[u][j];
        k -= 1 << j;
    }
    return what[u];
}

int main() {
    freopen("kth.inp","r",stdin);
    //freopen("kth.out","w",stdout);
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        reset(d, 0);
        reset(pos, 0);
        scanf("%d", &n);
    	For(i, 1, n) ke[i].clear();
    	int m = 0;
        For(i, 1, n) {
            int u, v;
            scanf("%d%d", &u, &v);
            if (u && !pos[u]) {
                pos[u] = ++m; what[m] = u;
            }
            if (v && !pos[v]) {
                pos[v] = ++m; what[m] = v;
            }
            u = pos[u]; v = pos[v];
            if (!v) root = u;
            else ke[v].pb(u);
        }
        scanf("%d", &q);
        vmax = trunc(log(n+q) / log(2));
        cha[root] = root; f[root][0] = root;
        dfs(root);
        while (q) {
            q--;
            int kind, u, v;
            scanf("%d", &kind);
            if (kind == 0) {
                scanf("%d%d", &u, &v);
                add_node(u, v);
            } else if (kind == 1) {
                scanf("%d", &u);
                delete_node(u);
            } else {
                scanf("%d%d", &u, &v);
                printf("%d\n", find_pa(u, v));
            }
        }
    }
}
