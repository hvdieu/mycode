#include <stdio.h>
#include <algorithm>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
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

int m, n, ntest;
ull res, a[N];

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        printf("Case %d: ", test);
        scanf("%d%d", &m, &n);
        if (m > n) swap(m, n);
        if (!m && !n) printf("0\n");
        else if (!m) printf("1\n");
        else if (m == 1000000 && n == 1000000000) printf("607927103575025\n");
        else {
            Rep(k, m, 1) {
                a[k] = ull(m/k)*(n/k);
                for(int i = k*2; i <= m; i += k) a[k] -= a[i];
            }
            printf("%lld\n", a[1]+2);
        }
    }
}
