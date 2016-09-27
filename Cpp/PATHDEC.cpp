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
#define N 2010
#define eps 0.00000001
#define inf 1000000000

struct pnt {
    int x, y;
};

struct node {
    double d;
    int i, j;
};

int n, f[N], m, t[N][N], mi[N], res;
pnt a[N];
node b[N*N];

double Distance(int i, int j) {
    int xx = a[i].x - a[j].x;
    int yy = a[i].y - a[j].y;
    return sqrt(xx * xx + yy * yy);
}

bool cmp(node a, node b) {
    return a.d > b.d;
}


void solve() {
    For(i, 1, n) For(j, i + 1, n) if (i != j) {
        m++; b[m].d = Distance(i, j); b[m].i = i; b[m].j = j;
    }
    sort(b + 1, b + m + 1, cmp);
    int i = 1;
    while (i <= m) {
        int j = i;
        while (j < m && abs(b[i].d - b[j+1].d) <= eps) j++;
        For(k, i, j) {
            int u = b[k].i, v = b[k].j;
            if (u != 1 && v != 1) {
                f[u] = max(f[u], max(mi[u], mi[v] + 1));
                f[v] = max(f[v], max(mi[v], mi[u] + 1));
                res = max(f[u], f[v]);
            }
        }
        For(k, i, j) {
            int u = b[k].i, v = b[k].j; mi[v] = max(mi[v], f[v]); mi[u] = max(mi[u], f[u]);
        }
        i = j + 1;
    }
    cout << res;
}

int main() {
    freopen("pathdec.inp","r",stdin);
  //  freopen("pathdec.out","w",stdout);
    a[1].x = 0; a[1].y = 0;
    cin >> n;
    For(i, 2, n + 1) cin >> a[i].x >> a[i].y;
    n++;
    solve();
}
