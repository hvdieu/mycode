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
#define ld long double
#define pb push_back
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())

struct point {
    int x,y;
    point(int a,int b) {
        x = a; y = b;
    }
};

int n,d,m,xmin,ymin,xmax,ymax,f[11][35][35],c[11][21][21],res;

int id(int i) {
    return i + d;
}

double Distance(int x1,int y1,int x2,int y2) {
    int xx = x1 - x2, yy = y1 - y2;
    return sqrt(xx * xx + yy * yy);
}

bool In(int x1,int y1,int x2,int y2,int x3,int y3) {
    int a = y2 - y1;
    int b = x1 - x2;
    int c = x1 * (y1 - y2) + y1 * (x2 - x1);
    if (a * x3 + b * y3 + c) return false;
    if (x1 > x2) swap(x1,x2);
    if (y1 > y2) swap(y1,y2);
    if (x1 <= x3 && x3 <= x2 && y1 <= y3 && y3 <= y2) return true;
    return false;
}

void solve() {
    xmin = -d; xmax = n + d;
    ymin = -d; ymax = n + d;
    For(time,1,10) For(x,xmin,xmax) For(y,ymin,ymax) {
        For(xx,max(xmin,x-d),min(xmax,x+d))
            For(yy,max(ymin,y-d),min(ymax,x+d)) if (Distance(x,y,xx,yy) <= d) {
                int sum = 0;
                For(u,max(xmin,x-d),min(xmax,x+d)) For(v,max(ymin,y-d),min(ymax,y+d))
                if (Distance(x,y,u,v) <= Distance(x,y,xx,yy) && In(x,y,xx,yy,x,y)) sum += c[time][u][v];
                f[time][id(x)][id(y)] = max(f[time][id(x)][id(y)], f[time-1][id(xx)][id(yy)] + sum);
            }
        res = max(res,f[time][x][y]);
    }
    cout << res;
}

int main() {
    freopen("qbmouse.inp","r",stdin);
   // freopen("qbmouse.out","w",stdout);
    cin >> n >> d >> m;
    For(i,1,m) {
        int x,y,time;
        cin >> x >> y >> time;
        c[time][x][y]++;
    }
    solve();
}
