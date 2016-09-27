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
#define N 200010
#define inf 1000000000000000LL

int n, k, a[N];
multiset<int, greater<int> > ff;
multiset<int, greater<int> >::iterator it;
ll s[N];
ll res;

int main() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d", &n, &k);
    For(i, 1, n) {
        scanf("%d", a+i);
        s[i] = s[i-1] + a[i];
    }
    For(i, 1, k) ff.insert(a[i] - i);
    res = inf;
    ll sum = ll(k) * (k+1) / 2;
    if (*ff.begin() <= 0) res = min(res, sum - s[k]);
    For(l, 2, n-k+1) {
        it = ff.find(a[l-1] - (l-1));
        ff.erase(it);
        ff.insert(a[l+k-1] - (l+k-1));
       // cout << *ff.begin() << endl;
        if (*ff.begin() + l - 1 <= 0) res = min(res, sum - s[l+k-1] + s[l-1]);
    }
    if (res == inf) cout << -1;
    else cout << res;
}
