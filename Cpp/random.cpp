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
#define ld long double
#define pb push_back
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 64

ll n, x, m, res, f[N][N][2];
int k;
bool check[N][N][2];

ll cal(int i, int used, int ok) {
    if (used > k) return 0;
    if (i < 0) {
        if (used == k) return 1;
        return 0;
    }
    if (check[i][used][ok]) return f[i][used][ok];
    int c, ok1, used1;
    int bit = (n >> i) & 1;
    ll res = 0;
    if (!ok) c = bit; else c = 1;
    For(j, 0, c) {
        if (ok || j < bit) ok1 = 1;
        else ok1 = 0;
        used1 = used + j;
        res += cal(i - 1, used1, ok1);
    }
    f[i][used][ok] = res;
    check[i][used][ok] = true;
    return res;
}

bool kt(ll mid) {
    reset(check, false);
    n = mid;
    ll dem = cal(63,0,0);
    n = mid * 2;
    reset(check, false);
    dem = cal(63,0,0) - dem;
    if (dem >= m) return true;
    return false;
}

void solve() {
    ll d = 1, c = 1000000000000000000LL, mid;
    while (d <= c) {
        mid = (d + c) / 2;
        if (kt(mid)) {
            res = mid; c = mid - 1;
        } else d = mid + 1;
    }
    cout << res << endl;
}

void trau() {
    for(int i = 1;; i++) {
        ll dem = 0;
        For(j,i+1,i*2) if (__builtin_popcount(j) == k) dem++;
        if (dem == m) {
            cout << i;
            return;
        }
    }
}

int main() {
    freopen("random.inp","r",stdin);
    freopen("random.out","w",stdout);
    cin >> m >> k;
    solve();
   // trau();
}
