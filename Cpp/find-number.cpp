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

int ntest, a, b, c;
ll f[100000], n;

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> ntest;
    For(test, 1, ntest) {
        cin >> n >> a >> b >> c;
        f[0] = 1;
        if (n == 1) cout << 0 << endl;
        else
        for(int i = 1; ; i++) {
            f[i] = 0;
            if (i >= a) f[i] += f[i-a];
            if (i >= b) f[i] += f[i-b];
            if (i >= c) f[i] += f[i-c];
            if (!f[i]) f[i] = 1;
            if (f[i] >= n) {
                cout << i << endl;
                break;
            }
        }
    }
}


