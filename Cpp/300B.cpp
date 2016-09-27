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
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 1000001

int n, m;
int a[N], trace[N], f[N];

void ql(int x) {
    if (x > n) return;
    a[++m] = x;
    ql(x*10);
    ql(x*10+1);
}

int main() {
    ios_base::sync_with_stdio(false);
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> n;
    ql(1);
    reset(f, 0x7f);
    f[0] = 0;
   // For(i, 1, m) cout << a[i] << ' '; cout << endl;
    For(i, 1, n) For(j, 1, m) if (a[j] <= i && f[i] > f[i-a[j]] + 1) {
        f[i] = f[i-a[j]] + 1;
        trace[i] = a[j];
    }
    cout << f[n] << endl;
    while (n) {
        cout << trace[n] << ' ';
        n -= trace[n];
    }
}
