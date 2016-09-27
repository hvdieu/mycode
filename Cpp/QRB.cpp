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
#define N 1010
#define inf 1000000

int n, ntest, a[N], res;

int main() {
    freopen("input.txt","r",stdin);
    freopen("output.txt","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        printf("Case #%d: ", test);
        scanf("%d", &n);
        int MAX = 0;
        For(i, 1, n) {
            scanf("%d", a+i);
            MAX = max(MAX, a[i]);
        }
        res = inf;
        For(MIN, 1, MAX) {
            int sum = 0;
            For(i, 1, n) if (a[i] > MIN) {
                int x = a[i] - MIN;
                sum += x / MIN;
                if (x % MIN) sum++;
            }
            res = min(res, sum + MIN);
        }
        printf("%d\n", res);
    }
}
