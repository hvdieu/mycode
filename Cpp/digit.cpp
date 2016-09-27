#include <vector>
#include <algorithm>
#include <math.h>
#include <iostream>
#include <stdio.h>
#include <string.h>
#include <cmath>
#include <cstring>
#include <queue>
#include <stack>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;
typedef vector<int> bignum;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ld long double
#define pb push_back
#define all(x) x.begin(), x.end()
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 400

string a;
int bit[N], n;
bignum f[N][4];
bool check[N][4];

string operator / (const string &a, const int &b) {
    string c;
    c.clear();
    int nho = 0, s = 0;
    For(i, 0, sz(a)-1) {
        nho = nho * 10 + int(a[i]) - int('0');
        s = nho / b;
        nho = nho % b;
        c += char(s + int('0'));
    }
    while (sz(c) > 1 && c[0] == '0') c.erase(0, 1);
    return c;
}

bignum operator + (bignum a, bignum b) {
    bignum c;
    c.clear();
    int nho = 0;
    reverse(a.begin(), a.end()); reverse(all(b));
    For(i, 0, max(sz(a), sz(b))-1) {
        int x = nho;
        if (i < sz(a)) x += a[i];
        if (i < sz(b)) x += b[i];
        nho = x / 10; x = x % 10;
        c.pb(x);
    }
    if (nho) c.pb(nho);
    reverse(all(c));
    return c;
}

void tach(string a) {
    n = 0;
    while (a != "0") {
        bit[++n] = (int(a[sz(a)-1]) - int('0')) % 2;
        a = a / 2;
    //    cout << a << endl;
    }
}

void ghi(bignum a) {
    For(i, 0, sz(a)-1) printf("%d", a[i]);
    printf("\n");
}

bignum cal(int i, int j) {
    bignum res; res.clear(); res.pb(0);
    if (i == 0) {
        if (j) return res;
        res[0]++; return res;
    }
    if (check[i][j]) return f[i][j];
    For(k, 0, min(2, j)) {
        int nho = j - k;
        nho = nho*2 + bit[i-1];
        if (nho <= 3)
		res = res + cal(i-1, nho);
    }
    check[i][j] = true;
    f[i][j] = res;
    return f[i][j];
}

int main() {
   // freopen("digit.inp","r",stdin);
   // freopen("digit.out","w",stdout);
    while (1) {
        cin >> a;
        if (a[0] == '-') break;
        tach(a);
        For(i, 0, n) For(j, 0, 3) {
            f[i][j].clear(); f[i][j].pb(0);
        }
        reset(check, false);
        ghi(cal(n, bit[n]));
    }
}
