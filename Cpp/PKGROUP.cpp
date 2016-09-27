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
#define N 1001

int n, ke[N][N], pos[N], deg[N], q[N], sl[2], top, dem, st[N];
bool all_know[N], flag;

bool know(int i, int j) {
    return ke[i][j] && ke[j][i];
}

void dfs(int i, int group) {
    if (!flag) return;
    sl[group]++;
    pos[i] = group;
    For(j, 1, n) if (!know(i, j)) {
        if (pos[j] == -1) dfs(j, 1 - group);
        else if (pos[i] == pos[j]) {
            flag = false;
            return;
        }
    }
}

void solve() {
    For(i, 1, n) pos[i] = -1;
    dem = 0;
    For(i, 1, n) {
        all_know[i] = true;
        For(j, 1, n) all_know[i] &= know(i, j);
        if (all_know[i]) dem++;
    }
    flag = true;
    top = 0;
    For(i, 1, n) if (!all_know[i] && pos[i] == -1) {
        reset(sl, 0);
        dfs(i, 0);
        if (!flag) {
            printf("-1\n"); return;
        }
        st[++top] = abs(sl[0] - sl[1]);
    }

    sort(st+1,st+top+1);
    int res = 0;
    Rep(i, top, 1) if (res <= 0) res += st[i];
    else res -= st[i];
    while (dem) {
        if (res <= 0) res++; else res--;
        dem--;
    }
    printf("%d\n",abs(res));
}

int main() {
    freopen("pkgroup.inp","r",stdin);
    //freopen("","w",stdout);
    while (1) {
        scanf("%d", &n);
        if (n == -1) break;
        reset(ke, 0);
        reset(deg, 0);
        For(u, 1, n) {
            while (1) {
                int v; scanf("%d", &v);
                if (!v) break;
                ke[u][v] = 1; deg[u]++;
                ke[u][u] = 1;
            }
        }
        solve();
    }
}


