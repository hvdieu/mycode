#include <iostream>
#include <stdio.h>
#include <algorithm>
#include <vector>
#include <math.h>
#include <cstring>
#define N 100010
#define For(i,a,b) for(int i=a; i<= b; i++)
#define Ford(i,b,a) for(int i=b; i>=a; i--)
#define first fi
#define second se
using namespace std;
struct Query {
    int t,x,y,id;
};

int m,n,t,x,y,dem,mm,dem1,dem2,sl;
vector<Query> Q[N],P;
vector<int> ke[N];
int deg[N],tin[N],tout[N],pos[N],root[N],kq[N];
bool visit[N];

void dfs(int u) {
    int j,v,c;
    visit[u]=true; tin[u]=++dem1;
    For(j,0,(int)ke[u].size()-1) {
        v=ke[u][j];
        if (visit[v]==false) dfs(v);
    }
    tout[u]=++dem2;
}

int GetRoot(int u) {
    if (u!=root[u]) root[u]=GetRoot(root[u]);
    return root[u];
}

void Union(int u,int v) {
    root[v]=root[u];
}

bool check(int u,int v) {
    if ((tin[u]<=tin[v])&&(tout[u]>=tout[v])) return true;
    return false;
}

int main() {
    freopen("cf.inp","r",stdin);
    freopen("cf.out","w",stdout);
    scanf("%d %d\n",&n,&m);
    Query K;
    For(i,1,m) {
        scanf("%d",&t);
        if (t==1) {
            scanf("%d %d\n",&x,&y);
            deg[x]++; ke[y].push_back(x);
            K.t=1; K.x=x; K.y=y;
            P.push_back(K);
        } else if (t==2) {
            scanf("%d\n",&x);
            K.t=2; K.x=x; pos[++sl]=x;
            P.push_back(K);
        } else {
            scanf("%d %d\n",&x,&y);
            mm++; K.x=x; K.id=mm;
            Q[y].push_back(K);
        }
    }
    memset(visit,false,n+1);
    For(i,1,n) if (deg[i]==0) dfs(i);
    For(i,1,n) root[i]=i;
    int sll=0;
    For(i,0,(int)P.size()-1) {
        if (P[i].t==1) {
            int r1=GetRoot(P[i].x), r2=GetRoot(P[i].y);
            Union(r1,r2);
        } else {
        	sll++;
            For(j,0,(int)Q[sll].size()-1) {
                int u=P[i].x, v=Q[sll][j].x;
                if ((check(v,u))&&(GetRoot(v)==GetRoot(u))) kq[Q[sll][j].id]=1;
                    else kq[Q[sll][j].id]=0;
            }
        }

    }
    For(i,1,mm) if (kq[i]==1) printf("%s\n","YES"); else printf("%s\n","NO");
}
