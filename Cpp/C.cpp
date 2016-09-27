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
#define N 100010

int a[N], b[N], c[N], n, suma, sumb;

int main() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d", a+i), suma += a[i];
    For(i, 1, n) scanf("%d", b+i), sumb += b[i];
    For(i, 1, n) c[i] = a[i] - b[i];
    sort(c+1, c+n+1);
    int res = 0; ll sum = 0;
    Rep(i, n, 1) if (sum + c[i] >= 0) {
        sum += c[i]; res++;
    }
    cout << res << endl;
    cout << suma << ' ' << sumb;
}
