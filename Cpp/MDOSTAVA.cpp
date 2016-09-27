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

int m, n, x, y, u, v, s[N][N];
ll res;

int sum(int i, int j, int u, int v) {
    if (i > u) swap(i, u);
    if (j > v) swap(j, v);
    return s[u][v] - s[u][j-1] - s[i-1][v] + s[i-1][j-1];
}

int cal(int x, int y, int u, int v) {
    if ((u == x) || (y == 1 && v == 1) || (y == n && v == n)) return sum(u, v, x, y) - a[x][y];
    int res = cal(x,y,x,1) + cal(x,1,u,1) + cal(u,1,u,v);
    res = min(res, cal())
}

int main() {
    freopen("mdostava.inp","r",stdin);
    freopen("mdostava.out","w",stdout);
    scanf("%d %d", &r, &c);
    For(i, 1, m) For(j, 1, n) {
        int x;
        scanf("%d" ,&x);
        s[i][j] = s[i][j - 1] + s[i - 1][j] - s[i - 1][j - 1] + x;
    }
    x = y = 1;
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d %d", &u, &v);
        res += cal(u ,v, x, y);
        x = u; y = v;
    }
}
