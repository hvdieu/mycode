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
#define two(i) (ll(1) << i)
#define bit(x, i) ( (x >> i) & 1 )
#define onbit(x, i) ( x | (ull(1) << i ) )
#define N 5010
#define M 20010

int ntest, n, m, p, x[M], y[M], du;
ull res, r3, r2, r1;
unsigned int ke[N][160];

void solve() {
    res = 0; r1 = 0; r2 = 0; r3 = 0;
    For(i, 1, m) {
        int u = x[i], v = y[i];
        int num0 = 0, num1 = 0;
        For(j, 0, p) {
            unsigned int xx = ke[u][j] & ke[v][j];
            num1 += __builtin_popcount(xx);
            xx = ke[u][j] | ke[v][j];
            num0 += 32 - __builtin_popcount(xx);
        }
        num0 -= du;
        r3 += num1; r1 += num0; r2 += n - num0 - num1 - 2;
    }
    ll res = (ll(n) * (ll(n) - 1) * (ll(n) - 2)) / 6;
    res -= r3 / 3 + r2 / 2 + r1;
    cout << r1 << ' ' << r2 / 2 << ' ' << r3 / 3<< endl;
    cout << res << endl;
}

int main() {
    freopen("triple.inp","r",stdin);
  //  freopen("triple.out","w",stdout);
    scanf("%d", &ntest);
    int dem = 0;
    while (ntest) {
        ntest--;
        reset(ke, 0); dem++;
        printf("Case #%d: ", dem);
        scanf("%d%d", &n, &m);
        p = n / 32; if (n % 32 == 0) p--;
        du = 32 - ( n % 32 ); if (du == 32) du = 0;
        For(i, 1, m) {
            int u, v; scanf("%d%d", &u, &v);
            x[i] = u; y[i] = v;
            int x = v / 32, y = v - x * 32 - 1;
            if (v % 32 == 0) {
                x--; y = 31;
            }
            ke[u][x] = onbit(ke[u][x], y);
            x = u / 32, y = u - x * 32 - 1;
            if (u % 32 == 0) {
                x--; y = 31;
            }
            ke[v][x] = onbit(ke[v][x], y);
        }
        solve();
    }
    //cout << __builtin_popcount(two(35)-1);
}
