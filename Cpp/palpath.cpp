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
#define N 510
#define BASE 1000000007

const int h[4] = {0, 1, 0, -1};
const int c[4] = {1, 0, -1, 0};

int n;
char s[N][N];
int f[2][N][N];

int dis(int x1, int y1, int x2, int y2) {
    return abs(x1-x2) + abs(y1-y2);
}

bool check(int i, int j) {
    return i && j && i <= n && j <= n;
}

void add(int &a, int b) {
    a += b;
    if (a >= BASE) a -= BASE;
}

int main() {
    freopen("palpath.in","r",stdin);
    freopen("palpath.out","w",stdout);
    scanf("%d\n", &n);
    For(i, 1, n) {
        For(j, 1, n) scanf("%c", &s[i][j]);
        scanf("\n");
    }
    if (s[1][1] == s[n][n]) f[0][1][n] = 1;
    int tt = 0;
    For(t, 0, n-2) {
        reset(f[1-tt], 0);
        For(i, 1, n) {
            int j = t+2 - i;
            if (check(i, j)) {
                For(u, 1, n) if (f[tt][i][u]) {
                    int v = n - (t - (n - u));
                    if (check(u, v)) {
                        For(k1, 0, 1) if (check(i+h[k1], j+c[k1]) && dis(i+h[k1], j+c[k1], 1, 1) == t+1)
                        For(k2, 2, 3) if (check(u+h[k2], v+c[k2]) && dis(u+h[k2], v+c[k2], n, n) == t+1) {
                            int ii = i+h[k1], jj = j+c[k1];
                            int uu = u+h[k2], vv = v+c[k2];
                            if (s[ii][jj] == s[uu][vv]) add(f[1-tt][ii][uu], f[tt][i][u]);
                        }
                    }
                }
            }
        }
        tt = 1 - tt;
    }
    int res = 0;
    For(i, 1, n) add(res, f[tt][i][i]);
    //cout << f[2][1][3];
    cout << res;
}
