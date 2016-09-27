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
#define pb push_back
#define sz(s) int(s.size())
#define reset(f,x) memset(f,x,sizeof(f))
#define all(x) x.begin(), x.end()
#define N 520

int n, m, a[N], t1[N], t2[N], C, res;
vector<int> ke[N], f[N], c[N], op[N];
queue<int> q;
bool fr[N];

void connect(int u, int v, int l) {
    ke[u].pb(v); ke[v].pb(u); f[u].pb(0); f[v].pb(0);
    c[u].pb(l); c[v].pb(0); op[u].pb(sz(ke[v])-1); op[v].pb(sz(ke[u])-1);
}

bool FindPath(int s, int t) {
    reset(fr, true);
    q.push(s); fr[s] = false;
    while (!q.empty()) {
        int u = q.front(); q.pop();
        For(j, 0, sz(ke[u])-1) { int v = ke[u][j];
        if (f[u][j] < c[u][j] && fr[v]) {
            fr[v] = false; t1[v] = u; t2[v] = j;
            q.push(v);
        }
        }
    }
    return !fr[t];
}

void IncFlow(int s, int t) {
    int v = t, temp = C+1;
    while (v != s) {
        int u = t1[v], j = t2[v];
        temp = min(temp, c[u][j] - f[u][j]);
        v = u;
    }
    res += temp;
    v = t;
    while (v != s) {
        int u = t1[v], j = t2[v];
        f[u][j] += temp; f[v][op[u][j]] -= temp;
        v = u;
    }
}

int main() {
    freopen("jobset.inp","r",stdin);
    freopen("jobset.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) {
        int x; scanf("%d", &x);
        if (x > 0) {
            C += x; connect(0, i, x);
        } else connect(i, n+1, -x);
    }
    scanf("%d", &m);
    For(i, 1, m) {
        int u, v;
        scanf("%d %d", &u, &v);
        connect(u, v, C+1);
    }

    while (FindPath(0, n+1)) IncFlow(0, n+1);
    cout << C - res;
}


