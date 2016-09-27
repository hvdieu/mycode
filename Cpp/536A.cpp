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

ll A, B;
int ntest, m, t, l;

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%lld%lld%d", &A, &B, &ntest);
    For(test, 1, ntest) {
        int l, t, m;
        scanf("%d%d%d", &l, &t, &m);
        int c = l + t, mid, ans = -1, d = l;
        ll first = A + B * (l-1);
        while (d <= c) {
            mid = (d + c) / 2;
            ll last = A + B * (mid - 1);
            bool ok = true;
            if (last > t) ok = false;
            ll sum = (last + first) * (mid - l + 1) / 2;
            if (sum > ll(t)*min(mid-l+1, m)) ok = false;
            if (ok) {
                ans = mid; d = mid + 1;
            } else c = mid - 1;
        }
        printf("%d\n", ans);
    }
}
