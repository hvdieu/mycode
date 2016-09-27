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
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1LL << i))
#define N 100010

unsigned int n, k, a[N], b[N];
vector<int> f;

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("vxor.inp","r",stdin);
    freopen("vxor.out","w",stdout);
    scanf("%d%d", &n, &k);
    For(i, 1, n) scanf("%d", &a[i]);
    sort(a+1, a+n+1);
    unsigned int tt = 0;
    Rep(len, 31, 0) {
        tt += two(len);
        int dem = 1;
        ll sl = 0;
        b[1] = a[1] & tt;
        For(i, 2, n) {
            b[i] = a[i] & tt;
            if (b[i] == b[i-1]) dem++;
            else {
                sl += (ll(dem) * (dem-1))/2; if (sl >= k) sl = k;
                dem = 1;
            }
        }
        sl += (ll(dem) * (dem-1)) / 2;
        if (sl < k) {
            tt -= two(len);
            break;
        }
    }
    if (tt == two(32)-1) For(i, 1, k) printf("0 "); else {
        int i = 1;
        while (i <= n) {
            int j = i;
            while (j < n && (a[i] & tt) == (a[j+1] & tt)) j++;
            For(ii, i, j-1) For(jj, ii+1, j) f.pb(a[ii] ^ a[jj]);
            i = j + 1;
        }
        sort(all(f));
        For(i, 0, k-1) printf("%d ", f[i]);
    }
}
