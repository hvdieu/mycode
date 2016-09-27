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
#define pb push_back
#define all(x) x.begin(), x.end()
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 210
#define inf 1000000000

struct node {
    int x, y, val;
};

int n, c, a1, b1, c1, a2, b2, c2, trace[N][2*N], kq[N];
double f[N][2*N];
node a[N];

void build(int x1, int y1, int x2, int y2, int &a, int &b, int &c) {
    a = y2 - y1;
    b = x1 - x2;
    c = x1*(y1-y2) - y1*(x1-x2);
}

int id(int x) {
    return x + n;
}

double dis(int x, int y, int a, int b, int c) {
    double val = a*x + b*y + c;
    return abs(val) / sqrt(a*a + b*b);
}

void solve() {
    For(i, 0, n) For(j, -n, n) f[i][id(j)] = inf;
    f[0][id(0)] = 0;
    For(i, 1, n) For(j, -n, n) {
        int u = id(j);
        int v = id(j-1);
        if (j > -n) {
            double x = f[i-1][v] + dis(a[i].x, a[i].y, a1, b1, c1)*a[i].val;
            if (f[i][u] > x) {
                f[i][u] = x; trace[i][u] = 1;
            }
        }
        v = id(j+1);
        if (j < n) {
            double x = f[i-1][v] + dis(a[i].x, a[i].y, a2, b2, c2)*a[i].val;
            if (f[i][u] > x) {
                f[i][u] = x; trace[i][u] = 2;
            }
        }
    }

    double res = inf;
    int vt = 0;
    For(j, -c, c) if (res > f[n][id(j)]) {
        res = f[n][id(j)];
        vt = id(j);
    }
    int i = n;
    while (i > 0) {
        kq[i] = trace[i][vt];
        if (kq[i] == 1) vt--;
        else vt++;
        i--;
    }
    For(i, 1, n-1) printf("%d ", kq[i]); printf("%d", kq[n]);
  /*  cout << a1 << ' ' << b1 << ' ' << c1 << endl;
    cout << a2 << ' ' << b2 << ' ' << c2 << endl;
    cout << f[2][id(0)];*/
}

int main() {
    freopen("2pipe.inp","r",stdin);
  //  freopen("2pipe.out","w",stdout);
    int dem = 0;
    while (scanf("%d%d", &n, &c) != -1) {
        dem++;
        if (dem > 1) printf("\n\n");
        int x1, y1, x2, y2;
        scanf("%d%d%d%d", &x1, &y1, &x2, &y2);
        build(x1, y1, x2, y2, a1, b1, c1);
        cin >> x1 >> y1 >> x2 >> y2;
        build(x1, y1, x2, y2, a2, b2, c2);
        For(i, 1, n) scanf("%d%d%d", &a[i].x, &a[i].y, &a[i].val);
        solve();
    }
}
