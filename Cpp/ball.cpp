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
#define N 1010
#define BASE int(1e9 + 7)

int n;
ll f[N][2*N], g[100][100][100];

void add(ll &a, ll b) {
    a += b; if (a >= BASE) a -= BASE;
}

void init() {
    reset(f, 0);
    f[1][1] = 2;
    For(len, 1, 1000) For(k, 1, 2*len) {
        int num = 2*len;
        add(f[len][k+1], (f[len][k] * (num - k)) % BASE);
        add(f[len+1][k+1], (f[len][k] * 4) % BASE);
    }
}

int trau() {
    reset(g, 0);
    For(i, 1, n) g[i][i][1] = 2;
    For(k, 1, 2*n-1) For(i, 1, n) For(j, i, n) {
        ll num = 2*(j-i+1);
        ll x = (g[i][j][k] * (num-k)) % BASE;
        add(g[i][j][k+1], x);
        add(g[i][j+1][k+1], (2LL*g[i][j][k]) % BASE);
        add(g[i-1][j][k+1], (2LL*g[i][j][k]) % BASE);
    }
    return g[1][n][2*n];
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("ball.inp","r",stdin);
    freopen("ball.out","w",stdout);
    int ntest;
    cin >> ntest;
    init();
    For(test, 1, ntest) {
        cin >> n;
        cout << f[n][2*n] << endl;
    }
}
