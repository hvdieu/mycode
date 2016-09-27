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
const int N = 7;

int n, b[N*N][N*N];
char s[N][N];
char kq[40][40];
int a[7][7];

void change(int i) {
    int x = a[i][n];
    Rep(j, n, 2) a[i][j] = a[i][j-1];
    a[i][1] = x;
}

ii id(int x) {
    int i = 0, j = 0;
    while (x >= n) x -= n, i++;
    if (x) i++;
    if (!x) j = n; else j = x;
    return ii(i, j);
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("ndocu.inp","r",stdin);
    freopen("ndocu.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%s\n", s[i]+1);
    int x = 0;
    For(i, 1, n) For(j, 1, n) a[i][j] = ++x;
    int block = 0;
    int first = 1;
    For(i, 1, n*n) {
        block++; if (block > n) {
            block = 1;
            For(ii, 1, n) change(ii);
        }
        int j = 0;
        For(jj, block, n) For(kk, 1, n) b[i][++j] = a[jj][kk];
        For(jj, 1, block-1) For(kk, 1, n) b[i][++j] = a[jj][kk];
    }
    For(i, 1, n*n) {
        For(j, 1, n*n) {
            ii x = id(b[i][j]);
           // cout << x.fi << ' ' << x.se << ' ';
            printf("%c", s[x.fi][x.se]);
        }
        printf("\n");
    }
}
