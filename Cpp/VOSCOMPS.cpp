#include <stdio.h>
#include <iostream>
#include <algorithm>
#include <math.h>
#include <vector>
#include <string>
#include <cstring>
#include <map>
#include <set>
#define For(i,a,b) for(int i=a;i<=b;i++)
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define pb push_back
#define sz size()
#define N 100010
using namespace std;
struct Query {
    int kind,u,v,time;
};

struct edge {
    int u,v,L,R;
};

struct DSU {
    int r1,l1,r2,l2;
};

vector<Query> a,b;
vector<edge> e,g;
vector<DSU> c;
int su[2*N], sv[2*N], st[2*N],top,n,m,p,kq[N],lab[N],cnt;

bool cmp(Query A,Query B) {
    return ((A.u<B.u) || ((A.u==B.u)&&(A.v<B.v)) || ((A.u==B.u)&&(A.v==B.v)&&(A.time<B.time)));
}

bool cmp2(Query A,Query B) {
    return A.time <= B.time;
}

void build(){
    edge E;
    top=0;
    for(int i=0;i<a.sz;i++) {
        if (i==0) {
            if (a[i].kind==1) {
                top++; su[top]=a[i].u; sv[top]=a[i].v; st[top]=a[i].time;
            }
        } else {
            if ((a[i].u==a[i-1].u)&&(a[i].v==a[i-1].v)) {
                if (a[i].kind==1) {
                    top++; su[top]=a[i].u; sv[top]=a[i].v; st[top]=a[i].time;
                } else if (top) {
                    E.u=a[i].u; E.v=a[i].v; E.L=st[top]; E.R=a[i].time;
                    top--;
                    e.pb(E);
                }
            } else {
                top=0;
                if (a[i].kind==1) {
                	top++; su[top]=a[i].u; sv[top]=a[i].v; st[top]=a[i].time;
           		}
            }
        }
    }
}

void Union(int r1,int r2, bool backup) {
    int x=lab[r1]+lab[r2];
    DSU E;
    if (backup) {
        E.r1=r1; E.r2=r2; E.l1=lab[r1]; E.l2=lab[r2];
        c.pb(E);
    }
    if (lab[r1]>lab[r2]) {
        lab[r1]=r2;
        lab[r2]=x;
    } else {
        lab[r2]=r1;
        lab[r1]=x;
    }
}

int GetRoot(int u) {
    while (lab[u]>0) u=lab[u];
    return u;
}

void Restore() {
    DSU d;
    while (!c.empty()) {
        d=c.back();
        int r1=d.r1,r2=d.r2, l1=d.l1, l2=d.l2;
        lab[r1]=l1; lab[r2]=l2;
        c.pop_back();
    }
}

bool giao(int L1,int R1, int L2,int R2) {
    if (R1 < L2) return false;
    if (L1 > R2) return false;
    return true;
}

void solve() {
    int L,R,r1,r2,j;
    L=1; j=0;
    while (L<=m) {
        R=min(m,L+p-1);
        g.clear();
        For(i,1,n) lab[i]=-1;
        for(int i=0; i<e.sz; i++) {
            if ((e[i].L<=L)&&(e[i].R>=R)) {
                r1=GetRoot(e[i].u); r2=GetRoot(e[i].v);
                if (r1!=r2) Union(r1,r2,false);
            } else if (giao(e[i].L,e[i].R,L,R)) g.pb(e[i]);
        }
        while ((j<b.sz)&&(b[j].time<=R)) {
            for(int i=0; i<g.sz; i++) {
                if ((b[j].time>=g[i].L)&&(b[j].time<=g[i].R)) {
                    r1=GetRoot(g[i].u); r2=GetRoot(g[i].v);
                    if (r1!=r2) Union(r1,r2,true);
                }
            }
            r1=GetRoot(b[j].u); r2=GetRoot(b[j].v);
            if (r1==r2) printf("YES\n"); else printf("NO\n");
            //printf("\n");
            Restore();
            j++;
            }
         L+=p;
        }
  //  For(i,1,cnt) printf("%d\n",kq[i]);
}

int main() {
    freopen("VOSCOMPS.INP","r",stdin);
    freopen("VOSCOMPS.OUT","w",stdout);
    scanf("%d %d\n",&n,&m);
    int kind,u,v;
    char c1,c2,c3,c4;
    Query E;
    p=int(sqrt(m)); cnt=0;
    For(i,1,m) {
        scanf("%c%c%c%c%d%d\n",&c1,&c2,&c3,&c4,&u,&v);
        if (u>v) swap(u,v);
        if (c1!='c') {
             E.u=u; E.v=v; E.time=i;
             if (c1=='a') E.kind=1; else E.kind=2;
            a.pb(E);
            if (c1=='a') {
                E.kind=2; E.time=m+1;
                a.pb(E);
            }
        } else {
            E.kind=++cnt; E.u=u; E.v=v; E.time=i;
            b.pb(E);
        }
    }
    sort(a.begin(),a.end(),cmp);
    //sort(b.begin(),b.end(),cmp2);
    build();
    solve();
}

