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
#define N 40010

int m, n;
vector<int> a, b;
int r1, r2, k;

int main() {
  //  freopen("input.txt","r",stdin);
   // freopen("output.txt","w",stdout);
    cin >> m >> n >> k;
    a.pb(0); a.pb(m+1);
    b.pb(0); b.pb(n+1);
    For(i, 1, k) {
        int x, y; cin >> x >> y;
        a.pb(x); b.pb(y);
    }
    sort(all(a)); sort(all(b));
    For(i, 0, sz(a)-2) r1 = max(r1, a[i+1] - a[i] -1);
    For(i, 0, sz(b)-2) r2 = max(r2, b[i+1] - b[i]-1);
    //cout << r1 << ' ' << r2 << endl;
   // For(i, 0, sz(a)-1) cout << a[i] << ' '; cout << endl;
    cout << ll(r1)*r2;
}
