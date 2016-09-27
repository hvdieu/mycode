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
#define bit(x, i) ((x >> (i)) & 1LL)
#define onbit(x, i) (x | (1LL << (i-1)))
#define offbit(x, i) (x & ~(1 << (i-1)))
#define N 100010

int n, a[N], cnt[32], s[2], dem;
ll res;

int main() {
    freopen("PPXOR.INP","r",stdin);
    freopen("PPXOR.OUT","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d", a + i);
    ll kq = 0;
   // For(i, 1, n) For(j, i, n) {
   //     int temp = 0;
  //      For(k, i, j) temp ^= a[k];
  //      kq += temp;
  //  }
    For(j, 0, 30) {
        s[0] = 1; s[1] = 0;
        dem = 0;
        For(i, 1, n) {
            dem += bit(a[i], j); dem %= 2;
            res += (1LL << j) * s[1 - dem];
			s[dem]++;
        }
    }
    cout << res;
}


