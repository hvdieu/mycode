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

const int N = 1e5 + 10;

int n;
double g[N];
double gt[N];
vector<int> ke[N];
int con[N];
double tmp;

void dfs(int u) {
    con[u] = 1;
    FOR(v, ke[u]) {
        dfs(*v);
        con[u] += con[*v];
        g[u] *=
    }

}

int main() {
    freopen("in.txt","r",stdin);
    cin >> n;
    For(i, 2, n) {
        int p;
        cin >> p;
        ke[p].pb(i);
    }
    tmp = 1.0;
    gt[0] = 1.0;
    For(i, 1, n) gt[i] = gt[i-1] / i;
    For(i, 1, n) tmp /= gt[sz(ke[i])];
    For(i, 1, n) g[i] = tmp;
    dfs(1);
}


