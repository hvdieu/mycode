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
typedef long long ll;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ld long double
#define pb push_back
#define sz(s) int(s.size())
#define N 100010

int n,q,K,a[N];
ll t[4*N],f[4*N],g[61],gg[61];
string kind;
vector<int> qq;

ll bat(ll x,int i) { return x | (ll(1)<<i); }
ll tat(ll x,int i) { return x & (~(ll(1)<<i)); }
int bit(ll x,int i) { return (x>>i)&1; }

void init(int i,int lo, int hi) {
    if (lo==hi) {
        t[i]=bat(0,a[lo]%K);
        return;
    }
    int mid=(lo+hi)/2;
    init(i*2,lo,mid); init(i*2+1,mid+1,hi);
    t[i] = t[i*2] | t[i*2+1];
}

void cc(int i,int x) {
    if (x==0) return;
    ll tt,t1,t2;
    tt = t[i]&g[x];
    t1 = t[i]&gg[x];
    t1=t1<<x;
    tt=tt>>(K-x);
    t[i] = tt|t1;
}

void down(int i) {
    int c1=i*2, c2=i*2+1;
    cc(c1,f[i]);
    cc(c2,f[i]);
    f[c1] = (f[c1]+f[i]) % K;
    f[c2] = (f[c2]+f[i]) % K;
    f[i]=0;
}

void update(int i,int lo,int hi,int u,int v,int x) {
    if (lo==u && hi==v) {
        f[i]=(f[i]+x) % K;
        cc(i,x);
        return;
    }
    int mid=(lo+hi)/2;
    down(i);
    if (u<=mid) update(i*2,lo,mid,u,min(mid,v),x);
    if (v>mid)  update(i*2+1,mid+1,hi,max(mid+1,u),v,x);
    t[i] = t[i*2] | t[i*2+1];
}

ll get(int i,int lo,int hi,int u,int v) {
    if (u<=lo && hi<=v) return t[i];
    if (lo>v || hi<u) return 0;
    int mid=(lo+hi)/2;
    down(i);
    return get(i*2,lo,mid,u,v) | get(i*2+1,mid+1,hi,u,v);
}

void QueryCount() {
    int R,m,x,mm,L,mid,ans,RR;
    ll t1,tt;
    mm=0; tt=0; ans = 0; L=1;
    scanf("%d%d",&R,&m);
    For(i,1,m) {
        scanf("%d",&a[i]);
        mm=max(mm,a[i]);
    }
    scanf("\n");
    if (mm>=K) {
        printf("0\n"); return;
    }
    RR=R;
    For(i,1,m) tt=bat(tt,a[i]);
    while (L<=R) {
        mid=(L+R)/2;
        t1=get(1,1,n,mid,RR);
        if ((t1|tt)==t1) {
            ans=mid;
            L=mid+1;
        } else R=mid-1;
    }
    printf("%d\n",ans);
}

void QueryDiff() {
    int L,R,res=0;
    ll tt;
    scanf("%d%d\n",&L,&R);
    tt = get(1,1,n,L,R);
    For(j,0,K-1)
     if (bit(tt,j)) res++;
    printf("%d\n",res);
}

int main() {
    freopen("NKSET.INP","r",stdin);
    freopen("NKSET.OUT","w",stdout);
    scanf("%d%d%d",&n,&q,&K);
    For(i,1,n) scanf("%d",&a[i]);
    init(1,1,n);
    For(i,0,K-1) {
        g[i]=0; gg[i]=((ll)1<<K)-1;
        For(j,K-1-i+1,K-1) {
            g[i]=bat(g[i],j);
            gg[i] = tat(gg[i],j);
        }
    }
    while (q) {
        q--;
        char s[6];
        scanf("%s",s);
        if (!strcmp(s,"ADD")) {
            int L,R,C,x;
            scanf("%d%d%d\n",&L,&R,&C);
            x = (C+abs(C)*K) % K;
            update(1,1,n,L,R,x);
        } else if (!strcmp(s,"COUNT")) QueryCount();
         else QueryDiff();
    }
}


