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

const int N = (1 << 10) + 5;

int a[N][N], n;
vector<int> val;

ll cal(int i, int j, int n) {
    if (n < 0) return 0;
    return a[i][j] + cal(i, j, n-1) + cal(i, j + two(n-1), n-1) + cal(i + two(n-1), j, n-1) + cal(i+two(n-1), j+two(n-1), n-1);
}

int main() {
    //freopen("in.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> n;
    REP(i, two(2*n)) {
        int x; cin >> x; val.pb(x);
    }
    sort(all(val)); reverse(all(val));
    int len = n;
    int MAX = 1 << n;
    int k = 0;
    long long ans = 0;
    while (len >= 0) {
        for(int i = 1; i <= MAX; i += two(len))
            for(int j = 1; j <= MAX; j += two(len)) {
                if (!a[i][j]) {
                    a[i][j] = val[k++];
                    ans += ll(a[i][j]) * (len+1);
                }
            }
        len--;
    }
    cout << ans << "\n";
   /* For(i, 1, MAX) {
       For(j, 1, MAX) cout << a[i][j] << ' ';
        cout << "\n";
    } */
}


