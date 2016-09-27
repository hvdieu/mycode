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
#define x first
#define y second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 100010
#define inf 1000000001

int xmin, ymin, xmax, ymax, n;

int main() {
  //  freopen("pinpos.inp","r",stdin);
    //freopen("pinpos.out","w",stdout);
    xmin = ymin = -inf;
    xmax = ymax = inf;
    scanf("%d", &n);
    For(i, 1, n) {
        int xa, ya, xb, yb, xc, yc, xd, yd;
        cin >> xa >> ya >> xb >> yb >> xc >> yc >> xd >> yd;
        int x1 = min(min(xa-ya, xb-yb), min(xc-yc, xd-yd));
        int x2 = max(max(xa-ya, xb-yb), max(xc-yc, xd-yd));
        int y1 = min(min(xa+ya, xb+yb), min(xc+yc, xd+yd));
        int y2 = max(max(xa+ya, xb+yb), max(xc+yc, xd+yd));
        xmin = max(xmin, x1);
        xmax = min(xmax, x2);
        ymin = max(ymin, y1);
        ymax = min(ymax, y2);
    }
  // cout << xmin << ' ' << ymin << ' ' << xmax << ' ' << ymax << endl;
    ll res = (ll(xmax) - xmin - 1) * (ymax - ymin - 1);
  //  cout << res << endl;
    if (res <= 0) res = 0;
    if (abs(xmin) % 2 == abs(ymin) % 2) res = (res + 1) / 2;
    else res = res / 2;
    cout << res;
}




