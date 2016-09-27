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

int ntest, n, x, y, k;

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d%d%d%d", &x, &y, &k, &n);
        bool flag = false;
        x -= y; if (x <= 0) flag = true;
        For(i, 1, n) {
            int page, pay; scanf("%d%d", &page, &pay);
            if (page >= x && pay <= k) flag = true;
        }
        if (flag) printf("LuckyChef\n");
        else printf("UnluckyChef\n");
    }
}
