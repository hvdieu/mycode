#include <bits/stdc++.h>
using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ld long double
#define pb push_back
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 101

int n, f[N], t[N],res ;
vector<int> ke[N];
bool check[N];

int cal(int u) {
    if (check[u]) return f[u];
    check[u] = true;
    f[u] = t[u];
    For(j, 0, sz(ke[u]) - 1) {
        int v = ke[u][j];
        f[u] = max(f[u], t[u] + cal(v));
    }
    return f[u];
}

void solve() {
    For(i, 1, n) if (!check[i]) res = max(res, cal(i));
    cout << res;
}

int main() {
    freopen("project.inp","r",stdin);
    freopen("project.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d", &t[i]);
    For(i, 1, n) {
        int u, k;
        scanf("%d", &k);
        For(j, 1, k) {
            scanf("%d", &u);
            ke[i].pb(u);
        }
    }
    solve();
}
