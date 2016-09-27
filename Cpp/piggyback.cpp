#include <stdio.h>
#include <iostream>
#include <algorithm>
#include <math.h>
#include <vector>
#include <string>
#include <cstring>
#include <map>
#include <set>
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
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 40010
#define inf 1000000000

int n, B, E, P, m, d[3][N];
ll res;
vector<int> ke[N];
priority_queue<ii, vector<ii>, greater<ii> > heap;

void Dij(int t, int start) {
    For(i, 1, n) d[t][i] = inf;
    d[t][start] = 0;
    heap.push(ii(0, start));
    while (!heap.empty()) {
        int gt = heap.top().fi, u = heap.top().se;
        heap.pop();
        if (gt == d[t][u]) {
            For(j, 0, sz(ke[u])-1) {
                int v = ke[u][j];
                if (d[t][v] > d[t][u] + 1) {
                    d[t][v] = d[t][u] + 1;
                    heap.push(ii(d[t][v], v));
                }
            }
        }
    }
}

void solve() {
    Dij(0, n);
    Dij(1, 1);
    Dij(2, 2);
    res = d[1][n] * B + d[2][n] * E;
    For(i, 1, n-1) {
        ll path1 = d[1][i];
        ll path2 = d[2][i];
        ll path3 = d[0][i];
        res = min(res, path1*B + path2*E + path3*P);
    }
    cout << res;
}

int main() {
    freopen("piggyback.in","r",stdin);
    freopen("piggyback.out","w",stdout);
    scanf("%d%d%d%d%d", &B, &E, &P, &n, &m);
    For(i, 1, m) {
        int u, v;
        scanf("%d%d", &u, &v);
        ke[u].pb(v); ke[v].pb(u);
    }
    solve();
}




