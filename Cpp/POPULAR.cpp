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
#define N 150010
using namespace std;
int n,m,low[N],num[N],timer,cnt,lab[N],q[N],pos[N],top,din[N],dout[N];
vector<int> ke[N],st,ke2[N],ku[N];
bool fr[N],popular[N];

void dfs(int u) {
    int v;
    num[u]=++timer; low[u]=num[u];
    st.pb(u);
    for(int j=0;j<ke[u].sz;j++) {
        v=ke[u][j];
        if (fr[v]) {
            if (num[v]==0) {
                dfs(v);
                low[u]=min(low[u],low[v]);
            } else low[u]=min(low[u],num[v]);
        }
    }
    if (low[u]==num[u]) {
        lab[u]=++cnt;
        do {
            v=st.back(); st.pop_back();
            lab[v]=cnt; fr[v]=false;
        } while (u!=v);
    }
}

void build() {
    int v;
    For(u,1,n) {
        st.clear();
        for(int j=0;j<ke[u].sz;j++) {
            v=ke[u][j];
            if (lab[v]!=lab[u]) st.pb(lab[v]);
        }
        sort(st.begin(),st.end());
        st.erase(unique(st.begin(),st.end()),st.end());
        for(int j=0;j<st.sz;j++) {
            ke2[lab[u]].pb(st[j]);
            dout[lab[u]]++; din[st[j]]++;
        }
    }
}

void visit(int u) {
    int v;
    fr[u]=false;
    for(int j=0;j<ke2[u].sz;j++) {
        v=ke2[u][j];
        if (fr[v]) visit(v);
    }
    q[--top]=u; pos[u]=top;
}

void Dp() {
    int dem1=0, dem2=0,v;
    Ford(i,cnt,1) if (din[q[i]]==0) dem2++;
    For(i,1,cnt) {
        int u=q[i];
        for(int j=0;j<ku[u].sz;j++) {
            int uu=ku[u][j];
            if (dout[uu]==0) dem1--; dout[uu]++;
            if (din[u]==0) dem2--; din[u]++;
        }
        if (din[u]==0) dem2--;
        if ((dem1==0)&&(dem2==0)) popular[u]=true;
        if (din[u]==0) dem2++;
        if (dout[u]==0) dem1++;
        if (din[u]==0) dem2--;
        for(int j=0;j<ke2[u].sz;j++) {
            v=ke2[u][j];
            dout[u]--; if (dout[u]==0) dem1++;
            din[v]--; if (din[v]==0) dem2++;
            ku[v].pb(u);
        }
    }
    int res=0;
    For(i,1,n) if (popular[lab[i]]) res++;
    printf("%d\n",res);
    For(i,1,n) if (popular[lab[i]]) printf("%d ",i);
}

int main() {
    freopen("popular.inp","r",stdin);
    freopen("popular.out","w",stdout);
    scanf("%d %d\n",&n,&m);
    For(i,1,m) {
        int u,v;
        scanf("%d %d\n",&u,&v);
        ke[u].pb(v);
    }
    memset(fr,true,sizeof(fr));
    For(i,1,n)
     if (num[i]==0) dfs(i);
    build();
    memset(fr,true,sizeof(fr));
    top = cnt+1;
    For(i,1,cnt)
      if (fr[i]) visit(i);
    Dp();
}

