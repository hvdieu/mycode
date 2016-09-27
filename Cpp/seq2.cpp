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
#define BASE 1000000007

int n, k, res, p[N];
int f[25][N], g[N];
int gt[N], gt2[N];
vector<int> pp;

void sieve() {
    int ss = trunc(sqrt(n));
    For(i, 2, ss) if (!p[i])
    for(int j = i*i; j <= n; j += i) p[j] = i;
}

void add(int &a, int b) {
    a += b; if (a >= BASE) a -= BASE;
}

int mu(int a, int n) {
    int res = 1;
    while (n) {
        if (n & 1) res = (ll(res) * a) % BASE;
        n >>= 1;
        a = (ll(a) * a) % BASE;
    }
    return res;
}

int C(int k, int n) {
    if (n < k) return 0;
    int x = (ll(gt2[k]) * gt2[n-k]) % BASE;
    x = (ll(gt[n]) * x) % BASE;
    return x;
}

int cal(int x) {
    pp.clear();
    int xx = x;
    int len = 0;
    while (p[x]) {
        int j = p[x];
        int dem = 0;
        while (x % j == 0) dem++, x /= j;
        len += dem; pp.pb(dem);
    }
    if (x > 1) len++, pp.pb(1);
    int seq = gt[len];
  //  cout << pp[0] << endl;
    For(i, 0, sz(pp)-1) seq = (ll(seq) * mu(gt[pp[i]], BASE-2)) % BASE;
    int res = C(1, k);
    For(dd, 2, len) {
    	int y1 = C(dd, k);
    	int y2 = C(dd-1, len-1);
        int y = (ll(y1)*y2) % BASE; y = (ll(y) * seq) % BASE;
        add(res, y);
    }
    return res;
}

int main() {
    freopen("input.txt","r",stdin);
  //  freopen("output.txt","w",stdout);
    cin >> n >> k;
    k--;
    gt[0] = 1;
    For(i, 1, 100000) {
        gt[i] = (ll(gt[i-1])*i) % BASE;
        gt2[i] = mu(gt[i], BASE-2);
    }
    int t = 0;
    if (max(k, n) >= 2000) {
        For(i, 1, n) f[0][i] = 1;
        For(i, 1, k-1) {
            reset(f[1-t], 0);
            For(j, 1, n)
            for(int kk = j; kk <= n; kk += j) add(f[1-t][kk], f[t][j]);
            t = 1 - t;
        }
     //   For(i, 1, n) printf("%d ", f[t][i]); printf("\n");
    }
//   else
    {
    	f[0][1] = 1;
        For(i, 2, n) f[1][i] = 1;
        For(i, 1, 17) {
            For(j, 2, n)
            for(int kk = j*2; kk <= n; kk += j)
			add(f[i+1][kk], f[i][j]);
        }
        t = 20;
        For(i, 1, n)
		For(len, 0, 17)
		add(f[t][i], (ll(f[len][i]) * C(len, k)) % BASE);
	//	For(i, 1, n) printf("%d ", f[t][i]); printf("\n");
    }
    For(x, 1, n) {
        add(g[x], (g[x-1] + f[t][x]) % BASE);
    }
        //printf("\n");
        For(x, 1, n)
		if (k >= 1) add(res, g[n / x]); else res++;
        cout << res;
}
