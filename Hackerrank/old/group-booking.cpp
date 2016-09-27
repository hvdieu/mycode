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

const int N = 1000000 + 10;

int n, m, a[N], res;
ii r[N];
multiset<int, greater<int>> f;

int main() {
    ios_base::sync_with_stdio(0);
    //ifstream cin("input.txt");
    cin >> n >> m;
    For(i, 1, n) cin >> a[i];
    For(i, 1, m) cin >> r[i].fi >> r[i].se;
    sort(a+1, a+n+1);
    sort(r+1, r+m+1);
    int j = 0;
    int cap = 0;
    For(i, 1, n) {
        while (j < m && a[i] >= r[j+1].fi) f.insert(r[++j].se);
        if (!cap) {
            cap = *f.begin(); f.erase(f.begin());
            //cout << f.size() << ' ';
            res++;
        }
        cap--;
    }
    cout << res;
}


