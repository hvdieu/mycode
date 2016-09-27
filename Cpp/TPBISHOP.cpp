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
#define N 60

int n, match[N][N][2], res, sc;
char a[N][N];
bool fr[N][N];

bool dfs(int i, int j) {
    if (!fr[i][j]) return false;
    fr[i][j] = false;
    for(int dx = -1; dx <= 1; dx += 2)
    for(int dy = -1; dy <= 1; dy += 2) {
        int u = i + dx, v = j + dy;
        if (u && v && u <= n && v <= n && a[u][v] == '.') {
            if (!match[u][v][0] || dfs(match[u][v][0], match[u][v][1])) {
                match[i][j][0] = u; match[i][j][1] = v;
                match[u][v][0] = i; match[u][v][1] = j;
                return true;
            }
        }
    }
    return false;
}

int main() {
    freopen("tpbishop.inp","r",stdin);
    freopen("tpbishop.out","w",stdout);
    scanf("%d\n", &n);
    For(i, 1, n) scanf("%s\n", (a[i]+1));
    For(i, 1, n) For(j, 1, n) if (a[i][j] == '.') {
        res++;
        if (!match[i][j][0]) {
            reset(fr, true);
            if (dfs(i, j)) sc++;
        }
    }
    cout << res - sc << endl;
    For(i, 1, n) For(j, 1, n) printf("%d %d %d %d\n", i, j, match[i][j][0], match[i][j][1]);
}


