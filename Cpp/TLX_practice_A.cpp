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

int a, b, l, r;
map<int, int> ff;
vector<int> st;

int poww(int a, int n) {
    int res = 1;
    while (n) {
        if (n & 1) res = ll(res) * a % b;
        n >>= 1;
        a = ll(a) * a % b;
    }
    return res;
}

int main() {
    //freopen("input.txt", "r", stdin);
    //freopen("output.txt", "w", stdout);
    cin >> a >> b >> l >> r;
    //cout << l << ' ' << r << endl;
    if (a % b == 0) For(i, l, r) cout << 0;
    else {
        int mu = poww(10, l-1);
        int x = ll(a) * mu % b;
        For(i, l, r) {
            printf("%d", ll(x) * 10 / b);
            x = ll(x) * 10 % b;
        }
    }
    cout << endl;
}
