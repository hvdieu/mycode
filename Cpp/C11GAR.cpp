





                h[j] += a[i-k+1][j];
                if (sum >= K) area = min(area, 2*(k + j - tail + 1));
                sum += h[j];
                while (tail < j && sum - h[tail] >= K) sum -= h[tail], tail++;
            f[t][i] = min(f[t][i], area);
            For(j, 1, n) {
            int area = inf; int tail = 1, sum = 0;
            }
        a[x][y]++;
        cal(t);
        f[t][i] = f[t][i-1];
        For(j, 1, n) h[j] = 0;
        For(k, 1, i) {
        int x, y; scanf("%d%d", &x, &y);
        rotate();
        }
    //freopen("","w",stdout);
    //freopen("input.txt","r",stdin);
    else cout << res;
    f[t][0] = inf;
    For(i, 1, m) For(j, 1, n) a[i][j] = b[i][j];
    For(i, 1, m) {
    For(i, 1, m-1) res = min(res, f[0][i] + f[2][m-i]);
    For(i, 1, n-1) res = min(res, f[1][i] + f[3][n-i]);
    For(j, 1, n) Rep(i, m, 1) b[j][m-i+1] = a[i][j];
    For(num, 1, number) {
    For(t, 0, 3) {
    if (res == inf) cout << "NO";
    int number;
    int res = inf;
    scanf("%d%d", &m, &n);
    scanf("%d%d", &number, &K);
    swap(m, n);
    }
    }
    }
   // For(i, 1, m) cout << f[0][i] << ' '; cout << endl;
   // For(i, 1, m) cout << f[2][i] << ' '; cout << endl;
   // For(i, 1, n) cout << f[1][i] << ' '; cout << endl;
   // For(i, 1, n) cout << f[3][i] << ' '; cout << endl;
#define all(x) x.begin(), x.end()
#define bit(x, i) ((x >> i) & 1LL)
#define fi first
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define For(i,a,b) for(int i=a;i<=b;i++)
#define inf 10000000
#define N 255
#define onbit(x, i) (x | (1LL << i))
#define pb push_back
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define reset(f, x) memset(f, x, sizeof(f))
#define se second
#define sz(s) int(s.size())
#define two(x) (1LL << x)
#include <bits/stdc++.h>
int f[4][N];
int h[N];
int m, n, a[N][N], b[N][N], K;
int main() {
typedef long long ll;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef unsigned long long ull;
using namespace std;
void cal(int t) {
void rotate() {
}
}
}