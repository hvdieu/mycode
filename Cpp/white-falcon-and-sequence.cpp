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
#define two(x) (1LL << x)
#define getbit(x, i) ((x >> (i-1)) & 1LL)
#define onbit(x, i) (x | (1LL << (i-1)))
#define offbit(x, i) (x & ~(1 << (i-1)))
#define N 3010

int n, a[N];
ll f[N][N], res;
bool check[N][N];

int main() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d", a+i);
    res = -1000000000000000000;
    For(i, 1, n) For(j, 1, n) f[i][j] = res;
    For(i, 1, n) For(j, i+1, n) f[i][j] = ll(a[i]) * a[j];
    For(len, 2, n) For(i, 1, n-len+1) {
        int j = i+len-1;
        if (i > 1 && j < n)
        f[i-1][j+1] = max(f[i-1][j+1], f[i][j] + ll(a[i-1])*a[j+1]);
    }
    For(i, 1, n) For(j, 1, n) res = max(res, f[i][j]);
    cout << res;
}


