#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define M 110
#define K 510
#define inf 1000000000000000LL

int n, m, k;
int room[M];
ll f[M][K];

ll cal(int x, int k) {
    if (!k) return (ll(x) * (x + 1)) / 2;
    if (k >= x-1) return x;
    ll y = x / (k + 1);
    int du = x % (k + 1);
    return (y * (y + 1) / 2) * (k + 1 - du) + ((y + 1) * (y + 2) / 2) * du;
}

int main() {
    freopen("zabava.inp","r",stdin);
    freopen("zabava.out","w",stdout);
    scanf("%d %d %d", &n, &m, &k);
    For(i, 1, n) {
        int x; scanf("%d", &x);
        room[x]++;
    }
    For(i, 0, m) For(j, 0, k) f[i][j] = inf;
    f[0][0] = 0;
    For(i, 1, m) For(j, 0, k) For(jj, 0, j)
    f[i][j] = min(f[i][j], f[i-1][j-jj] + cal(room[i], jj));
    cout << f[m][k] << endl;
   // cout << cal(room[2], 1);
}


