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
#define N 200010

int n, q;
set<ii, greater<ii> > heap;
set<ii, greater<ii> >::iterator it;
set<int> contain[N];
set<int>::iterator it2;

int main() {
  //  freopen("stones.inp","r",stdin);
  //  freopen("stones.out","w",stdout);
    scanf("%d%d", &q, &n);
    For(i, 1, q) {
        int kind, u, x;
        scanf("%d", &kind);
        if (kind == 1) {
            scanf("%d%d", &u, &x);
            if (!contain[u].empty() && x < *contain[u].begin()) {
                it = heap.find(ii(*contain[u].begin(), u));
                heap.erase(it);
                heap.insert(ii(x, u));
            }
            contain[u].insert(x);
            if (x == *contain[u].begin()) heap.insert(ii(x, u));
        } else {
            ii p = *heap.begin(); heap.erase(heap.begin());
            printf("%d\n", p.fi);
            contain[p.se].erase(p.fi);
            if (!contain[p.se].empty()) heap.insert(ii(*contain[p.se].begin(), p.se));
        }
    }
}
