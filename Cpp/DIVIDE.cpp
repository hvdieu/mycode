#include <bits/stdc++.h>

using namespace std;

typedef long long ll;
typedef long double ld;
typedef pair<int, int> ii;

#define For(i, a, b) for(int i = a; i <= b; i++)
#define Rep(i, a, b) for(int i = a; i >= b; i--)
#define all(x) x.begin(), x.end()
#define sz(x) int(x.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define pb push_back
#define fi first
#define se second
#define two(x) (1LL << x)
#define bit(x, i) ((x >> (i-1)) & 1)
#define onbit(x, i) (x | (1LL << (i-1)))
#define N 5010
#define TT 1048578

struct triple {
    int a, b, id;
};

bool cmp(triple a, triple b) {
    return a.a < b.a;
}

int n, f[TT], g[N][N], dd[N][N], vt[N];
ii trace[TT];
triple l[N];

void truyvet(int tt) {
    if (!tt) return;
    int i = trace[tt].fi, j = trace[tt].se;
    cout << l[i].id << ' ' << l[j].id << endl;
    truyvet(tt - two(i-1) - two(j-1));
}

void sub1() {
    int T = two(n) - 1;
    For(tt, 0, T) {
        int x = __builtin_popcount(tt);
        if (x % 2 == 0) {
            For(i, 1, n) if (!bit(tt, i))
            For(j, i+1, n) if (!bit(tt, j)) {
                int cp = l[i].b;
                int t1 = tt + two(i-1) + two(j-1);
                if (f[t1] < f[tt] + cp) {
                    f[t1] = f[tt] + cp;
                    trace[t1] = ii(i, j);
                }
            }
        }
    }
    cout << f[T] << endl;
    truyvet(T);
}

bool check() {
    For(i, 1, n) if (l[i].a != l[i].b) return false;
    return true;
}

void sub2() {
    int res = 0;
    for(int i = 1; i < n; i += 2) res += l[i].b;
    cout << res << endl;
    for(int i = 1; i < n; i += 2) cout << l[i].id << ' ' << l[i+1].id << endl;
}

void truyvet2(int i, int soa) {
    if (i == 0) return;
    vt[i] = dd[i][soa];
    truyvet2(i-1, soa - dd[i][soa]);
}

void sub3() {
    reset(g, 0xff);
    g[0][0] = 0;
    For(i, 0, n-1) For(soa, 0, i / 2) if (g[i][soa] >= 0) {
        int sob = i - soa;
        if (soa <= sob) {
            // i+1 thang a lay
            if (soa + 1 <= i - soa) {
                if (g[i+1][soa+1] < g[i][soa]) {
                    g[i+1][soa+1] = g[i][soa];
                    dd[i+1][soa+1] = 1;
                }
            }

            // i+1 thang b lay
            if (g[i+1][soa] < g[i][soa] + l[i+1].b) {
                g[i+1][soa] = g[i][soa] + l[i+1].b;
                dd[i+1][soa] = 0;
            }
        }
    }
    cout << g[n][n/2] << endl;
    truyvet2(n, n/2);
    For(i, 1, n) if (!vt[i]) {
        vt[i] = -1;
        cout << l[i].id << ' ';
        For(j, i+1, n) if (vt[j] == 1) {
            cout << l[j].id << endl;
            vt[j] = -1;
            break;
        }
    }
}

int main() {
    //freopen("DIVIDE.INP", "r", stdin);
    //freopen("DIVIDE.OUT", "w", stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d", &l[i].a);
    For(i, 1, n) scanf("%d", &l[i].b);
    For(i, 1, n) l[i].id = i;
    sort(l+1, l+n+1, cmp);
   // if (n <= 20) sub1();
   // else
   // if (check()) sub2();
   // else
    sub3();
}
