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
#define N 5010
#define eps 0.000000001

struct rec {
    double x, y, l;
};

struct line {
    double x1, x2;
};

struct dt {
    double a, b, c;
};

int n, res;
rec a[N];
line q[N];

void build(dt &d, double x1, double y1, double x2 ,double y2) {
    d.a = y2 - y1;
    d.b = x1 - x2;
    d.c = x1 * (y1 - y2) + y1 * (x2 - x1);
}

double giao(dt d1, dt d2) {
    double hs = d1.b / d2.b;
    return (d1.c - d2.c * hs) / (d2.a * hs - d1.a);
}

bool cmp(line a, line b) {
    if (a.x1 != b.x1) return a.x1 < b.x1;
    return a.x2 > b.x2;
}

bool is_cut(double i, double j, double u, double v) {
    if (i > u) {
        swap(i,u); swap(j,v);
    }
    if (j < u) return false;
    return true;
}

bool is_left(rec a, rec b) {
    return a.x < b.x + b.l;
}

bool is_under(rec a, rec b) {
    return a.y < b.y + b.l;
}

void solve() {
    For(i,1,n) {
        int m = 0;
        double x1 = a[i].x, y1 = a[i].y, l1 = a[i].l;
        dt d, d1, d2;
        build(d, x1, y1 + l1, x1 + l1, y1);
        For(j,1,n) if (i != j && (is_left(a[j],a[i]) && is_under(a[j],a[i]))) {
            double x2 = a[j].x, y2 = a[j].y, l2 = a[j].l;
            build(d1, 0, 0, x2 + l2, y2);
            build(d2, 0, 0, x2, y2 + l2);
            double x3 = giao(d,d1), x4 = giao(d,d2);
            if (x3 > x4) swap(x3,x4);
            if (is_cut(x1, x1+l1, x3, x4)) {
                m++; q[m].x1 = x3; q[m].x2 = x4;
            }
        }
        if (!m) res++;
        else {
            double u = q[1].x1, v = q[1].x2;
            For(i,2,n) if (q[i].x1 > q[i-1].x2) break;
            else if (q[i].x2 > q[i-1].x2) v = q[i].x2;
            bool ok = true;
            if (u <= x1 && x1 + l1 <= v) ok = false;
            if (ok) res++;
        }
    }
    cout << res;
}

int main() {
    freopen("squares.inp","r",stdin);
    freopen("squares.out","w",stdout);
    scanf("%d",&n);
    For(i,1,n) cin >> a[i].x >> a[i].y >> a[i].l;
    solve();
}
