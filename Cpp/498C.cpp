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
#define N 110
#define NN 100*33

int n, m, match[NN], nn;
vector<int> p[N], pos[N];
vector<int> ke[NN];
int was[NN], dem;

void tach(int i, int x) {
    int ss = trunc(sqrt(x));
    For(j, 2, ss)
    while (x % j == 0) {
        p[i].pb(j); pos[i].pb(++nn);
        x /= j;
    }
    if (x > 1) {
        p[i].pb(x); pos[i].pb(++nn);
    }
}

bool dfs(int u) {
    if (was[u] == dem) return false;
    was[u] = dem;
    For(j, 0, sz(ke[u])-1) {
        int v = ke[u][j];
        if (!match[v] || dfs(match[v])) {
            match[v] = u; return true;
        }
    }
    return false;
}

void solve() {
    int res = 0;
    dem = 1;
    for(int i = 2; i <= n; i += 2) {
        For(j, 0, sz(p[i])-1) {
            int u = pos[i][j];
            For(jj, 0, sz(ke[u])-1) {
                int v = ke[u][jj];
                if (!match[v] || dfs(match[v])) {
                    match[v] = u; dem++;
                    res++; break;
                }
            }
        }
    }
    cout << res;
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d", &n, &m);
    For(i, 1, n) {
        int x;
        scanf("%d", &x);
        tach(i, x);
    }
    For(mm, 1, m) {
        int u, v;
        scanf("%d%d", &u, &v);
        if (u % 2) swap(u, v);
        For(i, 0, sz(p[u])-1) For(j, 0, sz(p[v])-1) if (p[u][i] == p[v][j])
        ke[pos[u][i]].pb(pos[v][j]);
    }
    solve();
}
