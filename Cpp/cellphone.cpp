#include <bits/stdc++.h>

using namespace std;
typedef pair<double, double> point;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define x first
#define y second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define sqr(x) ((x)*(x))

const int N = 2010;
const double pi = acos(-1);

struct line {
    double a, b, c;
};

int n, m;
double r;
point a[N], b[N];
vector<point> center;
int res;
point origin;

double dis(point A, point B) {
    double x = A.x - B.x, y = A.y - B.y;
    return sqrt(x*x + y*y);
}

void Find_Center(point A, point B) {
    double d = dis(A, B); d = sqrt(sqr(r) - sqr());
    point M = point((A.x + B.x)/2, (A.y + B.y)/2);
    if (A.x == B.x) {
        center.pb(point(M.x, M.y - d)); center.pb(point(M.x, M.y + d));
        return;
    }

    if (A.y == B.y) {
        center.pb(point(M.x - d, M.y)); center.pb(point(M.x + d, M.y));
        return;
    }

    line dt; dt.a = A.x - B.x; dt.b = A.y - B.y; dt.c = -dt.a*M.x - b*M.y;
    double a = -dt.a / dt.b, b = dt.c / dt.b;
    double x1 = A.x, y1 = B.y, x2, y2;
    double a1 = sqr(x) + 1;
    double b1 = 2.0*a*b - 2.0*x1 - 2.0*y1*a;
    double c1 = sqr(b) - 2.0*y1*b + sqr(x1) + sqr(y1) - sqr(x);
    double delta = sqr(b1) - 4.0*a1*c1;
    x1 = (-b1 - sqrt(delta)) / (2.0*a1);
    x2 = (-b1 + sqrt(delta)) / (2.0*a1);
    y1 = a * x1 + b; y2 = a * x2 + b;
    center.pb(point(x1, y1));
    center.pb(point(x2, y2));
}

double goc(point A) {
    double x = A.x, y = A.y;
    if (!x) {
        if (!y) return 0;
        if (y > 0) return pi/2;
        else return ((3.0/2)*pi);
    } else if (!y) {
        if (x > 0) return 0;
        return pi;
    }
    double o = abs(atan(double(y)/x));
    if (x > 0) {
        if (y > 0) return o;
        return 2.0*pi - o;
    } else {
        if (y > 0) return pi-o;
        return pi+o;
    }
}

int ccw(point O, point A, point B) {
    A.x -= O.x; A.y -= O.y;
    B.x -= O.x; B.y -= O.y;
    double x = A.x*B.y - A.y*B.x;
    if (x > 0) return 1;
    if (x < 0) return -1;
    return 0;
}

bool cmp(point a, point b) {
    return goc(a) < goc(b);
}

void solve() {
    res = 1;
    For(i, 1, n) {
        origin = a[i];
        center.clear();
        For(j, 1, n) if (i != j && dis(a[i], a[j]) <= 2*r) Find_Center(a[i], a[j]);
        m = 0;
        For(j, 1, n) if (i != j) b[++m] = a[j];
        sort(b+1, b+m+1, cmp);
        For(j, m+1, 2*m) b[j] = b[j-m];
        sort(all(center), cmp);
        int u = 0, v = 0;
        For(j, 1, m)
    }
}

int main() {
    freopen("input.txt","r",stdin);
    freopen("output.txt","w",stdout);
    while (cin >> n >> r) {
        For(i, 1, n) cin >> a[i].x >> a[i].y;
        solve();
    }
}
