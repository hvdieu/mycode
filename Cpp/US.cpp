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
#define N 1000010

int n, p[N];
ull a[N], b[N];

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    int n = 1000000, ss = trunc(sqrt(n));
    For(i, 2, ss) if (!p[i])
    for(int j = i*i; j <= n; j += i) p[j] = i;
    For(i, 1, n) {
        int x = i;
        int souoc = 1; ull tonguoc = 1;
        while (p[x]) {
            int j = p[x];
            ull pow = j; int mu = 1;
            while (x % j == 0) {
                mu++; pow *= j;
                x /= j;
            }
            tonguoc *= (pow - 1) / (j - 1);
            souoc *= mu;
        }
        if (x > 1) tonguoc *= (ull(x)*x - 1) / (x - 1), souoc *= 2;
        a[i] = a[i-1] + souoc;
        b[i] = b[i-1] + tonguoc;
    }
    int ntest;
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        int u, v; scanf("%d%d", &u, &v);
        if (u > v) swap(u, v);
        printf("%lld %lld\n", a[v] - a[u-1], b[v] - b[u-1]);
    }
}
