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
#define N 200000
#define inf 1000000000

int m, n, k, d[N];
vector<int> ke[N];
queue<int> q;

int main() {
    freopen("trip2015.inp","r",stdin);
    freopen("trip2015.out","w",stdout);
    scanf("%d%d%d", &n, &k, &m);
    For(i, 1, n+m) d[i] = inf; d[1] = 0;
    For(i, 1, m) {
        n++;
        For(j, 1, k) {
            int u; scanf("%d", &u);
            ke[n].pb(u); ke[u].pb(n);
        }
    }
    q.push(1);
    while (!q.empty()) {
        int u = q.front(); q.pop();
        FOR(v, ke[u]) if (d[*v] > d[u] + 1) {
            d[*v] = d[u] + 1;
            if (*v == n-m) {
                printf("%d", d[*v]/2 + 1); return 0;
            }
            q.push(*v);
        }
    }
    printf("-1");
}


