#include <bits/stdc++.h>

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
#define N 100010

int n, m, gt[10000000], res;
ll a[N];

void add(int &a, int b) {
    a += b;
    if (a >= m) a -= m;
}

int sum(ll x) {
    ll a = x, b = x+1;
    if (a % 2) b /= 2; else a /= 2;
    a %= m; b %= m;
    return (ll(a)*b) % m;
}

int fac(ll x) {
    if (x >= m) return 0;
    return gt[x];
}

int cal(ll x) {
    int s = sum(x); s = (ll(s)*(x % m)) % m;
    int fact = fac(x+1) - 1; if (fact < 0) fact += m;
    return (s + fact) % m;
}

void solve() {
    if (m == 1) {
        cout << 0; return;
    }
    gt[0] = 1; For(i, 1, m-1) gt[i] = (ll(gt[i-1])*i) % m;
    For(i, 1, n) {
        int x = cal(a[i]); //cout << x << ' ';
        add(res, x);
    }
    cout << res;
}

int main() {
    //ios_base::sync_with_stdio(false);
   // freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d %d", &n, &m);
    For(i, 1, n) scanf("%lld", a+i);
    solve();
}
