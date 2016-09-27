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
#define all(x) x.begin(), x.end()
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define eps 1e-12
#define N 110
#define BUG(x) { cout << #x << " = "  << x << endl; }
#define pi acos(-1)

int n;
double R, r, S, O, s;

double cal(double a, double b, double c) {
    double delta = b*b - double(4)*a*c;
    return (-b + sqrt(delta)) / (a*2);
}

void solve() {
    if (n == 1) {
        printf("%.10lf %.10lf %.10lf\n", R, 0.0, 0.0);
        return;
    }
    S = R * R * pi;
    if (n == 2) {
        r = R / 2;
        printf("%.10lf %.10lf %.10lf\n", R / 2, 0.0, S - (double(2) * r * r * pi));
        return;
    }
    double x = (pi*2) / n;
	x = cos(x);
	x = 1 - x;
    r = cal(2-x, double(2)*x*R, -x*R*R);
    double s = r * r * pi, t = r*2;
    double A = (t*t*n) / (double(4)*tan(pi/n));
    double goc = (pi - (pi*2)/n) / 2;
    double k = (goc*2) / (pi*2);
    double I = A - (s * k * n);
    double E = S - s*n - I;
    printf("%.10lf %.10lf %.10lf\n", r, I, E);
  //  cout << pi;
}

int main() {
    freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    while (scanf("%lf %d\n", &R, &n) != -1) solve();
}
