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

int ntest, m, k;
vector<int> s;
vector<int> kq;
ll n;

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d%lld\n", &m, &n);
        s.clear();
        For(i, 1, m) {
            int x; cin >> x; s.pb(x);
        }
        sort(all(s)); s.erase(unique(all(s)), s.end());
        m = sz(s);
        ull num = 1;
        int len = 1;
        for(len; len <= 10000; len++) {
            num *= m;
            if (num >= n) break;
            else n -= num;
        }
        kq.clear();
        For(i, 1, len) {
            num /= m;
            For(j, 0, m-1) if (num >= n) {
                printf("%d", s[j]);
                break;
            } else n -= num;
        }
        printf("\n");
    }
}
