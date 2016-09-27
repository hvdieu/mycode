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
#define bug(x, i) { return (x >> i) & 1; }
#define N 2000

int n, ntest, k, res, a[N];
int f[N][N];

int main() {
    freopen("input.txt","r",stdin);
  //  freopen("output.txt","w",stdout);
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d%d", &n, &k);
        For(i, 1, n) scanf("%d", &a[i]);
        reset(f, 0); f[0][0] = 1;
        For(i, 1, n) For(c, 0, two(10)-1) {
            f[i][c] = f[i-1][c];
            int b = c ^ a[i];
            f[i][c] |= f[i-1][b];
        }
        res = 0;
        For(c, 0, two(10)-1) if (f[n][c]) res = max(res, k ^ c);
        printf("%d\n", two(10)-1);
    }
}




