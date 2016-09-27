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
#define N 100010

int n, q, a[N], f[2][N];

int gcd(int a, int b) {
    if (!b) return a;
    return gcd(b, a % b);
}

int main() {
   // freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    int ntest; scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d %d", &n, &q);
        For(i, 1, n) scanf("%d", a+i);
        f[0][1] = a[1]; For(i, 2, n) f[0][i] = gcd(f[0][i-1], a[i]);
        f[1][n] = a[n]; Rep(i, n-1, 1) f[1][i] = gcd(f[1][i+1], a[i]);
        while (q) {
            q--;
            int res = 0;
            int l, r; scanf("%d%d", &l, &r);
            if (l > 1) res = f[0][l-1];
            if (r < n) if (!res) res = f[1][r+1];
            else res = gcd(res, f[1][r+1]);
            printf("%d\n", res);
        }
    }
}




