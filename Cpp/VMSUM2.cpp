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
#define N 1000010

int n;
double sum[N];

int gcd(int a, int b) {
    return (!b) ? a : gcd(b, a % b);
}

void init() {
    n = 1000;
    For(q, 1, n) For(p, 1, q-1) if (gcd(p, q) == 1) {
        double x = double(1) / (p * q);
        sum[q] += x;
        sum[p+q+1] -= x;
    }
    For(i, 1, n) sum[i] += sum[i-1];
    For(i, 1, n) sum[i] += sum[i-1];
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    init();
    while (cin >> n)
        printf("%.7lf\n", sum[n]);
}
