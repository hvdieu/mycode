#include <bits/stdc++.h>
using namespace std;
typedef pair<long long, long long> ii;
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
#define N 33
#define T (1 << 16) + 1

int n, m, vmax, t;
ll L, R, w[N], v[N], f[T][17], res, maxV;
vector<ii> Q;
vector<ii>::iterator first, last;

int bit(int x, int i) {
    return (x >> i) & 1;
}

void sub1() {
    For(i, 1, n) cin >> w[i] >> v[i];
    For(tt, 1, (1 << n)-1) {
        ll W = 0, V = 0;
        For(i, 1, n) if (bit(tt, i-1)) {
            W += w[i]; V += v[i];
        }
        if (W >= L && W <= R) {
            res++; maxV = max(maxV, V);
        }
    }
    cout << res << endl << maxV;
}

ll get(int i, int j) {
    int k = trunc(log(j-i+1) / log(2));
    return max(f[i][k], f[j - (1 << k) + 1][k]);
}

void init() {
    m = n / 2;
    For(i, 1, m) cin >> w[i] >> v[i];
    For(tt, 0, (1 << m)-1) {
        ll W = 0, V = 0;
        For(i, 1, m) if (bit(tt, i-1)) {
            W += w[i]; V += v[i];
        }
        if (W <= R) Q.pb(ii(W, V));
    }

    sort(Q.begin(), Q.end());
    t = sz(Q);
    vmax = trunc(log(t) / log(2));
    For(i, 0, t-1) f[i][0] = Q[i].se;
    For(j, 1, vmax) For(i, 0, t-(1 << j))
    f[i][j] = max(f[i][j-1], f[i + (1 << (j-1))][j-1]);
}

int low(ll key) {
    int d = 0, c = t-1, mid, ans = -1;
    while (d <= c) {
        mid = (d + c) / 2;
        if (Q[mid].fi >= key) {
            ans = mid; c = mid - 1;
        } else d = mid + 1;
    }
    return ans;
}

int up(ll key) {
    int d = 0, c = t-1, mid, ans = -1;
    while (d <= c) {
        mid = (d + c) / 2;
        if (Q[mid].fi <= key) {
            ans = mid; d = mid + 1;
        } else c = mid - 1;
    }
    return ans;
}

void sub2() {
    init();
    m = n - m;
    For(i, 1, m) cin >> w[i] >> v[i];
    For(tt, 0, (1 << m)-1) {
        ll W = 0, V = 0;
        For(i, 1, m) if (bit(tt, i-1)) {
            W += w[i]; V += v[i];
        }
        if (W <= R) {
            ll left = L - W, right = R - W;
            int u = low(left);
			int v = up(right);
            if (u != -1 && v != -1) {
                res += v-u+1;
                maxV = max(maxV, get(u, v) + V);
            }
        }
    }
    cout << res << endl << maxV;
}

int main() {
    freopen("gem.in","r",stdin);
    freopen("gem.out","w",stdout);
    cin >> n >> L >> R;
    if (n <= 20) sub1(); else
    sub2();
}
