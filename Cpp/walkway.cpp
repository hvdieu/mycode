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
#define N 1010
#define inf 1000000000

int n, s, t, d[N];
vector<ii> ke[N];
priority_queue<ii, vector<ii>, greater<ii> > heap;

void solve() {
    while (!heap.empty()) heap.pop();
    For(i, 1, 1000) d[i] = inf;
    d[s] = 0; heap.push(ii(0, s));
    while (!heap.empty()) {
        int u = heap.top().se, val = heap.top().fi; heap.pop();
        if (val == d[u]) {
            if (u == t) {
                printf("%.2lf\n", double(d[u]) / 100);
                return;
            }
            FOR(it, ke[u]) {
                int v = it->fi, w = it->se;
                if (d[v] > d[u] + w) {
                    d[v] = d[u] + w;
                    heap.push(ii(d[v], v));
                }
            }
        }
    }
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    while (1) {
        scanf("%d", &n);
        if (!n) break;
        For(i, 1, 1000) ke[i].clear();
        For(i, 1, n) {
            int u, v, l;
            scanf("%d%d%d", &u, &v, &l);
            double s = ((u + v) * l);
            ke[u].pb(ii(v, s)); ke[v].pb(ii(u, s));
        }
        scanf("%d%d", &s, &t);
        solve();
    }
}


