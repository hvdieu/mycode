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

int n, a[N], b[N];

int gcd(int a, int b) {
    if (!b) return a;
    return gcd(b, a % b);
}

int main() {
    //ios_base::sync_with_stdio(false);
   // freopen("input.txt","r",stdin);
   // freopen("","w",stdout);
    while (1) {
        scanf("%d", &n);
        if (n == 0) break;
        int ma = 0;
        For(i, 1, n) {
            scanf("%d", a+i);
            ma = max(ma, a[i]);
        }
        int res = 0;
        For(x, 1, ma) {
            For(i, 1, n) if (a[i] % x == 0) b[i] = 1; else b[i] = 0;
            int i = 1;
            while (i <= n) {
                while (i <= n && !b[i]) i++;
                if (i <= n) {
                    int g = 0;
                    int j = i;
                    while (j <= n && b[j]) { g = gcd(a[j], g); j++; }
                    if (g == x) res++;
                    i = j;
                }
            }
        }
        printf("%d\n", res);
    }
}
