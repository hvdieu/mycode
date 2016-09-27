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
#define N 2000010

int n;
ll l, r;
int ntest;

ll cal(ll x) {
    ll res = 0, tmp = 0, v;
    int i = 0;
    while (1) {
        v = tmp + i;
        if (v >= x) break;
        if (i % 2) res += i;
        tmp = v;
        i++;
    }
    x -= tmp; if (x % 2) res += i;
    return res;
}

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> ntest;
    For(test, 1, ntest) {
        cin >> l >> r;
        cout << cal(r) - cal(l-1) << endl;
    }
}
