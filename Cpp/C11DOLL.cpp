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
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ld long double
#define pb push_back
#define sz(s) int(s.size())
#define N 100010

int n,m,a[N],t[4*N],f[4*N],res;

void down(int i) {
    int c1 = i*2, c2 = i*2+1;
    t[c1] += f[i]; t[c2] += f[i];
    f[c1] += f[i]; f[c2] += f[i];
    f[i] = 0;
}

void update(int i,int lo,int hi,int u,int v, int x) {
    int mid = (lo+hi) / 2;
    if (lo == u && hi == v) {
        f[i] += x;
        t[i] += x;
        return;
    }
    down(i);
    if (u <= mid) update(i*2,lo,mid,u,min(mid,v),x);
    if (v > mid) update(i*2+1,mid+1,hi,max(u,mid+1),v,x);
    t[i] = min(t[i*2],t[i*2+1]);
}

void solve() {
    res = -1;
    if (a[1] < a[2]) res = 1;
    update(1,0,m,1,a[1],-1); update(1,0,m,0,a[2]-1,1);
    For(i,2,n/2) {
        update(1,0,m,0,a[i]-1,-1);
        update(1,0,m,0,a[i],-1);
        update(1,0,m,0,a[i*2]-1,1);
        update(1,0,m,0,a[i*2-1]-1,1);
        if (t[1] >= 0) res = i;
    }
    cout << res;
}

int main() {
    //freopen("c11doll.inp","r",stdin);
    //freopen("c11doll.out","w",stdout);
    scanf("%d%d",&n,&m);
    For(i,1,n) scanf("%d",&a[i]);
    solve();
}



