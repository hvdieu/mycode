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
#define BASE 1000000007
#define N 200010

ll sum[3][N], t[3][4*N], f[3][4*N];
int n, q;

void add(ll &a, ll b) {
    a += b; if (a < 0) a += BASE;
    a %= BASE;
}

void down(int i, int lo, int hi) {
    int mid = (lo + hi) / 2, c1 = i*2, c2 = i*2+1;
    For(k, 0, 2) {
        add(f[k][c1], f[k][i]);
        add(f[k][c2], f[k][i]);
        add(t[k][c1], f[k][i]*(sum[k][mid] - sum[k][lo-1] + BASE));
        add(t[k][c2], f[k][i]*(sum[k][hi] - sum[k][mid] + BASE));
        f[k][i] = 0;
    }
}

void update(int i, int lo, int hi, int u, int v, ll x, int k) {
    if (lo > v || hi < u) return;
    if (u <= lo && hi <= v) {
        add(t[k][i], x*(sum[k][hi] - sum[k][lo-1] + BASE));
        add(f[k][i], x);
        return;
    }
    int mid = (lo + hi) / 2;
    down(i, lo, hi);
    update(i*2, lo, mid, u, v, x, k);
    update(i*2+1, mid+1, hi, u, v, x, k);
    For(kk, 0, 2) t[kk][i] = (t[kk][i*2] + t[kk][i*2+1]) % BASE;
}

ll get(int i, int lo, int hi, int u, int v, int k) {
    if (lo > v || hi < u) return 0;
    if (u <= lo && hi <= v) return t[k][i];
    int mid = (lo + hi) / 2;
    down(i, lo, hi);
    return (get(i*2, lo, mid, u, v, k) + get(i*2+1, mid+1, hi, u, v, k)) % BASE;
}

int main() {
   // freopen("input.txt","r",stdin);
  //  freopen("output.txt","w",stdout);
    scanf("%d%d", &n, &q);
    For(i, 1, n) {
        sum[0][i] = (sum[0][i-1] + (ll(i) * i) % BASE) % BASE;
        sum[1][i] = (sum[1][i-1] + i) % BASE;
        sum[2][i] = sum[2][i-1] + 1;
    }
    For(i, 1, q) {
        int kind, u, v;
        scanf("%d%d%d", &kind, &u, &v);
        if (kind == 1) {
        	u--;
            update(1, 1, n, u+1, v, 1, 0);
            update(1, 1, n, u+1, v, -2*u + 1, 1);
            update(1, 1, n, u+1, v, (ll(u)*u - u) % BASE, 2);
        } else {
            ll a = get(1, 1, n, u, v, 0);
            ll b = get(1, 1, n, u, v, 1);
            ll c = get(1, 1, n, u, v, 2);
            printf("%d\n", (a + b + c) % BASE);
        }
    }
}


