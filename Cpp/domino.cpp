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
#define N 11
#define NN 2048
#define getbit(x,i) { return (x >> (i-1)) & 1; }
#define onbit(x,i) { return x | (1 << (i-1)); }
#define offbit(x,i) { return x & (~(1 << (i-1))); }

int m,n,k,a[N][N];
ll f[N][N][NN];

void solve() {
    For(i,1,m) x[i][n+1] = 1;
    f[1][1][0] = 1;
    if (!x[1][1] && !x[2][1]) f[1][1][onbit(0,1)]++;
    For(i,1,m) For(j,1,n) For(tt,0,1 << (n-1)) {
        if (j == n) {
            if (x[i+1][1]) f[i+1][1][]
        }
    }
}

int main() {
    freopen("domino.inp","r",stdin);
    freopen("domino.out","w",stdout);
    scanf("%d%d%d",&m,&n,&k);
    For(i,1,k) {
        int u,v; scanf("%d%d",&u,&v); a[u][v] = 1;
    }
    solve();
}
