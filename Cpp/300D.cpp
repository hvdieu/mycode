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
#define x first
#define y second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 110

int n;
char s[N];
int a[N][N], b[N][N], dd[N][N];
vector<ii> c, kq;

bool check(int dx, int dy) {
    REP(i, sz(c)) {
        int x = c[i].x + dx, y = c[i].y + dy;
        if (x <= n && y <= n && x > 0 && y > 0 && a[x][y] == 0) return false;
    }
    return true;
}

void fill(int dx, int dy) {
    REP(i, sz(c)) {
        int x = c[i].x + dx, y = c[i].y + dy;
        if (x <= n && y <= n && x > 0 && y > 0) b[x][y] = 1;
    }
}

int main() {
   // freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    scanf("%d\n", &n);
    For(i, 1, n) {
        scanf("%s\n", s+1);
        For(j, 1, n) if (s[j] == 'o') a[i][j] = b[i][j] = 2, c.pb(ii(i, j));
        else if (s[j] == 'x') a[i][j] = 1;
    }
    For(dx, -n+1, n-1) For(dy, -n+1, n-1) if (check(dx, dy)) {
        kq.pb(ii(dx, dy));
        dd[dx + n][dy + n] = 1;
    }
    dd[n][n] = 2;
    REP(i, sz(kq)) {
        fill(kq[i].x, kq[i].y);
       // cout << kq[i].x << ' ' << kq[i].y << endl;
    }
    //For(i, 1, n) {
   //     For(j, 1, n) cout << a[i][j] << ' '; cout << endl;
   // }
    bool ok = true;
    For(i, 1, n) For(j, 1, n) if (a[i][j] == 1 && b[i][j] == 0) ok = false;
    if (!ok) cout << "NO";
    else {
        cout << "YES" << endl;
        For(i, 1, 2*n-1) {
            For(j, 1, 2*n-1) if (dd[i][j] == 2) cout << 'o';
            else if (dd[i][j] == 1) cout << 'x'; else cout << '.';
            cout << endl;
        }
    }
}
