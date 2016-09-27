#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define FOR(i, f) for(auto i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 500010

int n, m, s, ntest, dem;
int d[N], dd[N];
vector<int> ke[N];
list<int> l;
queue<int> q;

void solve() {
    d[s] = 0; l.clear(); while (!q.empty()) q.pop();
    For(i, 1, n) if (i != s) l.pb(i);
    q.push(s);
    while (!l.empty()) {
        int u = q.front(); q.pop(); dem++;
        FOR(v, ke[u]) dd[*v] = dem;
        auto v = l.begin();
        while (v != l.end()) {
            auto nextv = v; ++nextv;
            if (dd[*v] != dem) {
                d[*v] = d[u]+1; q.push(*v);
                l.erase(v);
            }
            v = nextv;
        }
    }
    For(i, 1, n) if (i != s) printf("%d ", d[i]); printf("\n");
}

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d%d", &n, &m);
        For(i, 1, n) ke[i].clear();
        For(i, 1, m) {
            int u, v; scanf("%d%d", &u, &v); ke[u].pb(v); ke[v].pb(u);
        }
        scanf("%d", &s);
        solve();
    }
}
