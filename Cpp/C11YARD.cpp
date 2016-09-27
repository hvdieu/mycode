#include <stdio.h>
#include <iostream>
#include <algorithm>
#include <math.h>
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
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ll long long
#define ld long double
#define pb push_back
#define sz(s) int(s.size())
#define N 2010
struct edge {
    int x,y1,y2,tt;
    edge(int a,int b,int c,int d) {
        x=a; y1=b; y2=c; tt=d;
    }
};

const int h[4] = {-1,0,1,0};
const int c[4] = {0,1,0,-1};

int m,n,k,s[N][N],a[N][N],res,t[4*N],f[4*N];
bool fr[N][N];
vector< edge > Q;
int qx[N*N],qy[N*N];
char ss[N];

bool cmp(edge A, edge B) {
    return A.x < B.x;
}

void update(int i,int lo,int hi,int u,int v, int x) {
    if (lo==u && hi==v) {
        f[i] += x;
        if (f[i]) t[i] = hi-lo+1;
          else if (lo!=hi) t[i] = t[i*2] + t[i*2+1];
            else t[i]=0;
        return;
    }
    int mid = (lo+hi)/2;
    if (u<=mid) update(i*2,lo,mid,u,min(mid,v),x);
    if (v>mid)  update(i*2+1,mid+1,hi,max(u,mid+1),v,x);
    if (f[i]) t[i] = hi-lo+1;
        else t[i] = t[i*2] + t[i*2+1];
}

void Area() {
    sort(Q.begin(),Q.end(),cmp);
    update(1,1,m,Q[0].y1,Q[0].y2,1);
    int i=1,sl = 0;
    while (i < Q.size()) {
        int X = Q[i].x - Q[i-1].x;
        sl += X * t[1];
        if (Q[i].y1 <= Q[i].y2) {
            if (!Q[i].tt) update(1,1,m,Q[i].y1,Q[i].y2,1);
              else update(1,1,m,Q[i].y1,Q[i].y2,-1);
        }
        i++;
    }
    res = max(res,sl);
}

void bfs() {
    int left = 0, right = 1,i,j,u,v;
    while (left < right) {
        left++;
        i = qx[left]; j = qy[left];
        For(t,0,3) {
            int u = i+h[t], v = j+c[t];
            if (u && v && u<=m-k+1 && v<=n-k+1 && a[u][v] && fr[u][v]) {
                right++;
                qx[right] = u; qy[right] = v;
                Q.push_back( edge(v,u,u+k-1,0) );
                Q.push_back( edge(v+k,u,u+k-1,1) );
                fr[u][v] = false;
            }
        }
    }
    Area();
}

void solve() {
    int x;
    For(i,1,m-k+1)
      For(j,1,n-k+1) {
        int u = i+k-1, v = j+k-1;
        x = s[u][v] - s[u][j-1] - s[i-1][v] + s[i-1][j-1];
        if (!x) a[i][j] = 1;
            else a[i][j] = 0;
      }
    memset(fr,true,sizeof(fr));
    For(i,1,m-k+1)
      For(j,1,n-k+1)
       if (fr[i][j] && a[i][j]) {
          qx[1] = i; qy[1] = j;
          fr[i][j] = false;
          Q.clear();
          Q.push_back( edge(j,i,i+k-1,0) );
          Q.push_back( edge(j+k,i,i+k-1,1) );
          bfs();
       }
    if (!res) printf("-1");
        else printf("%d",res);
}

int main() {
    freopen("c11yard.inp","r",stdin);
    //freopen("C11YARD.OU1","w",stdout);
    scanf("%d %d %d\n",&m,&n,&k);
    For(i,1,m) {
        cin >> (ss+1);
        For(j,1,n) {
            int x;
            if (ss[j]=='.') x=0; else x=1;
            s[i][j] = s[i-1][j] + s[i][j-1] - s[i-1][j-1]+x;
        }
    }
    solve();
}



