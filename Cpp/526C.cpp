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
#define lim 1000000

int C, a1, b1, a2, b2, d, c, mid, ans;
ll res;

ll get(int x) {
    int y = (C - a2*x) / b2;
    return ll(a1)*x + ll(b1)*y;
}

int main() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> C >> a1 >> b1 >> a2 >> b2;
    if (a2 < b2) {
        swap(a1, b1); swap(a2, b2);
    }
    int d = max(C / a2 - lim, 0), c = C / a2;
    For(x, d, c) res = max(res, get(x));
    d = 0, c = min(C/a2, lim);
    For(x, d, c) res = max(res, get(x));
    cout << res;
}
