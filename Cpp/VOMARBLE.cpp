#include <stdio.h>
#include <iostream>
#include <algorithm>
#include <math.h>
#include <vector>
#include <string>
#include <cstring>
#include <map>
#include <set>
#include <queue>
#include <stack>

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
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 1010
#define BASE 1000000007
#define p 61

struct hard {
    int kind;
    ll pos;
    char ch;
};

struct matrix {
    int h[62][62];
};

ll n;
int m, k, f[N][62];
bool dd[N][N], can[N][62];
hard q[N];
matrix Mbase;

int ord(char ch) {
    if (ch >= 'a' && ch <= 'z') return int(ch - 'a');
    if (ch >= 'A' && ch <= 'Z') return 26 + int(ch - 'A');
    return 52 + int(ch - '0');
}

void input() {
    freopen("input.txt","r",stdin);
    freopen("vomarble.out","w",stdout);
    scanf("%lld %d %d\n", &n, &m, &k);
    reset(dd, true);
    For(i, 1, m) {
        char c1, c2;
        scanf("%c %c\n", &c1, &c2);
        int u = ord(c1), v = ord(c2);
        dd[u][v] = false; dd[v][u] = false;
    }
    For(i, 1, k) scanf("%d %lld %c\n", &q[i].kind, &q[i].pos, &q[i].ch);
}

void sub1() {
    reset(can, true);
    For(i, 1, k) {
        int kind = q[i].kind, pos = q[i].pos;
        char ch = q[i].ch;
        if (kind == 0) can[pos][ord(ch)] = false;
        else For(kt, 0, p) if (kt != ord(ch)) can[pos][kt] = false;
    }
    For(ch, 0, p) if (can[1][ch]) f[1][ch] = 1;
    For(i, 2, n) For(c2, 0, p) if (can[i][c2])
    For(c1, 0, p) if (dd[c1][c2])
    f[i][c2] = (f[i][c2] + f[i-1][c1]) % BASE;
    int res = 0;
    For(ch, 0, p) res = (res + f[n][ch]) % BASE;
    cout << res;
}

bool cmp(hard a, hard b) {
    return a.pos < b.pos;
}

int mypow(ll a, ll n) {
    ll res = 1;
    while (n) {
        if (n & 1) res = (res * a) % BASE;
        n >>= 1;
        a = (a * a) % BASE;
    }
    return res;
}

void sub2() {
    sort(q+1, q+k+1, cmp);
    ll res = 1;
    int i = 1;
    bool fr[62];
    int dem = 0;
    while (i <= k) {
        dem++;
        int j = i; reset(fr, true);
        while (j < k && q[i].pos == q[j+1].pos) j++;
        For(t, i, j) {
            int kind = q[t].kind, pos = q[t].pos;
            char ch = q[t].ch;
            if (kind == 0) fr[ord(ch)] = false;
            else For(kt, 0, p) if (kt != ord(ch)) fr[kt] = false;
        }
        int sc = 0;
        For(kt, 0, p) if (fr[kt]) sc++;
        res = (res * sc) % BASE;
        i = j + 1;
    }
    res = (res * mypow(62, n-dem)) % BASE;
    cout << res;
}

matrix operator * (matrix a, matrix b) {
    matrix c;
    For(i, 0, p) For(j, 0, p) {
        c.h[i][j] = 0;
        For(k, 0, p) c.h[i][j] = (ll(c.h[i][j]) + (ll(a.h[i][k]) * b.h[k][j]) % BASE) % BASE;
    }
    return c;
}

matrix Mpow(matrix a, ll n) {
    matrix res = Mbase;
    while (n) {
        if (n & 1) res = res * a;
        n >>= 1;
        a = a * a;
    }
    return res;
}

void sub3() {
    matrix a, b;
    reset(a.h, 0); reset(b.h, 0);
    For(i, 0, p) a.h[0][i] = 1;
    For(c1, 0, p) For(c2, 0, p)
    if (dd[c1][c2]) b.h[c2][c1] = 1;
    reset(Mbase.h, 0); For(i, 0, 61) Mbase.h[i][i] = 1;
    b = Mpow(b, n-1);
    a = a * b;
    ll res = 0;
    For(i, 0, p) res = (res + a.h[0][i]) % BASE;
    cout << res;
}

void sub4() {
    sort(q+1, q+k+1, cmp);
    matrix a, b;
    For(i, 0, p) a.h[0][i] = 1;
    For(c1, 0, p) For(c2, 0, p)
    if (dd[c1][c2]) b.h[c2][c1] = 1;
    reset(Mbase.h, 0); For(i, 0, 61) Mbase.h[i][i] = 1;
    int i = 1;
    ll t = 1;
    bool fr[62];
    matrix e;
    while (i <= k) {
        int j = i;
        e = Mpow(b, q[i].pos - t); t = q[i].pos;
        a = a * e;
        reset(fr, true);
        while (j < k && q[i].pos == q[j+1].pos) j++;
        For(tt, i, j) {
            int kind = q[tt].kind, pos = q[tt].pos;
            char ch = q[tt].ch;
            if (kind == 0) fr[ord(ch)] = false;
            else For(kt, 0, p) if (kt != ord(ch)) fr[kt] = false;
        }
        For(kt, 0, p) if (!fr[kt]) a.h[0][kt] = 0;
        i = j + 1;
    }
    e = Mpow(b, n - t); a = a * e;
    ll res = 0;
    For(i, 0, p) res = (res + a.h[0][i]) % BASE;
    cout << res;
}

void solve() {
    if (n <= 1000 && m <= 100 && k <= 100) sub1();
    else if (m == 0) sub2();
    else if (k == 0) sub3();
    else
    sub4();
}

int main() {
    input();
    solve();
}




