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
#define two(i) (ll(1) << i)
#define bit(x, i) ( (x >> i) & 1 )
#define onbit(x, i) ( x | (1 << i ) )
#define N 100010

int n, m, cha[N], f[N], dir[N], res;
vector<int> ke[N];
bool indfs[N];

void dfs(int u) {
    int temp = 0;
    indfs[u] = true;
    For(j, 0, sz(ke[u])-1) {
        int v = ke[u][j];
        if (!cha[v]) {
            cha[v] = u; dir[u] = v;
            dfs(v);
        } else if (cha[u] != v && indfs[v]) {
            f[dir[v]]++; temp++;
            res++;
        }
    }
    For(j, 0, sz(ke[u])-1) {
        int v = ke[u][j];
        if (cha[v] == u) f[v] -= temp;
    }
    indfs[u] = false;
}

void visit(int u) {
    if (cha[u] != u) f[u] += f[cha[u]];
    if (f[u] > 0) res++;
    For(j, 0, sz(ke[u])-1) {
        int v = ke[u][j];
        if (cha[v] == u) visit(v);
    }
}

void solve() {
    For(i, 1, n) if (!cha[i]) {
        cha[i] = i;
        dfs(i);
        visit(i);
    }
    cout << res;
}

int main() {
    freopen("NDIR.INP","r",stdin);
    //freopen("NDIR.OUT","w",stdout);
    scanf("%d%d", &n, &m);
    For(i, 1, m) {
        int u, v; scanf("%d%d", &u, &v);
        ke[u].pb(v); ke[v].pb(u);
    }
    solve();
}
