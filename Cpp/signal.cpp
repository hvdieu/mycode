#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
const int N = 1510;
const double pi = acos(-1);

struct point {
    int x, y;
    double angle;
};

int n;
point a[N], origin, b[2*N];
ll P, Q;

ll C(int k, int n) {
	if (k > n) return 0;
    ll a = 1, b = 1;
    For(i, -k+1, 0) a *= n+i;
    For(i, 1, k) b *= i;
    return a / b;
}

void operator -= (point &A, point B) {
    A.x -= B.x; A.y -= B.y;
}

bool ccw(point O, point A, point B) {
    A -= O; B -= O;
    return ll(A.x)*B.y > ll(A.y)*B.x;
}

bool cmp(point A, point B) {
    return A.angle < B.angle;
}

double goc(point M) {
    M -= origin;
    int x = M.x, y = M.y;
    if (!x) if (y > 0) return pi/2; else return 3.0*pi/2;
    if (!y) if (x > 0) return 0; else return pi;
    double o = abs(atan(double(y)/x));
    if (x > 0 && y < 0) o = 2.0*pi - o;
    else if (x < 0 && y > 0) o = pi - o;
    else if (x < 0 && y < 0) o = pi + o;
    return o;
}

void solve(int ii) {
    origin = a[ii];
    int m = 0;
    For(i, 1, n) if (i != ii) {
        b[++m] = a[i];
        b[m].angle = goc(b[m]);
    }
    sort(b+1, b+m+1, cmp);
    For(i, m+1, 2*m) b[i] = b[i-m], b[i].angle += 2.0*pi;
    int tmp = C(3, m);
    int j = 1;
    while (j < m && b[j+1].angle - b[1].angle <= pi) j++;
    tmp -= C(2, j-1);
    For(i, 2, m) {
        while (j < i+m-1 && b[j+1].angle - b[i].angle <= pi) j++;
        tmp -= C(2, j-i);
    }
    P += tmp;
}

int main() {
   // freopen("input.txt","r",stdin);
  //  freopen("output.txt","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d%d", &a[i].x, &a[i].y);
    For(i, 1, n) solve(i);
    Q = C(4, n) - P;
    double s = 2*Q + P;
    double t = C(3, n);
    printf("%.6lf", s/t + 3);
}
