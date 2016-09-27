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
#define N 101

int n, m, ntest, a[N][N];

int main() {
    srand(time(NULL));
   // freopen("","r",stdin);
    freopen("star.inp","w",stdout);
    ntest = 10;
    cout << ntest << endl;
    For(test, 1, ntest) {
        n = 5 + rand() % 5;
        reset(a, 0);
        m = 0;
        For(i, 1, n*(n+1)/2) {
            int u = rand() % n, v = rand() % n;
            a[u][v] = a[v][u] = 1;
        }
        REP(u, n) REP(v, u) if (a[u][v]) m++;
        cout << n << ' ' << rand() % n + 1 << ' ' << m << endl;
        REP(u, n) REP(v, u) if (a[u][v]) {
            if (rand() % 2 == 1) cout << u+1 << ' ' << v+1 << endl;
            else cout << v+1 << ' ' << u+1 << endl;
        }
    }
}


