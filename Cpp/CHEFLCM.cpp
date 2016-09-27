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
#define N 32000

int n, ntest, prime[N];
vector<int> p;

void sieve() {
    int n = trunc(sqrt(1e9));
    int ss = trunc(sqrt(n));
    For(i, 2, ss) if (!prime[i])
    for(int j = i*i; j <= n; j += i) prime[j] = 1;
    For(i, 2, n) if (!prime[i]) p.pb(i);
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &ntest);
    sieve();
    For(test, 1, ntest) {
        scanf("%d", &n);
        ll res = 1;
        FOR(x, p) if (n % *x == 0) {
            ll pow = *x;
            while (n % *x == 0) {
                n /= *x;
                pow *= *x;
            }
            res *= (pow - 1) / (*x - 1);
        }
        if (n > 1) res *= (ll(n)*n - 1) / (n - 1);
        printf("%lld\n", res);
    }
}
