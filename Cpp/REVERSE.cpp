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
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 201
#define inf 1000000000

int n, a[N], b[N], f[N][N][N], g[N];

int main() {
    freopen("reverse.inp","r",stdin);
    freopen("reverse.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d", &a[i]);
    For(i, 1, n) scanf("%d", &b[i]);
    For(i, 0, n) For(j, 0, n) For(k, 0, n) f[i][j][k] = inf;
    For(i, 1, n) g[i] = inf;
    f[0][0][0] = 0; f[1][0][0] = abs(a[1] - b[1]); f[2][1][0] = max(abs(a[1] - b[1]) + abs(a[2] - b[2]), abs(a[1] - b[2]) + abs(a[2] - b[1]));
    For(i, 1, n-1)
}
