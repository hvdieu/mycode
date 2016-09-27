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
#define N 300010

int n, m, q, root[N], size[N], f[N][2], res, len[N];
vector<int> ke[N];
bool fr[N];

int getroot(int u) {
    if (u != root[u]) root[u] = getroot(root[u]);
    return root[u];
}

void Union(int r1, int r2) {
    if (size[r1] > size[r2]) swap(r1,r2);
    root[r1] = root[r2];
    size[r2] += size[r1];
}

void dfs(int u) {
    fr[u] = false;
    For(j, 0, sz(ke[u]) - 1) {
        int v = ke[u][j];
        if (fr[v]) {
            dfs(v);
            int x = f[v][0] + 1;
            if (x > f[u][0]) {
                f[u][1] = f[u][0], f[u][0] = x;
            } else if (x > f[u][1]) f[u][1] = x;
        }
    }
    res = max(res, f[u][0] + f[u][1]);
}

int main() {
    freopen("civi.inp","r",stdin);
    freopen("civi.out","w",stdout);
    scanf("%d %d %d", &n, &m, &q);
    For(i,1,n) {
        root[i] = i; size[i] = 1;
    }

    For(i,1,m) {
        int u, v;
        scanf("%d %d",&u, &v);
        int r1 = getroot(u), r2 = getroot(v);
        Union(r1,r2);
        ke[u].pb(v); ke[v].pb(u);
    }

    reset(fr, true);
    For(i,1,n) if (fr[i]) {
        res = 0;
        dfs(i);
        int r1 = getroot(i);
        len[r1] = res;
    }

    while (q) {
        q--;
        int kind, u, v;
        scanf("%d", &kind);
        if (kind == 1) {
            scanf("%d", &u);
            int r1 = getroot(u); printf("%d\n", len[r1]);
        } else {
            scanf("%d %d", &u, &v);
            int r1 = getroot(u), r2 = getroot(v);
            if (r1 != r2) {
                if (size[r1] > size[r2]) swap(r1,r2);
                Union(r1,r2);
                len[r2] = max(max(len[r2], len[r1]), len[r1] / 2 + len[r2] / 2 + len[r1] % 2 + len[r2] % 2 + 1);
            }
        }
    }
}
