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

struct Query {
    int l,r,id;
    Query(int a, int b, int c) {
        l = a; r = b; id = c;
    }
};

int n,m,k,q,mau[N],timer,num[N],a[N],sl[N],kq[N],con[N],p,res;
vector<int> ke[N];
vector<Query> Q;

void dfs(int u) {
    int v;
    num[u] = ++timer;
    a[timer] = mau[u];
    con[u] = 1;
    For(j,0,sz(ke[u])-1) {
        v = ke[u][j];
        dfs(v);
        con[u] += con[v];
    }
}

bool cmp(Query A,Query B) {
    if (A.l/p != B.l/p) return A.l/p < B.l/p;
    return A.r < B.r;
}

void push(int x) {
    sl[x]++;
    if (sl[x]==1) res++;
    if (sl[x]==(k+1)) res--;
}

void pop(int x) {
    sl[x]--;
    if (sl[x]==0) res--;
    if (sl[x]==k) res++;
}

void solve() {
    sort(Q.begin(),Q.end(),cmp);
    For(i,0,q-1) {
        if (!i || Q[i-1].l/p != Q[i].l/p) {
            res = 0;
            memset(sl,0,sizeof(sl));
            For(j,Q[i].l,Q[i].r) push(a[j]);
            kq[Q[i].id] = res;
        } else {
            For(j,Q[i-1].r+1,Q[i].r) push(a[j]);
            if (Q[i-1].l <= Q[i].l)
              For(j,Q[i-1].l,Q[i].l-1) pop(a[j]);
            else Rep(j,Q[i-1].l-1,Q[i].l) push(a[j]);
            kq[Q[i].id] = res;
        }
    }
    For(i,1,q) printf("%d\n",kq[i]);
}

int main() {
    freopen("C11COMP.INP","r",stdin);
   // freopen("C11COMP.OUT","w",stdout);
    scanf("%d%d%d",&n,&m,&k);
    p = int(sqrt(n));
    For(i,2,n) {
        int u;
        scanf("%d",&u);
        ke[u].push_back(i);
    }
    For(i,1,n) scanf("%d",&mau[i]);
    dfs(1);
    scanf("%d",&q);
    For(i,1,q) {
        int u;
        scanf("%d",&u);
        Q.push_back(Query(num[u],num[u]+con[u]-1,i));
    }
    solve();
}


