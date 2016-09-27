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
#define N 1000010
#define inf 100000000

struct node {
    int ma,mb,f;
};

int n,m,r,a[N];
node t[5*N];

void init(int i,int lo,int hi) {
    if (lo == hi) {
        t[i].ma = a[lo]; t[i].mb = a[lo];
        return;
    }
    int mid = (lo+hi) / 2;
    init(i*2,lo,mid);
    init(i*2+1,mid+1,hi);
    t[i].ma = min(t[i*2].ma,t[i*2+1].ma);
    t[i].mb = max(t[i*2].mb,t[i*2+1].mb);
}

int find(int i, int lo, int hi, int tt) {
    if (lo == hi) return lo;
    int mid = (lo + hi) / 2;
    int l = i*2, r = i*2+1;
    if (!tt) {
        if ((!t[l].mb  && t[r].mb) || t[l].ma > t[r].ma) return find(r,mid+1,hi,tt);
        return find(l,lo,mid,tt);
    } else {
        if ((!t[l].mb && t[r].mb)  || t[l].mb < t[r].mb) return find(r,mid+1,hi,tt);
        return find(l,lo,mid,tt);
    }
}

void down(int i) {
    int l = i*2, r = i*2+1;
    if (t[l].mb) {
        t[l].ma += t[i].f; t[l].mb += t[i].f;
        t[l].f += t[i].f;
    }
    if (t[r].mb) {
        t[r].mb += t[i].f; t[r].ma += t[i].f;
        t[r].f += t[i].f;
    }
    t[i].f = 0;
}

void update(int i,int lo,int hi,int u,int v) {
    if (lo == u && hi == v) {
        if (t[i].mb) {
            t[i].ma++; t[i].mb++;
            t[i].f++;
        }
        return;
    }
    int mid = (lo+hi) / 2;
    down(i);
    if (u <= mid && t[i*2].mb) update(i*2,lo,mid,u,min(mid,v));
    if (v > mid && t[i*2+1].mb) update(i*2+1,mid+1,hi,max(mid+1,u),v);
    int x = inf;
    if (t[i*2].ma) x = t[i*2].ma;
    if (t[i*2+1].ma) x = min(x,t[i*2+1].ma);
    if (x == inf) x = 0;
    t[i].ma = x;
    t[i].mb = max(t[i*2].mb,t[i*2+1].mb);
}

void modify(int i,int lo,int hi,int u,int v) {
    if (lo == u && hi == v) {
        t[i].ma = 0; t[i].mb = 0;
        return;
    }
    int mid = (lo+hi) / 2;
    down(i);
    if (u <= mid && t[i*2].mb) modify(i*2,lo,mid,u,min(mid,v));
    if (v > mid && t[i*2+1].mb) modify(i*2+1,mid+1,hi,max(mid+1,u),v);
    int x = inf;
    if (t[i*2].ma) x = t[i*2].ma;
    if (t[i*2+1].ma) x = min(x,t[i*2+1].ma);
    if (x == inf) x = 0;
    t[i].ma = x;
    t[i].mb = max(t[i*2].mb,t[i*2+1].mb);
}

void solve() {
    init(1,1,n);
    while (m > 0) {
        m--;
        if (t[1].mb == 0) break;
        int j = find(1,1,n,0);
        int u = max(1,j-r), v = min(n,j+r);
        update(1,1,n,u,v);
        j = find(1,1,n,1);
        u = max(1,j-r); v = min(n,j+r);
        modify(1,1,n,u,v);
    }
    cout << t[1].mb;
}

int main() {
    freopen("borecole.inp","r",stdin);
   // freopen("borecole.out","w",stdout);
    scanf("%d%d%d",&n,&r,&m);
    For(i,1,n) scanf("%d",&a[i]);
    solve();
}
