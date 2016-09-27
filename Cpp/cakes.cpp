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

int n, T;
multiset<int> in, out;
multiset<int>::iterator i1, i2;

int main() {
    freopen("cakes.inp","r",stdin);
    freopen("cakes.out","w",stdout);
    scanf("%d%d", &n, &T);
    int sum = 0;
    int res = 0;
    For(i, 1, n) {
        int x, t;
        scanf("%d%d", &x, &t);
        if (x <= T) {
            out.insert(t);
            if (!in.empty()) {
                i1 = in.end(); i1--;
                i2 = out.begin();
                int xx = *i1, yy = *i2;
                if (xx > yy) {
                    sum = sum - xx + yy;
                    in.erase(i1); out.erase(i2);
                    in.insert(yy); out.insert(xx);
                }
            }
            while (sum + x > T && !in.empty()) {
                i1 = in.end(); i1--;
                sum -= *i1; out.insert(*i1);
                in.erase(i1);
            }
            while (sum + x < T && !out.empty()) {
                i2 = out.begin();
                if (sum + x + *i2 > T) break;
                else {
                    sum += *i2;
                    in.insert(*out.begin()); out.erase(out.begin());
                }
            }
            res = max(res, sz(in));
        }
    }
    cout << res;
}
