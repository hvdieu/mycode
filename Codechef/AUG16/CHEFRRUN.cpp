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
#define BUG(x) cout << #x << " = " << x << "\n";
#define ARR(x, n) for(int i = 0; i < n; i++) cout << x[i] << ' '; cout << "\n";

const int N = 1e5 + 5;

int n, a[N], ntest, ans, timer, start, f[N];

int main() {
    ios_base::sync_with_stdio(false);
    //freopen("in.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> ntest;
    while (ntest--) {
        cin >> n;
        REP(i, n) cin >> a[i], f[i] = 0;
       // ARR(a, n);
        ans = 0;
        timer = 0;
        REP(i, n)
            if (!f[i]) {
                start = timer;
                int u = i;
                while (true) {
                    f[u] = ++timer;
                    int v = (u + a[u] + 1) % n;
                    if (!f[v]) u = v;
                    else if (f[v] <= start) break;
                    else {
                        ans += timer - f[v] + 1;
                        break;
                    }
                }
            }
        cout << ans << "\n";
    }
}


