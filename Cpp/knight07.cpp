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
#define N 50

int m, n, m1, m2, a[N][N], h[4], d[N][N];
queue<int> qx, qy;
bool fr[N][N];

void solve() {
    h[0] = m1; h[1] = -m1; h[2] = m2; h[3] = -m2;
    reset(fr, true);
    For(i, 1, m) For(j, 1, n) if (a[i][j] == 3) {
        qx.push(i); qy.push(j); fr[i][j] = false;
    }
    while (!qx.empty()) {
        int i = qx.front(), j = qy.front(); qx.pop(); qy.pop();
        For(dx, 0, 3) For(dy, 0, 3) if (abs(h[dx]) != abs(h[dy])) {
            int u = i + h[dx], v = j + h[dy];
            if (u > 0 && v > 0 && u <= m && v <= n && fr[u][v])
            if (a[u][v] == 4) {
                cout << d[i][j] + 1; return;
            } else if (a[u][v] == 1) {
                fr[u][v] = false; d[u][v] = d[i][j] + 1;
                qx.push(u); qy.push(v);
            }
        }
    }
}

int main() {
    freopen("knight07.inp","r",stdin);
    freopen("knight07.out","w",stdout);
    scanf("%d %d %d %d", &m, &n, &m1, &m2);
    For(i, 1, m) For(j, 1, n) scanf("%d", &a[i][j]);
    solve();
}
