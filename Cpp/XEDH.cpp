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
#define N 510

struct edge {
    int u, v, val;
    edge(int a, int b, int c) {
        val = a; u = b; v = c;
    }
};

const int h[2] = {0, 1};
const int c[2] = {1, 0};

int n, a[N][N], root[N*N], f[N*N], res;
vector<edge> Q;

bool cmp(edge a, edge b) {
    return a.val < b.val;
}

int getroot(int u) {
    return root[u] == u ? root[u] : root[u] = getroot(root[u]);
}

void Union(int r1, int r2) {
    if (f[r1] < f[r2]) {
        f[r2] += f[r1];
        root[r1] = r2;
    } else {
        f[r1] += f[r2];
        root[r2] = r1;
    }
    res = max(res, max(f[r1], f[r2]));
}

void solve() {
    For(i, 1, n*n) {
        root[i] = i; f[i] = 1;
    }
    For(i, 1, n) For(j, 1, n) For(k, 0, 1) {
        int u = i + h[k], v = j + c[k];
        if (u && v && u <= n && v <= n) Q.pb(edge(abs(a[i][j] - a[u][v]), (i-1)*n+j, (u-1)*n+v));
    }
    sort(all(Q), cmp);
    For(i, 0, sz(Q)-1) {
        int r1 = getroot(Q[i].u), r2 = getroot(Q[i].v);
        if (r1 != r2) Union(r1, r2);
        if (res >= (n*n+1) / 2) {
            cout << Q[i].val; return;
        }
    }
    cout << 0;
}

int main() {
    freopen("xedh.inp","r",stdin);
    freopen("xedh.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) For(j, 1, n) scanf("%d", &a[i][j]);
    solve();
}
