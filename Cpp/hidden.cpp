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
#define N 51
#define N3 132651

const int h[4] = {-1,0,1,0};
const int c[4] = {0,1,0,-1};

int m,n,ntest,lef,righ,qi[N3],qj[N3],qk[N3];
char a[N][N],s[N];
bool fr[N][N][N];

void push(int i, int j, int k) {
    if (fr[i][j][k]) {
        fr[i][j][k] = false;
        qi[++righ] = i; qj[righ] = j; qk[righ] = k;
    }
}

void solve() {
    reset(fr,true); lef = 0; righ = 0;
    For(i,1,m) For(j,1,n) if (a[i][j] == s[1]) push(i,j,1);
    int len = strlen(s+1);
    while (lef < righ) {
        int i = qi[++lef], j = qj[lef], k = qk[lef];
        if (k == len) {
            printf("Yes\n"); return;
        }
        For(tt,0,3) {
            int u = i + h[tt], v = j + c[tt];
            if (u && v && u <= m && v <= n && a[u][v] == s[k+1]) push(u,v,k+1);
        }
    }
    printf("No\n");
}

int main() {
    freopen("hidden.inp","r",stdin);
    freopen("hidden.out","w",stdout);
    scanf("%d %d\n", &m, &n);
    For(i,1,m) scanf("%s\n", (a[i]+1));
    scanf("%d\n", &ntest);
    while (ntest) {
        ntest--;
        scanf("%s\n", (s+1));
        solve();
    }
}
