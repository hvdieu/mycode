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
#define N 10001

int kq[N], n, a[N];

int main() {
    //ios_base::sync_with_stdio(false);
   // freopen("bseq.inp","r",stdin);
   // freopen("bseq.out","w",stdout);
    cin >> n;
    For(i, 1, n+1) {
        For(j, 1, n) kq[n*(i-1) + j] = a[j];
        a[n-i+1] = 1;
    }
    For(i, 1, n*n+n) cout << kq[i] << ' ';
}
