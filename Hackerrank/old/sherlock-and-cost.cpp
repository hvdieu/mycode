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

int n, f[2][101], b[N], ntest, g[2][101], h[2][101];

int main() {
    freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d", &n);
        For(i, 1, n) scanf("%d", &b[i]);
        reset(f, 0); reset(g, 0);
        f[0][0] = g[0][0] = -1000000;
        For(x, 1, b[1]) {
            f[0][x] = 0; g[0][x] = max(g[0][x-1], f[0][x] - x);
        }
        For(x, b[1]+1, 101) {
            g[0][x] = g[0][x-1];
            h[0][x] = -10000000;
        }
        Rep(x, b[1], 1) h[0][x] = max(h[0][x+1], f[0][x] + x);
        int res = 0;
        int t = 0;
        For(i, 2, n) {
            t = 1 - t;
            h[t][b[i]+1] = -1000000;
            g[t][0] = -10000000;
            For(x, 1, b[i]) {
                f[t][x] = max(g[1-t][x] + x, h[1-t][x+1] - x);
                if (i == n) res = max(res, f[t][x]);
                g[t][x] = max(g[t][x-1], f[t][x] - x);
            }
            For(x, b[i]+1, 100) {
                g[t][x] = g[t][x-1];
                h[t][x] = -10000000;
            }
            Rep(x, b[i], 1) h[t][x] = max(h[t][x+1], f[t][x] + x);
        }
        cout << res << endl;
    }
}




