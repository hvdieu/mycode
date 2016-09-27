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
#define N 51
#define K 51
#define T 26
#define BASE 10007

int n,m,kk;
vector<int> type1[N][T], type2[N][T], type3[N], type0[N];
int f[N][N][K][2], g[N][N][K], res;

void solve() {
    For(i,1,n) For(tt,0,1) f[i][i][0][tt] = 1;
    For(k,1,kk) {
        if (k >= 2)
          For(i,1,n) For(j,1,n) For(ch,0,25)
          For(j1,0,sz(type1[i][ch])-1) For(j2,0,sz(type2[j][ch])-1)
          {
            int u = type1[i][ch][j1], v = type2[j][ch][j2];
            g[i][j][k] = (g[i][j][k] + f[u][v][k-2][0]) % BASE;
          }

        For(i,1,n) For(j,1,n) For(tt,0,1) {
            vector<int> ke;
            if (tt) ke = type0[i]; else ke = type3[i];
            For(j1,0,sz(ke)-1) {
                int u = ke[j1];
                f[i][j][k][tt] = (f[i][j][k][tt] + f[u][j][k-1][tt]) % BASE;
            }

            For(u,1,n) For(k1,2,k)
                f[i][j][k][tt] = (f[i][j][k][tt] + g[i][u][k1] * f[u][j][k - k1][tt]) % BASE;
        }

        res = (res + f[1][n][k][1]) % BASE;
    }

    printf("%d",res);
}

int main() {
    freopen("kamion.inp","r",stdin);
    freopen("kamion.out","w",stdout);
    scanf("%d%d%d\n",&n,&m,&kk);
    For(i,1,m) {
        char line[128];
        gets(line);
        int u,v; char type;
        int kind = sscanf(line, "%d %d %c",&u,&v,&type);
        if (kind == 2) {
            type0[u].pb(v);
            type3[u].pb(v);
        } else if ( type >= 'A'  && type <= 'Z') {
            type1[u][type - 'A'].pb(v);
            type0[u].pb(v);
        } else type2[v][type - 'a'].pb(u);
    }
    solve();
}


