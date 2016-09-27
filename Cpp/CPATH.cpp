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
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 1001
#define BASE 1000003

int n;
char a[N][N], s[2*N];
int f[N][N];

void add(int &a, int b) {
    a += b; if (a >= BASE) a-= BASE;
}

int main() {
    freopen("cpath.inp","r",stdin);
    freopen("cpath.out","w",stdout);
    scanf("%d\n", &n);
    For(i, 1, n) scanf("%s\n", a[i]+1);
    scanf("%s", s+1);
    if (a[1][1] == s[1]) f[1][1] = 1;
    For(t, 1, 2*n - 2) For(i, 1, n) {
        int j = t-i+1;
        if (j > 0 && j <= n) {
            For(h, 0, 1) For(c, 0, 1) if (h + c == 1) {
                int u = i + h, v = j + c;
                if (u <= n && v <= n && a[u][v] == s[t+1]) add(f[u][v], f[i][j]);
            }
        }
    }
    cout << f[n][n];
}
