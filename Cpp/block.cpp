#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 100001
#define inf 1000000000000000000LL

int n, k, a[N], st[N], top;
ll f[N][101], g[N], h[N];

int main() {
  //  freopen("input.txt","r",stdin);
   // freopen("output.txt","w",stdout);
    scanf("%d%d", &n, &k);
    For(i, 1, n) scanf("%d", a+i);
    For(i, 1, n) For(j, 1, k) f[i][j] = inf;
    int s = 0;
    For(i, 1, n) {
        s = max(s, a[i]);
        f[i][1] = s;
    }
    For(j, 2, k) {
        top = 0; st[0] = 0; g[0] = inf; h[0] = inf;
        For(i, 1, n) {
            while (top && a[i] >= a[st[top]]) {
                g[top-1] = min(g[top-1], g[top]);
                g[top] = 0;
                top--;
            }
            if (i < j) f[i][j] = inf;
            else f[i][j] = min(g[top] + a[i], h[top]);
            st[++top] = i;
            g[top] = f[i][j-1];
            h[top] = min(h[top-1], f[i][j]);
        }
    }
    cout << f[n][k];
}
