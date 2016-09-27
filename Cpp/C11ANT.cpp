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
#define N 100010
#define inf 1000000000
#define INF 1000000000000000000LL

const double eps = 1e-12;

int n;
int a[N], b[N];

double f(double x) {
    double MIN = INF, MAX = -INF;
    For(i, 1, n) {
        MIN = min(MIN, x*a[i] + b[i]);
        MAX = max(MAX, x*a[i] + b[i]);
    }
    return MAX - MIN;
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d", b+i);
    For(i, 1, n) scanf("%d", a+i);
    double l = 0, r = inf, mid, res;
   // for (double i = -2; i <= 2; i += 0.5) printf("%.2lf %.2lf\n", i, f(i));
    while (l + eps <= r) {
        double m1 = l + (r-l) / 3;
        double m2 = r - (r-l) / 3;
        double X = f(m1), Y = f(m2);
        if (X > Y + eps) l = m1;
        else r = m2;
    }
    printf("%.3lf", f((r+l)/2) / 2);
}
