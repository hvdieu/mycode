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
#define N 100010
#define BASE 1000000007
int n, m, ntest, x[N], y[N], lab[N], cnt;
int sd[N], sc[N], loob[N];
vector<int> ke[N];

void dfs(int u) {
    lab[u] = cnt;
    sd[cnt]++;
    FOR(v, ke[u])
	if (!lab[*v]) dfs(*v);
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    while (1) {
        scanf("%d%d", &m, &n);
        if (!m) break; ntest++;
        printf("Case %d: ", ntest);
        For(i, 1, n) ke[i].clear();
        For(i, 1, m) {
            int u, v; scanf("%d%d", &u, &v); u++; v++;
            x[i] = u; y[i] = v;
            if (u != v) ke[u].pb(v), ke[v].pb(u);
        }
        reset(lab, 0);
        reset(sc, 0); reset(sd, 0);
        cnt = 0;
        For(i, 1, n) if (!lab[i]) {
        	cnt++;
			dfs(i);
		}
		reset(loob, 0);
        For(i, 1, m) {
            sc[lab[x[i]]]++;
            if (x[i] == y[i]) loob[lab[x[i]]]++;
        }
        ll res = 1;
        For(i, 1, cnt) if (sd[i] == sc[i])  {
            if (!loob[i]) res = (res*2)%BASE;
        }
        else if (sd[i] == sc[i]+1) res = (res*sd[i]) % BASE;
        else res = 0;
        cout << res << endl;
    }
}
