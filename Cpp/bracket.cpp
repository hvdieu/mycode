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
#define all(x) x.begin(), x.end()
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 51
#define BASE 100000000
struct bignum {
    int h[50];
};

int n, k;
bignum f[N][N], g[N][N], h[N][N];

bignum operator + (const bignum &a, const bignum &b) {
    bignum c;
    c.h[0] = max(a.h[0],b.h[0]);
    int nho = 0;
    For(i,1,c.h[0]) {
        int x = nho;
        if (i <= a.h[0]) x += a.h[i];
        if (i <= b.h[0]) x += b.h[i];
        c.h[i] = x % BASE;
        nho = x / BASE;
    }
    if (nho) {
        c.h[0]++; c.h[c.h[0]] = nho;
    }
    return c;
}

bignum operator * (const bignum &a,const bignum &b) {
    bignum res;
    ll c[50];
    memset(c,0,sizeof(c));
    c[0] = a.h[0] + b.h[0] - 1;
    For(i,1,a.h[0])
      For(j,1,b.h[0])
        c[i+j-1] += ll(a.h[i])*b.h[j];
    ll nho = 0;
    For(i,1,c[0]) {
        ll x = c[i] + nho;
        nho = x / BASE;
        c[i] = x % BASE;
    }
    if (nho) {
        c[0]++; c[c[0]] = nho;
    }
    res.h[0] = c[0];
    For(i,1,c[0]) res.h[i] = c[i];
    return res;
}

void ghi(bignum a) {
	while (!a.h[a.h[0]]) a.h[0]--;
    cout << a.h[a.h[0]];
    Rep(i,a.h[0]-1,1) {
        int x = a.h[i], len = 0;
        while (x > 0) {
            len++; x /= 10;
        }
        len = 8-len;
        while (len) {
            cout << 0; len--;
        }
        if (a.h[i]) cout << a.h[i];
    }
}


int main() {
    freopen("bracket.inp","r",stdin);
   // freopen("bracket.out","w",stdout);
    n = k = 50;
    For(i, 0, n) For(j, 0, k) {
        f[i][j].h[0] = g[i][j].h[0] = h[i][j].h[0] = 1;
    }
    f[0][0].h[1] = g[0][0].h[1] = h[0][0].h[1] = 1;
    for(int i = 1; i <= n; i++)
        For(j, 1, k) {
            f[i][j] = f[i][j] + f[i-1][j-1];
            g[i][j] = g[i][j-1] + f[i-1][j-1];
            for(int t = 1; t <= i-1; t++)
                f[i][j] = (f[i][j] + (f[t][j] * g[i-t][j])) + h[t][j-1] * (f[i-t-1][j-1]);
            h[i][j] = h[i][j-1] + f[i][j];
        }
    int ntest = 0;
    while (1) {
        scanf("%d%d", &n, &k);
        if (!n && !k) break;
        ntest++;
        if (ntest > 1) printf("\n\n"); printf("Case %d: ", ntest);
        ghi(f[n][k]);
    }
}
