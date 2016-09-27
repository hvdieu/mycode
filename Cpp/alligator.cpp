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
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 2010

int a[N][N], m, n, res;
ii trc[N][N][4], sau[N][N][4], last;
bool was[N][N];
queue<ii> q;

void up(int i, int j) { if (a[i][j] >= 0) last = ii(i, j); }

void init() {
    For(j, 1, n) {
        last = ii(0, 0);
        Rep(i, m, 1) { trc[i][j][0] = last; sau[i][j][2] = last; up(i, j); }
        last = ii(0, 0);
        For(i, 1, m) { sau[i][j][0] = last; trc[i][j][2] = last; up(i, j); }
    }

    For(i, 1, m) {
        last = ii(0, 0);
        For(j, 1, n) { trc[i][j][1] = last; sau[i][j][3] = last; up(i, j); }
        last = ii(0, 0);
        Rep(j, n, 1) { sau[i][j][1] = last; trc[i][j][3] = last; up(i, j); }
    }

    For(i, 1, m) For(j, 1, n) if (a[i][j] >= 0 && sau[i][j][a[i][j]] == ii(0, 0)) {
        res++; was[i][j] = true; q.push(ii(i, j));
    }
}

void push(ii x) {
    int i = x.fi, j = x.se;
    if (x == ii(0, 0)) return;
    if (sau[i][j][a[i][j]] == ii(0, 0) && !was[i][j]) {
        was[i][j] = true; q.push(x); res++;
    }
}

void solve() {
    while (!q.empty()) {
        int i = q.front().fi, j = q.front().se; q.pop();
        For(t, 0, 3) {
            ii A = trc[i][j][t], B = sau[i][j][t];
            sau[A.fi][A.se][t] = B; trc[B.fi][B.se][t] = A;
            push(A); push(B);
        }
    }
    cout << res;
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("alligator.inp","r",stdin);
  //  freopen("alligator.out","w",stdout);
    scanf("%d %d\n", &m, &n);
    For(i, 1, m) {
        For(j, 1, n) {
            char c; scanf("%c", &c);
            if (c == '.') a[i][j] = -1;
            else if (c == 'N') a[i][j] = 0;
            else if (c == 'E') a[i][j] = 1;
            else if (c == 'S') a[i][j] = 2; else a[i][j] = 3;
        } scanf("\n");
    }
    init();
    solve();
}
