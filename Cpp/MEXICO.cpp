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
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 1010

struct triple {
    int x, y, z;
};

triple make_triple(int a, int b, int c) {
    triple X; X.x = a; X.y = b; X.z = c;
    return X;
}

void gan(triple &A, int a, int b, int c) {
    A.x = a; A.y = b; A.z = c;
}

int n, m, a[N][N];
triple trace[N][N][2];
int d[N][N][2];
int dp[N][N][2];
queue<triple> q;

inline int next(int i, int x) {
    i += x; if (i > n) i -= n; return i;
}

inline int prev(int i, int x) {
    i -= x; if (i <= 0) i += n; return i;
}

void truyvet(int i, int j, int t) {
    if (!d[i][j][t]) return;
    printf("%d\n", d[i][j][t]);
    truyvet(trace[i][j][t].x, trace[i][j][t].y, trace[i][j][t].z);
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d", &n, &m);
    For(i, 1, m) {
        int u, v;
        scanf("%d%d", &u, &v);
        a[u][v] = a[v][u] = 1;
    }
    For(i, 1, n) {
        int j = next(i, 1);
        dp[i][j][1] = a[i][j];
        if (dp[i][j][1]) q.push(make_triple(i, j, 1));
        d[i][j][1] = i;
    }
    while (!q.empty()) {
        int i = q.front().x, j = q.front().y, t = q.front().z; q.pop();
        For(t, 0, 1) if (dp[i][j][t]) {
            int v = next(j, 1);
            if (t && a[j][v] && !dp[i][v][1]) {
                dp[i][v][1] = true;
                q.push(make_triple(i, v, 1));
                gan(trace[i][v][1], i, j, t);
                d[i][v][1] = j;
            } else if (!t && a[i][v] && !dp[i][v][1]) {
                dp[i][v][1] = true;
                gan(trace[i][v][1], i, j, t);
                q.push(make_triple(i, v, 1));
                d[i][v][1] = i;
            }
            int u = prev(i, 1);
            if (t && a[j][u] && !dp[u][j][0]) {
                dp[u][j][0] = true;
                q.push(make_triple(u, j, 0));
                gan(trace[u][j][0], i, j, t);
                d[u][j][0] = j;
            } else if (!t && a[i][u] && !dp[u][j][0]) {
                dp[u][j][0] = true;
                gan(trace[u][j][0], i, j, t);
                q.push(make_triple(u, j, 0));
                d[u][j][0] = i;
            }
        }
    }
    For(i, 1, n) For(t, 0, 1) if (dp[i][next(i, n-1)][t]) {
        if (t) printf("%d\n", next(i, n-1)); else printf("%d\n", i);
        truyvet(i, next(i, n-1), t);
        return 0;
    }
    cout << -1;
}
