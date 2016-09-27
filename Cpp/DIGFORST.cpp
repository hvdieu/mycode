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
#define inf 1000000000

struct node {
    int val, u, mod;
    node(int a, int b, int c) {
        val = a; u = b; mod = c;
    }
};

bool operator > (node a, node b) {
    return a.val > b.val;
}

int n, a[N], res, d[N][430];
vector<int> ke[N];
priority_queue<node, vector<node>, greater<node> > heap;

int gcd(int a, int b) {
    if (!b) return a;
    return gcd(b, a % b);
}

int lcm(int a, int b) {
    return (a * b) / gcd(a, b);
}

void Dij(int tt, int base) {
    For(i, 1, n) For(j, 0, base-1) d[i][j] = inf;
    d[1][a[1] % base] = a[1];
    heap.push(node(a[1], 1, a[1] % base));
    while (!heap.empty()) {
        int u = heap.top().u, gt = heap.top().val, mod = heap.top().mod;
        heap.pop();
        if (gt == d[u][mod]) {
            For(j, 0, sz(ke[u])-1) {
                int v = ke[u][j];
                int mod2 = (mod * 10 + a[v]) % base;
                if (bit(tt, a[v]-1) && d[v][mod2] > d[u][mod] + a[v]) {
                    d[v][mod2] = d[u][mod] + a[v];
                    heap.push(node(d[v][mod2], v, mod2));
                }
            }
        }
    }
    res = min(res, d[n][0]);
}

void solve() {
    res = inf;
    For(tt, 1, two(7)-1) if (bit(tt, a[1]-1)) {
        int base = a[1];
        For(i, 1, 7) if (bit(tt, i-1))
            base = lcm(base, i);
        Dij(tt, base);
    }
    if (res == inf) cout << -1; else cout << res;
}

int main() {
    freopen("digforst.inp","r",stdin);
    freopen("digforst.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d", &a[i]);
    For(i, 1, n) For(j, 1, n) {
        int x; scanf("%d", &x);
        if (x) ke[i].pb(j);
    }
    solve();
}
