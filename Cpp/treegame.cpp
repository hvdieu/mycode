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
#define N 5010

int n, ntest, l;
ll con[N];
bool dp[N];
vector<int> ke[N];

void dfs(int u) {
    FOR(v, ke[u]) {
        dfs(*v);
        con[u] += con[*v];
    }
}

int main() {
  //  freopen("input.txt","r",stdin);
 //   freopen("output.txt","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d%d", &n, &l);
        For(i, 1, n) ke[i].clear();
        For(v, 2, n) {
            int u, x; scanf("%d%lld", &u, &con[v]);
            ke[u].pb(v);
        }

        con[1] = 0;
        dfs(1);
        int res = 0;
        FOR(v, ke[1])
		res ^= con[*v] % (l + 1);
        if (!res) cout << "3B"; else cout << "RUBY"; cout << endl;
    }
}
