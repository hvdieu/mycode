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
#define N 100010

int ntest, n, k, q;
int s[N], f[N];
ll g[N];
char a[N];

void init() {
    int j = 0;
    g[0] = 0;
    For(i, 1, n) {
        while (s[i] - s[j] > k || i-j - (s[i] - s[j]) > k) j++;
        f[i] = j+1;
        g[i] = g[i-1] + i-j;
    }
}

ll Cal(int l, int r) {
    int d = l, c = r, mid, ans = -1;
    while (d <= c) {
        mid = (d + c) / 2;
        if (f[mid] < l) {
            ans = mid; d = mid + 1;
        } else c = mid - 1;
    }
    //cout << ans << endl;
    if (ans == -1) return g[r] - g[l-1];
    int len = ans - l + 1;
    return g[r] - g[ans] + (ll(ans) + l) * len / 2 - ll(len) * (l-1);
}

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d%d%d\n", &n, &k, &q);
        scanf("%s\n", a+1);
        For(i, 1, n) {
            s[i] = s[i-1];
            if (a[i] == '1') s[i]++;
        }
        init();
        For(i, 1, q) {
            int l, r; scanf("%d%d", &l, &r);
            printf("%lld\n", Cal(l, r));
        }
    }
}
