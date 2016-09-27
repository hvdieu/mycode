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

ll a, n, M, res;
int ntest, len, base;

int mu(int a, ll n) {
    int res = 1;
    while (n) {
        if (n & 1) res = (ll(res)*a) % M;
        n >>= 1;
        a = (ll(a)*a) % M;
    }
    return res;
}

int cal(int a, ll n) {
    if (n == 1) return a % M;
    int l = cal(a, n/2), r;
    int temp;
    if (n % 2 == 0) r = l, temp = mu(base, n/2);
    else r = (ll(l)*base + a) % M, temp = mu(base, (n/2)+1);
    return (ll(l)*temp + r) % M;
}

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    int ntest; cin >> ntest;
    For(test, 1, ntest) {
        cin >> a >> n >> M;
        int x = a; len = 0; base = 1; while (x) { len++; x /= 10; base *= 10; }
        if (a == 0) cout << 0; else cout << cal(a, n); cout << endl;
    }
}
