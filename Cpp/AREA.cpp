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
#define N 10010
#define M 30010

struct edge {
    int x,y1,y2,tt;
    edge(int a,int b,int c,int d) {
        x = a; y1 = b; y2 = c; tt = d;
    }
};

int n,t[4*M],f[4*M],res;
vector< edge > Q;

bool cmp(edge A,edge B) {
    return (A.x < B.x);
}

void update(int i,int lo,int hi,int u,int v, int x) {
    if (lo==u && hi==v) {
        f[i] += x;
        if (f[i]) t[i] = hi-lo+1;
             else t[i] = t[i*2] + t[i*2+1];
        return;
    }
    int mid = (lo+hi)/2;
    if (u<=mid) update(i*2,lo,mid,u,min(mid,v),x);
    if (v>mid)  update(i*2+1,mid+1,hi,max(u,mid+1),v,x);
    if (f[i]) t[i] = hi-lo+1;
        else t[i] = t[i*2] + t[i*2+1];
}

void solve() {
    sort(Q.begin(), Q.end(),cmp);
    int i = 1, m = Q.size(),last=Q[0].x;
    update(1,1,30000,Q[0].y1,Q[0].y2,1);
    while (i < m) {
        int X;
        X = Q[i].x - Q[i-1].x;
        res += X * t[1];
        if (Q[i].y1 <= Q[i].y2)
          if (Q[i].tt==0) update(1,1,30000,Q[i].y1,Q[i].y2,1);
            else   update(1,1,30000,Q[i].y1,Q[i].y2,-1);
        i++;
    }
    cout << res;
}

int main() {
    freopen("AREA.INP","r",stdin);
    freopen("AREA.OUT","w",stdout);
    scanf("%d",&n);
    For(i,1,n) {
        int x1,y1,x2,y2;
        scanf("%d%d%d%d",&x1,&y1,&x2,&y2);
        Q.push_back( edge(x1,y1+1,y2,0) );
        Q.push_back( edge(x2,y1+1,y2,1) );
    }
    solve();
}


