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
#define N 100010

struct node{
    int x,y,id;
};

int n;
int x[N],y[N],dx[N],dy[N];
node a[N];
ll res;

bool cmp(node A,node B) {
    return A.x < B.x;
}

void solve() {
    For(i,1,n) {
        a[i].x=x[i]; a[i].y=y[i]; a[i].id=i;
    }
    sort(a+1,a+1+n,cmp);
    int i,j,k;
    i=1;
    while (i<=n) {
        j=i;
        while ((j<n)&&(a[j+1].x==a[i].x)) j++;
        k=j-i+1;
        For(t,i,j) dx[a[t].id]=k;
        i=j+1;
    }
    For(i,1,n) {
        a[i].x=y[i]; a[i].y=x[i]; a[i].id=i;
    }
    i=1;
    while (i<=n) {
        j=i;
        while ((j<n)&&(a[j+1].x==a[i].x)) j++;
        k=j-i+1;
        For(t,i,j) dy[a[t].id]=k;
        i=j+1;
    }
    For(i,1,n) {
        ll xx=dx[i]; ll yy=dy[i];
        if ((xx>1)&&(yy>1)) res+=(xx-1)*(yy-1);
    }
    printf("%lld",res);
}

int main() {
    freopen("VOSRTRI.INP","r",stdin);
    freopen("VOSRTRI.OUT","w",stdout);
    scanf("%d",&n);
    For(i,1,n) scanf("%d%d",&x[i],&y[i]);
    solve();
}


