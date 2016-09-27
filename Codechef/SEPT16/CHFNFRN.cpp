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

const int N = 1000 + 5;

int n, m, ntest, lab[N];
bool flag;
vector<int> ke[N];

void dfs(int u, int tt) {
  //  cout << u << ' ' << tt << "\n";
    if (lab[u] != -1) {
        if (lab[u] != tt) flag = false;
        return;
    }
    lab[u] = tt;
    REP(j, sz(ke[u])-1)
        For(v, ke[u][j]+1, ke[u][j+1]-1) if (u != v)
            dfs(v, 1-tt);
}

int main() {
   // freopen("in.txt","r",stdin);
    cin >> ntest;
    while (ntest--) {
        cin >> n >> m;
        For(i, 1, n) ke[i].clear();
        REP(i, m) {
            int u, v;
            cin >> u >> v;
            ke[u].pb(v);
            ke[v].pb(u);
        }
        flag = true;
        For(i, 1, n) {
            ke[i].pb(0); ke[i].pb(n+1);
            sort(all(ke[i]));
        }
        reset(lab, -1);
        For(i, 1, n) if (lab[i] == -1) {
            dfs(i, 0);
            if (!flag) break;
        }
       // For(i, 1, n) cout << lab[i] << ' '; cout << "\n";
        cout << (flag ? "YES\n" : "NO\n");
    }
}


