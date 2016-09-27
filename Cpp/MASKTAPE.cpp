#include <stdio.h>
#include <iostream>
#include <algorithm>
#include <vector>
#include <string>
#include <cstring>
#include <map>
#include <set>
#include <queue>
#include <stack>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ll long long
#define ld long double
#define pb push_back
#define sz(s) int(s.size())
#define N 2010

const int hh[4] = {-1,0,1,0};
const int cc[4] = {0,1,0,-1};

int w,h,m,n,q,res;
int x1[N],y1[N],y2[N],x2[N];
int s[N][N];
bool fr[N][N];
int qx[N*N],qy[N*N];
vector<ii> Qx,Qy;

void roirac() {
    Qx.pb(ii(0,0));
    Qx.pb(ii(w,0));
    Qy.pb(ii(0,0));
    Qy.pb(ii(h,0));
    sort(Qx.begin(),Qx.end());
    sort(Qy.begin(),Qy.end());
    int dem=0, j = Qx[0].se;
    if (j<=n) x1[j]=0; else x2[j-n]=0;
    For(i,1,sz(Qx)-1) {
        if (Qx[i].fi!=Qx[i-1].fi) dem++;
        j = Qx[i].se;
        if (j<=n) x1[j]=dem; else x2[j-n]=dem;
    }
    w = dem;
    dem=0; j = Qy[0].se;
    if (j<=n) y1[j]=0; else y2[j-n]=0;
    For(i,1,sz(Qy)-1) {
        if (Qy[i].fi!=Qy[i-1].fi) dem++;
        j=Qy[i].se;
        if (j<=n) y1[j]=dem; else y2[j-n]=dem;
    }
    h = dem;
}

void bfs() {
    int left=0, right=1;
    while (left < right) {
        left++;
        int i=qx[left], j=qy[left];
        For(k,0,3) {
            int u=i+hh[k], v=j+cc[k];
            if (u && v && u<=w && v<=h && fr[u][v] && s[u][v]==0) {
                fr[u][v]=false;
                right++; qx[right]=u; qy[right]=v;
            }
        }
    }
}

void solve() {
    roirac();
    For(i,1,n) {
        int u1=x1[i]+1, v1=y1[i]+1, u2=x2[i], v2=y2[i];
        s[u1][v1]++; s[u2+1][v2+1]++;
        s[u2+1][v1]--; s[u1][v2+1]--;
    }
    For(i,1,w)
      For(j,1,h)
       s[i][j] = s[i-1][j] + s[i][j-1] - s[i-1][j-1] + s[i][j];
    memset(fr,true,sizeof(fr));
    For(i,1,w)
      For(j,1,h)
       if (fr[i][j] && s[i][j]==0) {
         res++;
         qx[1]=i; qy[1]=j; fr[i][j]=false;
         bfs();
       }
	/*printf("%d %d\n",w,h);
	For(i,1,h) {
		For(j,1,w) printf("%d",s[j][i]);
		printf("\n");
	}*/
    printf("%d",res);
}

int main() {
    freopen("MASKTAPE.INP","r",stdin);
    freopen("MASKTAPE.OUT","w",stdout);
    scanf("%d%d",&w,&h);
    scanf("%d",&n);
    For(i,1,n) {
        int u1,v1,u2,v2;
        scanf("%d%d%d%d",&u1,&v1,&u2,&v2);
        Qx.pb( ii(u1,i) );
        Qx.pb( ii(u2,i+n) );
        Qy.pb( ii(v1,i) );
        Qy.pb( ii(v2,i+n) );
    }
    solve();
}


