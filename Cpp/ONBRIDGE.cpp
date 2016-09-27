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
#define N 50010

int ntest,n,m,root[N][2],cha[N],res,cnt,dd[N],child[N];

void init() {
    For(i,1,n) {
        root[i][0] = root[i][1] = i;
        child[i] = 1;
        cha[i] = -1;
    }
    res = 0;
}

int GetRoot(int u,int t) {
    if (t==0) {
        u=GetRoot(u,1);
        if (root[u][0]!=u) root[u][0] = GetRoot(root[u][0],0);
        return root[u][0];
    }
    if (u==-1) return -1;
    if (root[u][1]!=u) root[u][1] = GetRoot(root[u][1],1);
    return root[u][1];
}

void make_root(int u) {
    int v = GetRoot(u,1);
    int Root=v, cc=-1;
    while (v!=-1) {
        int pp = GetRoot(cha[v],1);
        cha[v] = cc;
        root[v][0] = Root;
        cc = v; v = pp;
    }
    child[Root] = child[cc];
}

void Union(int r1,int r2,int u, int v) {
    if (child[r1] > child[r2]) {
        swap(r1,r2);
        swap(u,v);
    }
    make_root(u);
    cha[u] = root[u][0] = v;
    child[r2] += child[u];
}

void Merge_Path(int u, int v) {
    int r1,r2,p;
    vector<int> qa,qb;
    int lca=-1;
    cnt++;
    while (1) {
        if (u!=-1) {
            p=GetRoot(u,1);
            qa.pb(p);
            if (dd[p]==cnt) {
                lca=p;
                break;
            }
            u=cha[p]; dd[p] = cnt;
        }
        if (v!=-1) {
            p=GetRoot(v,1);
            qb.pb(p);
            if (dd[p]==cnt) {
                lca=p;
                break;
            }
            dd[p]=cnt;
            v=cha[p];
        }
    }
    For(i,0,sz(qa)-1) {
        u = qa[i];
        if (u==lca) break;
        res--;
        root[u][1] = lca;
    }
    For(i,0,sz(qb)-1) {
        u=qb[i];
        if (u==lca) break;
        res--;
        root[u][1] = lca;
    }
}

void add_edge(int u,int v) {
    int r1,r2,p;
    r1 = GetRoot(u,0);
    r2 = GetRoot(v,0);
    if (r1!=r2) {
        Union(r1,r2,u,v);
        res++;
    } else {
        r1 = GetRoot(u,1);
        r2 = GetRoot(v,1);
        if (r1!=r2) Merge_Path(u,v);
    }
}

int main() {
    freopen("ONBRIDGE.INP","r",stdin);
    freopen("ONBRIDGE.OUT","w",stdout);
    scanf("%d",&ntest);
    while (ntest) {
        ntest--;
        scanf("%d%d",&n,&m);
        init();
        For(i,1,m) {
            int u,v;
            scanf("%d%d",&u,&v);
            u++; v++;
            add_edge(u,v);
            printf("%d\n",res);
        }
    }
}


