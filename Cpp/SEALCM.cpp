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

int n, ntest, m, l, r, f[N][N];

int gcd(int a, int b) {
    if (!b) return a;
    return gcd(b, a % b);
}

int lcm(int a, int b) {
    return (a * b) / gcd(a, b);
}

void add(int &a, int b) {
    a += b;
    if (a >= BASE) a %= BASE;
}

void solve() {
    reset(f, 0);
    f[0][1] = 1;
    For(i, 0, n-1) For(x, 1, m) if (f[i][x]) {
        For(y, 1, m) {
            int z = lcm(x, y);
            if (z <= m) add(f[i+1][z], f[i][x]);
        }
    }
    int res = 0;
    For(x, l, r) For(y, 1, m) if (x % y == 0) add(res, f[n][y]);
    cout << res << endl;
}

int main() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> ntest;
    while (ntest) {
        ntest--;
        cin >> n >> m >> l >> r;
        solve();
    }
}




