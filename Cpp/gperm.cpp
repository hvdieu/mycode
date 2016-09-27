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
#define N 50010

int m, n, next[N], prev[N], a[N], pos[N];

int main() {
    freopen("gperm.inp","r",stdin);
    freopen("gperm.out","w",stdout);
    scanf("%d", &n);
    For(i, 0, n+1) {
        next[i] = i+1; prev[i] = i-1;
    }
    For(i, 1, n) {
        int x, y;
        scanf("%d %d", &x, &y);
        int u = prev[x], v = next[x];
        next[u] = v; prev[v] = u;
        u = prev[y]; v = next[y];
        next[x] = y; prev[x] = u; next[u] = x; prev[y] = x;
    }
    int x = 0;
    For(i, 1, n) {
        x = next[x]; a[i] = x; pos[x] = i;
    }
    int q;
    scanf("%d", &q);
    while (q) {
        q--; char c;
        cin >> c; cin >> x;
        if (c == 'L') printf("%d\n", a[x]);
        else printf("%d\n", pos[x]);
    }

}
