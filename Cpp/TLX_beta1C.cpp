#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> point;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define REP(i, n) for(int i = 0; i < n; i++)
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
#define N 2010

const double eps = 1e-12;
const double pi = acos(-1);

int n, res;
point a[N];
vector<double> b;

ll dis(int i, int j) {
    int xx = a[i].x - a[j].x;
    int yy = a[i].y - a[j].y;
    return ll(xx)*xx + ll(yy)*yy;
}

int main() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d%d", &a[i].x, &a[i].y);
    res = n;
    a[0].x = a[0].y = 0;
    For(i, 1, n) For(j, i+1, n) if (dis(a[0], a[i]) == dis(a[0], a[j])) {
        double xx = (double(a[i].x) + a[j].x) / 2;
        double yy = (double(a[i].y) + a[j].y) / 2;
        double goc;
        if (!xx && !yy) goc = pi/4;
        else {

    }
}
