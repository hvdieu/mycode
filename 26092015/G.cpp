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
#define N 5010
#define inf 1000000000

int n, k, a[N], ntest, last[N][N], res, m;

int Find(int d, int c, int j, int x) {
    int ans = 0;
    while (d <= c) {
        int mid = (d + c) / 2;
        if (last[mid][j] < x) {
            ans = mid;
            d = mid + 1;
        } else c = mid - 1;
    }
    return ans;
}

void solve() {
    For(i, 1, n/2) swap(a[i], a[n-i+1]);
    m = 0;
    For(i, 1, n) For(j, 0, n) last[i][j] = inf;
    last[0][0] = 0;
    For(j, 0, n) For(i, 1, n) {
        int l = Find(0, m, j, a[i]);
        last[l+1][j] = min(last[l+1][j], a[i]);
        m = max(m, l+1);
        if (j) {
            For(len, 0, m) last[len][j] = min(last[len][j], last[len][j-1]);
        }
      //  cout << i << ' ' << j << endl;
    }
    For(j, 0, n) Rep(len, n, 0) if (last[len][j] != inf) {
    	if (len <= k) {
    		printf("%d", n-j);
        	return;
		}
        break;
    }
}

int main() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d%d", &n, &k);
        For(i, 1, n) scanf("%d", a+i);
        solve();
        //cout << 1 << endl;
        if (test != ntest) printf("\n");
    }
}


