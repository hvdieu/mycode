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
#define two(x) (1ULL << x)
#define getbit(x, i) ((x >> (i)) & 1ULL)
#define onbit(x, i) (x | (1ULL << (i-1)))
#define offbit(x, i) (x & ~(1ULL << (i-1)))

struct matrix {
    long long h[4][4];
};

const int base[4][4] = {
    {1, 0, 1, 0},
    {0, 1, 0, 1},
    {1, 0, 0, 1},
    {0, 1, 0, 1}
};

unsigned long long n, k;
int l, m;
matrix c, a;
long long f[2];

matrix operator * (const matrix &a, const matrix &b) {
    matrix c;
    REP(i, 4) REP(j, 4) {
        c.h[i][j] = 0;
        REP(k, 4) c.h[i][j] = (c.h[i][j] + (a.h[i][k] * b.h[k][j]) % m) % m;
    }
    return c;
}

matrix pw(matrix a, long long n) {
    if (n == 1) return a;
    matrix c = pw(a, n/2);
    c = c * c;
    if (n % 2) c = c * a;
    return c;
}

int main() {
    freopen("in.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> n >> k >> l >> m;
    REP(i, 4) REP(j, 4) c.h[i][j] = base[i][j] % m;
    a.h[0][0] = a.h[0][2] = 1;
    c = pw(c, n-1);
    a = a * c;
    f[0] = (a.h[0][0] + a.h[0][2]) % m;
    f[1] = (a.h[0][1] + a.h[0][3]) % m;
    //cout << f[0] << ' ' << f[1] << "\n";
    if (!l) {
        if (k == 0) cout << 1 % m << "\n"; else cout << 0 <<"\n";
    } else {
        long long ans = 1;
        REP(i, l) ans = (ans * f[getbit(k, i)]) % m;
        For(i, l, 63) if (getbit(k, i)) ans = 0;
        cout << ans % m << "\n";
    }
    //ll tmp = 0;
    //REP(i, two(l)) REP(j, two(l)) REP(t, two(l)) REP(w, two(l))
    //    if (((i & j) | (j & t) | (t & w)) == k) tmp++;
    //cout << tmp << "\n";
}


