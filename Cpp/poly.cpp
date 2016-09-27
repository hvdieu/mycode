#include <bits/stdc++.h>

using namespace std;
typedef pair<double, double> ii;
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
#define N 1010
#define eps 1e-5
#define inf ii(-124328472, 897234932)
#define vc 1000000000

int n;
ii p[N], A, B;
vector<ii> l, l2;
double res;

void build (ii A, ii B, double &a, double &b, double &c) {
    a = A.y - B.y;
    b = B.x - A.x;
    c = A.x*B.y - B.x*A.y;
}

bool cungphia(ii A, ii B, double a, double b, double c) {
    return ((a*A.x + b*A.y + c) * (a*B.x + b*B.y + c)) > 0;
}

bool gb(double A, double B) {
    return abs(A-B) <= eps;
}

bool khacphia(ii A, ii B, double a, double b, double c) {
    double X = (a*A.x + b*A.y + c) * (a*B.x + b*B.y + c);
    return (X < 0 && !gb(X, 0));
}

double cal(ii A, double a, double b, double c) {
    return a*A.x + b*A.y + c;
}


bool giao(ii A, ii B, ii C, ii D) {
    double a, b, c;
    build(A, B, a, b, c);
    if (cungphia(C, D, a, b, c)) return false;
    build(C, D, a, b, c);
    if (cungphia(A, B, a, b, c)) return false;
    return true;
}

ii nghiem(double a1, double b1, double c1, double a2, double b2, double c2) {
    c1 *= -1; c2 *= -1;
    if (gb(a1*b2, a2*b1)) return inf;
    double x = vc, y = vc;
    if (gb(a1, 0)) {
        y = c1 / b1;
        x = (c2 - b2*y) / a2;
    } else if (gb(a2, 0)) {
        y = c2 / b2;
        x = (c1 - b1*y) / a1;
    } else if (gb(b1, 0)) {
        x = c1 / a1;
        y = (c2 - a2*x) / b2;
    } else if (gb(b2, 0)) {
        x = c2 / a2;
        y = (c1 - a1*x) / b1;
    }
    if (gb(x, vc)) {
        double hs = a1 / a2;
        a2 *= hs; b2 *= hs; c2 *= hs;
        y = (c1 - c2) / (b1 - b2);
        x = (c1 - b1*y) / a1;
    }
    return ii(x, y);
}

bool on(ii M, ii A, ii B) {
    double xmin = min(A.x, B.x), xmax = max(A.x, B.x), ymin = min(A.y, B.y), ymax = max(A.y, B.y);
    return (M.x >= xmin && M.x <= xmax && M.y >= ymin && M.y <= ymax);
}

ii tinhgiao(ii A, ii B, ii C, ii D) {
    double a1, b1, c1, a2, b2, c2;
    build(A, B, a1, b1, c1);
    build(C, D, a2, b2, c2);
    if (gb(cal(A, a2, b2, c2), 0) && on(A, C, D)) l.pb(A);
    if (gb(cal(B, a2, b2, c2), 0) && on(B, C, D)) l.pb(B);
    if (gb(cal(C, a1, b1, c1), 0) && on(C, A, B)) l.pb(C);
    if (gb(cal(D, a1, b1, c1), 0) && on(D, A, B)) l.pb(D);
    ii E = nghiem(a1, b1, c1, a2, b2, c2);
    if (gb(cal(E, a1, b1, c1), 0) && gb(cal(E, a2, b2, c2), 0)) l.pb(E);
}

bool cmp(ii a, ii b) {
    if (a.x != b.x) return a.x < b.x;
    return a.y < b.y;
}

double dis(ii A, ii B) {
    double xx = A.x - B.x;
    double yy = A.y - B.y;
    return sqrt(xx*xx + yy*yy);
}

bool check(ii M) {
    For(i, 1, n) {
        double a, b, c;
        build(p[i], p[i+1], a, b, c);
        For(j, 1, n)
		if (khacphia(M, p[j], a, b, c)) return false;
    }
    return true;
}

void solve() {
    l.pb(A); l.pb(B);
    p[n+1] = p[1];
    For(i, 1, n) if (giao(A, B, p[i], p[i+1]))
	tinhgiao(A, B, p[i], p[i+1]);
    sort(all(l), cmp);

    l.erase(unique(all(l)), l.end());
    //cout << sz(l) << endl;
    //For(i, 0, sz(l)-1) printf("%.2lf %.2lf\n", l[i].x, l[i].y);

    For(i, 0, sz(l)-1)
    if (check(l[i])) l2.pb(l[i]);
    if (sz(l2) < 2) cout << 0 << endl;
    else {
        int i = 0; while (i < sz(l2)-2 && gb(l2[i].x, l2[i+1].x) && gb(l2[i].y, l2[i+1].y)) i++;
        if (i == sz(l2)-1) cout << 0 << endl;
        else cout << trunc(dis(l2[i], l2[i+1])*100) << endl;
    }
    //cout << sz(l2) << endl;
    //For(i, 0, sz(l2)-1) printf("%.2lf %.2lf\n", l2[i].x, l2[i].y);
}

void solve2(ii A, ii B) {
    if (dis(A, B) <= eps) return;
    if (check(A) && check(B)) {
        res += dis(A, B); return;
    }
    ii M = ii((A.x + B.x) / 2, (A.y + B.y) / 2);
    solve2(A, M); solve2(B, M);
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("poly.inp","r",stdin);
    //freopen("poly.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%lf%lf", &p[i].x, &p[i].y);
    scanf("%lf%lf%lf%lf", &A.x, &A.y, &B.x, &B.y);
   // solve();
    p[n+1] = p[1];
    res = 0;
    //cout << int(check(ii(0, 0)));
    solve2(A, B);
    cout << trunc(res * 100);
}
