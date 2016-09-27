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

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ld long double
#define pb push_back
#define all(x) x.begin(), x.end()
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 1010
#define BASE 1000000007

int ntest, n, m, f[N], g[N], h[N];

int CalPow(int a, int n) {
    int res = 1;
    while (n) {
        if (n & 1) res = (ll(res) * a) % BASE;
        n >>= 1;
        a = (ll(a) * a) % BASE;
    }
    return res;
}

int main() {
   // freopen("lego.inp","r",stdin);
    //freopen("lego.out","w",stdout);
    scanf("%d", &ntest);
    f[0] = 1;
    For(i, 1, 1000) {
        For(j, 1, min(4, i)) {
            f[i] += f[i-j];
            if (f[i] >= BASE) f[i] -= BASE;
        }
    }
    while (ntest) {
        ntest--;
        scanf("%d%d", &n, &m);
        For(i, 1, m) g[i] = CalPow(f[i], n);
        For(i, 1, m) {
            h[i] = g[i];
            For(j, 1, i-1) h[i] = (h[i] - (ll(h[j]) * g[i-j]) % BASE + BASE) % BASE;
        }
        cout << h[m] << endl;
    }
}
