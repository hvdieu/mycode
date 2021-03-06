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
int n, k, a[N];
ll res;

bool cmp(int a, int b) { return a > b; }

int main() {
    //freopen("","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d", &n, &k);
    For(i, 1, n) scanf("%d", a+i);
    sort(a+2, a+n+1, cmp);
    For(i, 1, n) if (i <= k+1) res += a[i]; else res -= a[i];
    cout << res;
}
