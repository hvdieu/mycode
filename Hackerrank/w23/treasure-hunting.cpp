#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define REP(i, n) for(int i = 0; i < n; i++)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define getbit(x, i) ((x >> (i-1)) & 1LL)
#define onbit(x, i) (x | (1LL << (i-1)))
#define offbit(x, i) (x & ~(1 << (i-1)))

long double x, y, a, b;

int main() {
    //freopen("in.txt","r",stdin);
    cin >> x >> y >> a >> b;
    double k = (a*x + b*y) / (a*a + b*b);
    double n = (a*y - b*x) / (a*a + b*b);
    cout << setprecision(10) << k << "\n";
    cout << setprecision(10) << n << "\n";
    //cout << setprecision(6) << k*a - n*b << ", " << k*b + n*a << "\n";
}


