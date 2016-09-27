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

ll res;
int S, C, ntest, K;

int main() {
  //  freopen("input.txt","r",stdin);
  //  freopen("output.txt","w",stdout);
    cin >> ntest;
    For(test, 1, ntest) {
        cin >> S >> C >> K; C++;
        res = 0;
        For(i, 0, max(S, C) - 1) {
            ll dem = 0, sl = 0;
            if (i < S) {
                if (!i) dem = 3;
                else dem = 1LL << i;
                sl = S - i;
            }
            if (i && i < C) {
                dem = 1LL << i;
                sl++;
            }
            if (sl >= K) res += dem;
        }
        cout << res << endl;
    }
}
