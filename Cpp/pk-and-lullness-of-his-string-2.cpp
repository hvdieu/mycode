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
#define BASE 1000000007

int n, ntest, k;
char s[N];
int sum[N];
ll res, gt[N];

ll mu(int a, int n) {
    ll res = 1;
    while (n) {
        if (n & 1) res = (res * a) % BASE;
        n >>= 1;
        a = (ll(a)*a) % BASE;
    }
    return res;
}

int C(int k, int n) {
	if (k == n) return 1;
    return (((gt[n] * mu(gt[n-k], BASE-2)) % BASE) * mu(gt[k], BASE-2)) % BASE;
}

void solve() {
    n = strlen(s+1);
    sum[n+1] = 0;
    Rep(i, n, 1) {
        sum[i] = sum[i+1]; if (s[i] == 'l') sum[i]++;
    }
    int t = 0; res = 0;
    For(i, 1, n) {
        if (s[i] == 'u') if (t >= k && sum[i+1] >= k) {
            ll l = C(k, t), r = C(k, sum[i+1]);
            res = (res + (l*r) % BASE) % BASE;
        }
        if (s[i] == 'l') t++;
    }
    cout << res << endl;
}

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d\n", &ntest);
    gt[1] = 1;
    For(i, 2, 100000) gt[i] = (gt[i-1]*i) % BASE;
    For(test, 1, ntest) {
        scanf("%s %d\n", s+1, &k);
        k = (k-1)/2;
        solve();
    }
}
