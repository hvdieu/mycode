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
#define N 210

int m, n, a[N][N], low[N], num[N], timer, lab[N], dem, res;
vector<int> ke[N];
bool fr[N];
stack<int> st;

void dfs(int u) {
    num[u] = ++timer; low[u] = num[u];
    st.push(u);
    For(j, 0, sz(ke[u])-1) {
        int v = ke[u][j];
        if (fr[v]) {
            if (num[v]) low[u] = min(low[u], num[v]);
            else {
                dfs(v);
                low[u] = min(low[u], low[v]);
            }
        }
    }

    if (low[u] == num[u]) {
        int v; dem = 0;
        do {
            v = st.top(); st.pop();
            dem++; fr[v] = false;
        } while (v != u);
        res = max(res, dem);
    }
}

int main() {
    freopen("graph1.inp","r",stdin);
    freopen("graph1.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) For(j, 1, n) {
        scanf("%d", &a[i][j]);
        if (a[i][j]) ke[i].pb(j);
    }
    For(i, 1, n) For(j, 1, n) if (i != j && !a[i][j]) {
        ke[i].pb(j); reset(num, 0); timer = 0; dem = 0;
        reset(fr, true);
        For(u, 1, n) if (!num[u]) dfs(u);
        ke[i].pop_back();
    }
    cout << res;
}
