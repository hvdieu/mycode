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
#define N 1010

int m, n, a[N][N], g[N], h[N], p[N], top;
ll res, f[N];

void solve() {
    For(i, 1, m) {
        For(j, 1, n) {
            if (a[i][j] == a[i-1][j]) h[j]++; else h[j] = 1;
            if (a[i][j] == a[i][j-1]) g[j] = g[j-1] + 1; else g[j] = 1;
        }
        top = 0; p[top] = 0;
        For(j, 1, n) {
            while (top && h[p[top]] >= h[j]) top--;
            int len = j - p[top];
            if (len < g[j]) f[j] = f[p[top]] + ll(len) * h[j];
            else f[j] = ll(g[j]) * h[j];
            res += f[j];
            p[++top] = j;
        }
    }
    cout << res;
}

int main() {
    freopen("bob.inp","r",stdin);
    freopen("bob.out","w",stdout);
    scanf("%d%d", &m, &n);
    For(i, 1, m) For(j, 1, n) scanf("%d", &a[i][j]);
    solve();
}


