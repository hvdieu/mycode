#include <stdio.h>
#include <iostream>
#include <algorithm>
#include <math.h>
#include <cmath>
#include <vector>
#include <string>
#include <cstring>
#include <map>
#include <set>
#define For(i,a,b) for(int i=a;i<=b;i++)
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define N 301
#define NN 90010
#define Q 20001
#define PB push_back
using namespace std;
const int h[4] = {-1,0,1,0};
const int c[4] = {0,1,0,-1};
pair<int, int> a[NN];
vector<pair<int, int> > ke[NN];
int root[NN],w[NN],tin[NN],tout[NN],timer,cha[NN],vmax,n,q;
int f[NN][17],g[NN][17];
int b[N][N];
bool visited[NN];
struct edge {
    int val,u,v;
};
vector <edge> st;

int GetRoot(int u) {
    if (u!=root[u]) root[u]=GetRoot(root[u]);
    return root[u];
}

void Union(int u,int v) {
    root[v]=root[u];
}

void Kruskal() {
    For(i,0,(int)st.size()-1) {
        int uu=st[i].u, vv=st[i].v;
        int r1=GetRoot(uu), r2=GetRoot(vv);
        if (r1!=r2) {
            Union(r1,r2);
            pair<int,int> K; K.fi=vv; K.se=st[i].val;
            ke[uu].PB(K); K.fi=uu; ke[vv].PB(K);
        }
    }
}

void dfs(int u) {
    visited[u]=true; tin[u]=++timer;
    For(j,1,vmax) {
        f[u][j]=f[f[u][j-1]][j-1];
        g[u][j]=min(g[u][j-1],g[f[u][j-1]][j-1]);
    }
    for (int j=0;j<ke[u].size();j++) {
        int v=ke[u][j].fi;
        if (visited[v]==false) {
            cha[v]=u; f[v][0]=u; g[v][0]=ke[u][j].se;
            dfs(v);
        }
    }
    tout[u]=++timer;
}

bool check(int u,int v) {
    if ((tin[u]<=tin[v])&&(tout[u]>=tout[v])) return true;
    return false;
}

int lca(int u,int v) {
    if (check(u,v)) return u;
    if (check(v,u)) return v;
    Ford(j,vmax,0) if (check(f[u][j],v)==false) u=f[u][j];
    return cha[u];
}

int Query(int u,int v) {
    int m1=9999999=m2,pp=lca(u,v);
    if (pp!=v) {
        int vv=v;
        Ford(j,vmax,0) if (check(f[vv][j],u)==false) {
            m1=min(m1,g[vv][j]); vv=f[vv][j];
        }
        m1=min(m1,g[vv][0]);
    }
    if (pp!=u) {
        int uu=u;
        Ford(j,vmax,0) if (check(f[uu][j],v)==false) {
            m2=min(m2,g[uu][j]); uu=f[uu][j];
        }
        m2=min(m2,g[uu][0]);
    }
    return min(m1,m2);
}

bool cmp(edge A,edge B) {
    return A.val>B.val;
}

int main() {
    freopen("input.txt","r",stdin);
    freopen("output.txt","w",stdout);
    scanf("%d %d",&n,&q);
    For(i,1,n) For(j,1,n) {
        int k=(i-1)*n+j;
        scanf("%d",&a[k].fi);
        a[k].se = k; w[k]=a[k].fi; root[k]=k;
    }
    For(i,1,n)
	 For(j,1,n)
	  for(int k=0;k<=3;k++) {
        int u=i+h[k],v=j+c[k];
        if ((u>0)&&(u<=n)&&(v>0)&&(v<=n)) {
        int ii=(i-1)*n+j,jj=(u-1)*n+v;
        edge K; K.val=min(w[ii],w[jj]); K.u=ii;K.v=jj;
        st.PB(K);
  		}
    }
    sort(st.begin(),st.end(),cmp);
    Kruskal();
    vmax=(int)(log(n*n)/log(2));
    cha[1]=1; f[1][0]=1; g[1][0]=99999999;
    dfs(1);
    while (q>0) {
        int i1,i2,j1,j2;
        q--; scanf("%d%d%d%d",&i1,&j1,&i2,&j2);
        printf("%d\n",Query((i1-1)*n+j1,(i2-1)*n+j2));
    }
}

