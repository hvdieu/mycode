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
#define N 260
#define inf 1000000000

int n, res, c[N][N], f[N][N], pre[N], delta[N];
int q[N], lef, righ;
int fr[N], dem;

bool FindPath(int s, int t) {
    ++dem;
    q[1] = s; lef = 0; righ = 1; fr[s] = dem; delta[s] = inf;
    while (lef < righ) {
        int u = q[++lef];
        For(v, 0, n+1) if (fr[v] != dem && f[u][v] < c[u][v]) {
            fr[v] = dem; q[++righ] = v; pre[v] = u;
            delta[v] = min(delta[u], c[u][v] - f[u][v]);
            if (v == t) return true;
        }
    }
    return false;
}

void IncFlow(int s, int t) {
    int v = t, temp = delta[t];
    res += temp;
    while (v != s) {
        int u = pre[v];
        f[u][v] += temp; f[v][u] -= temp;
        v = u;
    }
}

int main() {
    freopen("input.inp","r",stdin);
   // freopen("mobivina.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) {
        int x; scanf("%d", &x);
        c[0][i] = x;
    }

    For(i, 1, n) {
        int x; scanf("%d", &x);
        c[i][n+1] = x;
    }

    For(i, 1, n) For(j, 1, n) {
        int x; scanf("%d", &x);
        c[i][j] = x;
    }

    while (FindPath(0, n+1)) IncFlow(0, n+1);
    cout << res;
}


