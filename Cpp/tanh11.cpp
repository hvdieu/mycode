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
#define N 1010
#define C 110
#define inf 1000000000

struct node {
    int val, u, xang;
    node(int a, int b, int c) {
        val = a; u = b; xang = c;
    }
};

bool operator > (const node &a, const node &b) {
    return a.val > b.val;
}

int n, m, c, ntest, s, t, p[N], d[N][C];
priority_queue< node, vector<node>, greater<node> > heap;
vector<int> ke[N], w[N];

void solve() {
    reset(d, 0x7f);
    d[s][0] = 0;
    while (!heap.empty()) heap.pop();
    heap.push(node(0, s, 0));

    while(!heap.empty()) {
        int gt = heap.top().val, u = heap.top().u, e = heap.top().xang;
        heap.pop();
        if (gt == d[u][e]) {
            if (u == t) {
                printf("%d", gt);
                return;
            }
            if (e < c) {
                if (d[u][e+1] > d[u][e] + p[u]) {
                    d[u][e+1] = d[u][e] + p[u];
                    heap.push(node(d[u][e+1], u, e+1));
                }
            }
            For(j, 0, sz(ke[u])-1) {
                int v = ke[u][j], cp = w[u][j];
                if (cp <= e && d[v][e-cp] > d[u][e]) {
                    d[v][e-cp] = d[u][e];
                    heap.push(node(d[v][e-cp], v, e-cp));
                }
            }
        }
    }
    printf("impossible");
}

int main() {
   // freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    scanf("%d%d", &n, &m);
    For(i, 1, n) scanf("%d", &p[i]);
    For(i, 1, m) {
        int u, v, l;
        scanf("%d%d%d", &u, &v, &l);
        u++; v++;
        ke[u].pb(v); ke[v].pb(u);
        w[u].pb(l); w[v].pb(l);
    }
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d%d%d", &c, &s, &t);
        s++; t++;
        solve();
        if (ntest) printf("\n");
    }
}
