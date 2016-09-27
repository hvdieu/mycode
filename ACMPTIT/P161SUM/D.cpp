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
#define N 5

int n, a[N][N], b[N][N];
bool fr[N][N];

void xoay() {
    For(i, 1, n) For(j, 1, n) b[n-j+1][i] = a[i][j];
    For(i, 1, n) For(j, 1, n) a[i][j] = b[i][j];
}

void don() {
    reset(fr, true);
    For(i, 1, n) a[i][0] = 1;
    For(i, 1, n) For(j, 1, n) if (a[i][j] != 0) {
        Rep(k, j-1, 0) if (a[i][k] != 0) {
            if (a[i][k] == a[i][j] && fr[i][k]) {
                a[i][k] *= 2; a[i][j] = 0;
                fr[i][k] = false; break;
            } else {
                int x = a[i][j];
                a[i][j] = 0; a[i][k+1] = x; break;
            }
        }
    }
}

int main() {
   // freopen("in.txt","r",stdin);
    //freopen("","w",stdout);
    char ch; cin >> ch;
    n = 4;
    For(i, 1, n) For(j, 1, n) cin >> a[i][j];

    int x;
    if (ch == 'L') x = 0;
    else if (ch == 'U') x = 1;
    else if (ch == 'R') x = 2;
    else x = 3;
    For(i, 1, x) xoay();
  //  For(i, 1, n) {
   //     For(j, 1, n) cout << a[i][j] << ' '; cout << endl;
    //}
    //cout << endl;
    don();
    //For(i, 1, n) {
    //    For(j, 1, n) cout << a[i][j] << ' '; cout << endl;
    //}
    //cout << endl;
    For(i, 1, 4-x) xoay();
    For(i, 1, n) {
        For(j, 1, n) cout << a[i][j] << ' ';
        cout << endl;
    }
}
