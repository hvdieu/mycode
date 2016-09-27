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
#define N 1010
#define inf 1000000000

int n, m, d[N];
char kind[N];
vector<int> ke[N];
priority_queue< ii, vector<ii>, greater<ii> > heap;
double res, step;

void bfs(int i) {
    reset(d, 0x7f);
    d[i] = 0;
    heap.push(ii(0, i));
    while (!heap.empty()) {
        int u = heap.top().se, gt = heap.top().fi;
        heap.pop();
        if (gt == d[u]) {
            For(j, 0, sz(ke[u])-1) {
                int v = ke[u][j];
                int cp = 1; if (kind[i] != kind[u]) cp += 3;
                if (d[v] > d[u] + cp) {
                    d[v] = d[u] + cp;
                    heap.push(ii(d[v], v));
                }
            }
        }
    }
    For(u, i+1, n) if (kind[i] == kind[u]) {
        res = res + d[u];
        step = step + 1;
    }
}

void solve() {
    For(i, 1, n) bfs(i);
   // printf("%.0lf %.0lf\n", res, step);
    res = res / step;
    printf("%.10lf", res);
}

int main() {
    freopen("tax.inp","r",stdin);
    freopen("tax.out","w",stdout);
    scanf("%d%d\n", &n, &m);
    scanf("%s\n", kind+1);
    For(i, 1, m) {
        int u, v;
        scanf("%d%d", &u, &v);
        ke[u].pb(v); ke[v].pb(u);
    }
    solve();
}
