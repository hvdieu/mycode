#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1 << x)
#define bug(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 110
#define BASE 1000000007

int n, a[N];
ll res, f[N][N], g[N][N];
bool check[N][N];

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d", &a[i]);
    For(i, 1, n) For(j, i+1, n) if (a[i] + a[j] == 0 && a[i] < 0 && a[j] > 0) f[i][j] = g[i][j] = 1;
    For(len, 3, n) For(i, 1, n-len+1) {
        int j = i+len-1;
        if (a[i] < 0 && a[j] > 0 && a[i]+a[j] == 0) {
            For(k, i+1, j-1) f[i][j] = (f[i][j] + g[k][j-1]) % BASE;
        }
        if (a[j] > 0) For(k, i+1, j-1) if (a[k] + a[j] == 0)
            f[i][j] = (f[i][j] + (g[i][k-1] * f[k][j]) % BASE) % BASE;
        g[i][j] = (g[i][j-1] + f[i][j]) % BASE;
    }
    res = 1;
    For(i, 1, n) For(j, i+1, n) res = (res + f[i][j]) % BASE;
    cout << res;
}




