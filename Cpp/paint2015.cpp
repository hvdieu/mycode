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
#define N 1000010
#define BASE 1000000007

int n, k, a[N], f[N];
vector<int> ke[N];
int prev[N], mu[N];
int st[N], top, cycle, res, number;
bool indfs[N];

void dfs(int u) {
    st[++top] = u; number++;
    indfs[u] = true;
    FOR(v, ke[u]) {
        if (!prev[*v]) {
            prev[*v] = u;
            dfs(*v);
        } else if (prev[u] != *v && indfs[*v]) {
            int top2 = top;
            while (st[top2] != *v) {
                top2--; cycle++;
            }
        }
    }
    top--; indfs[u] = false;
}

int main() {
    freopen("paint2015.inp","r",stdin);
   // freopen("paint2015.out","w",stdout);
    scanf("%d%d", &n, &k);
    For(i, 1, n) {
        int j; scanf("%d", &j);
        ke[i].pb(j); ke[j].pb(i);
    }
    f[0] = 0; f[1] = k; f[2] = (ll(k) * (k-1)) % BASE;
    mu[0] = 1; mu[1] = k-1; mu[2] = (ll(mu[1]) * (k-1)) % BASE;
    For(i, 3, n) {
        mu[i] = (ll(mu[i-1]) * (k-1)) % BASE;
        f[i] = (ll(k)*mu[i-1]) % BASE - f[i-1];
        if (f[i] < 0) f[i] += BASE;
    }
    //For(i, 1, n) cout << f[i] << ' '; cout << endl;
    res = 1;
    For(i, 1, n) if (!prev[i]) {
        prev[i] = i;
        cycle = 1; number = 0;
        dfs(i);
        res = (((ll(res) * f[cycle]) % BASE) * mu[number - cycle]) % BASE;
    }
    cout << res;
}


