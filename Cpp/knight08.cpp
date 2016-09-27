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
#define N 50

struct node {
    int fval, dval, i, j;
    node(int a, int b, int c, int d) {
        dval = a; fval = b; i = c; j = d;
    }
};

bool operator > (const node &a, const node &b) {
    if (a.dval != b.dval) return a.dval > b.dval;
    return a.fval > b.fval;
}

const int h[8] = {-2, -2, -1, -1, 1, 1, 2, 2};
const int c[8] = {-1, 1, -2, 2, -2, 2, -1, 1};

int m, n, a[N][N], ux, uy, d[N][N], f[N][N];
priority_queue< node, vector<node>, greater<node> > heap;

void solve() {
    heap.push(node(0, 0, ux, uy));
    For(i, 1, m) For(j, 1, n) d[i][j] = 100000000;
    d[ux][uy] = 0;
    while (!heap.empty()) {
        int dval = heap.top().dval, fval = heap.top().fval;
        int i = heap.top().i, j = heap.top().j;
        heap.pop();
        if (dval == d[i][j] && fval == f[i][j]) {
            if (a[i][j] == 4) {
                cout << dval << endl; cout << fval;
                return;
            }
            For(k, 0, 7) {
                int u = i + h[k], v = j + c[k];
                if (u > 0 && v > 0 && u <= m && v <= n && a[u][v] != 2) {
                    int cp = 0; if (a[u][v] == 0) cp = 1;
                    if (d[u][v] > dval + cp) {
                        d[u][v] = dval + cp;
                        f[u][v] = fval + 1;
                        heap.push(node(d[u][v], f[u][v], u, v));
                    } else if (d[u][v] == dval + cp && f[u][v] > fval + 1) {
                        f[u][v] = fval + 1;
                        heap.push(node(d[u][v], f[u][v], u, v));
                    }
                }
            }
        }
    }
    cout << -1;
}

int main() {
    freopen("knight08.inp","r",stdin);
    freopen("knight08.out","w",stdout);
    scanf("%d %d", &m, &n);
    For(i, 1, m) For(j, 1, n) {
        scanf("%d", &a[i][j]);
        if (a[i][j] == 3) {
            ux = i; uy = j;
        }
    }
    solve();
}
