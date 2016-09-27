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
#define N 1001
#define T 6
#define M 3001
#define inf 1000000000
struct node {
    int cost, kind, up;
};

bool cmp(node a, node b) {
    return a.kind < b.kind;
}

int n, t, m, f[M][T];
node a[N];

int main() {
    freopen("computer.inp","r",stdin);
    freopen("computer.out","w",stdout);
    scanf("%d", &t); scanf("%d", &n);
    For(i, 1, n) scanf("%d%d%d", &a[i].cost, &a[i].up, &a[i].kind);
    scanf("%d", &m);
    sort(a+1, a+n+1, cmp);
    For(j, 0, m) For(tt, 0, t) f[j][tt] = -inf;
    For(j, 0, m) f[j][0] = 0;
    int i = 0;
    For(tt, 1, t) {
        i++;
        if (i > n || a[i].kind != tt) {
            cout << -1; return 0;
        }
        int j = i; while (j < n && a[j+1].kind == tt) j++;
        For(money, 1, m) For(k, i, j) {
            f[money][tt] = max(f[money][tt], f[money-1][tt]);
            For(k, i, j) if (money >= a[k].cost) f[money][tt] = max(f[money - a[k].cost][tt-1] + a[k].up, f[money][tt]);
        }
        i = j;
    }
    if (f[m][t] <= 0) cout << -1;
    else cout << f[m][t];
}
