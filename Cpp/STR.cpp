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
#define N 1010
#define BASE 1000000007

int m, n, f[N][N], q;
ll res;
char a[N], b[N];

int main() {
    freopen("str.inp","r",stdin);
    freopen("str.out","w",stdout);
    scanf("%s\n", a+1); m = strlen(a+1);
    scanf("%s\n", b+1); n = strlen(b+1);
    Rep(i, m ,1) Rep(j, n, 1)
    if (a[i] != b[j]) f[i][j] = f[i+1][j+1] + 1;
    else f[i][j] = f[i+1][j+1];
    scanf("%d", &q);
    ll x = 0;
    while (q) {
        int i, j, k; q--;
        x++;
        scanf("%d%d%d", &i, &j, &k);
        res = (res + x * (f[i][j] - f[i+k][j+k])) % BASE;
    }
    cout << res;
}
