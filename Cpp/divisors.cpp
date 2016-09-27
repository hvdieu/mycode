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
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 100010
#define BASE 1000000007
#define lim 10000

int n, m, a[N], p[N], b[N], kq[N];
int kind[N], x[N], y[N], q;
int t[N];

void sieve() {
    int ss = trunc(sqrt(lim));
    For(i, 2, ss) if (!p[i])
    for(int j = i*i; j <= lim; j += i) p[j] = 1;
}

void update(int i, int x) {
    for(i; i <= n; i += i & (-i)) t[i] += x;
}

int get(int i) {
    int s = 0;
    for(i; i; i -= i & (-i)) s += t[i];
    return s;
}

int sum(int i, int j) {
    return get(j) - get(i-1);
}

void push(int i, int y, int x, int tt) {
    int dem = 0;
    while (y % x == 0) dem++, y /= x;
    update(i, dem*tt);
}

int main() {
    freopen("divisors.inp","r",stdin);
    freopen("divisors.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d", a+i);
    sieve();
    scanf("%d", &q);
    For(i, 1, q) {
        scanf("%d%d%d", kind+i, x+i, y+i);
        if (kind[i]) kq[i] = 1;
    }
    For(prime, 2, lim) if (!p[prime]) {
        reset(t, 0);
        For(i, 1, n) push(i, a[i], prime, 1), b[i] = a[i];
        For(i, 1, q) if (!kind[i]) {
            push(x[i], b[x[i]], prime, -1);
            push(x[i], y[i], prime, 1);
            b[x[i]] = y[i];
        } else {
            kq[i] = (ll(kq[i]) * (sum(x[i], y[i]) + 1)) % BASE;
        }
    }
    For(i, 1, q) if (kind[i]) cout << kq[i] << endl;
}
