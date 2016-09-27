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
#define N 510
#define inf 1000000000

int n, k, x[N], y[N], f[N][N];

int dis(int i, int j) {
    return abs(x[i] - x[j]) + abs(y[i] - y[j]);
}

int main() {
    freopen("marathon.in","r",stdin);
    freopen("marathon.out","w",stdout);
    scanf("%d%d", &n, &k);
    For(i, 1, n) scanf("%d%d", &x[i], &y[i]);
    reset(f, 0x7f);
    f[1][0] = 0;
    For(i, 2, n) For(j, 0, min(i-1, k))
    For(jj, 0, j) f[i][j] = min(f[i][j], f[i-jj-1][j-jj] + dis(i, i-jj-1));
    cout << f[n][k];
}




