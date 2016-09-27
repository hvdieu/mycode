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
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 11
#define BASE int(1e9 + 9)

int n;
ll r[N], res;
ll f[65][two(10)+1];

void add(ll &a, ll b) {
    a += b; if (a >= BASE) a -= BASE;
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("orseq.inp","r",stdin);
    //freopen("orseq.out","w",stdout);
    cin >> n;
    For(i, 1, n) cin >> r[i];
    f[63][0] = 1;
    int T = two(n)-1;
    Rep(i, 63, 1) For(tt, 0, T) {
        For(j, 1, n) {
            int x = bit(tt, j-1);
            if (x || (!x && bit(r[j], i-1))) {
                int t1 = 0; if (x) t1 += two(j-1);
                For(ii, 1, n) if (ii != j && (bit(tt, ii-1) || (!bit(tt, ii-1) && bit(r[ii], i-1)))) t1 += two(ii-1);
                add(f[i-1][t1], f[i][tt]);
            }
        }
        int t1 = 0;
        For(j, 1, n) if (bit(tt, j-1) || (!bit(tt, j-1) && (bit(r[j], i-1)))) t1 += two(j-1);
        add(f[i-1][t1], f[i][tt]);
    }
    For(tt, 0, T) add(res, f[0][tt]);
    cout << res;
}
