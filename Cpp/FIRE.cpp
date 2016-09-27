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
#define inf 1000000000
#define db double
struct node {
    ll x,y,r;
};

int n,m;
ll x[N],y[N],r[N];
double res;
node a[N];

bool cmp(node A,node B) {
    return ((A.x<B.x) || (A.x==B.x && A.y<B.y) || (A.x==B.x && A.y==B.y && A.r < B.r));
}

double distance(ll x1, ll y1, ll r1, ll x2, ll y2, ll r2) {
    return sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2))-r1-r2;
}

node gan(ll a, ll b, ll c) {
    node E;
    E.x=a; E.y=b; E.r=c;
    return E;
}

void solve() {
    res = 100000000;
    For(i,1,n) a[i]=gan(x[i],y[i],r[i]);
    sort(a+1,a+1+n,cmp);
    For(i,1,n)
      Ford(j,i-1,max(1,i-100)) res=min(res,distance(a[i].x,a[i].y,a[i].r,a[j].x,a[j].y,a[j].r));
    For(i,1,n) a[i]=gan(y[i],x[i],r[i]);
    sort(a+1,a+1+n,cmp);
    For(i,1,n)
      Ford(j,i-1,max(1,i-100)) res=min(res,distance(a[i].y,a[i].x,a[i].r,a[j].y,a[j].x,a[j].r));
    For(i,1,n) a[i]=gan(r[i],x[i],y[i]);
    sort(a+1,a+1+n,cmp);
    For(i,1,n)
      Ford(j,i-1,max(1,i-100)) res=min(res,distance(a[i].y,a[i].r,a[i].x,a[j].y,a[j].r,a[j].x));
    For(i,1,n) a[i]=gan(r[i],y[i],x[i]);
    sort(a+1,a+1+n,cmp);
    For(i,1,n)
      Ford(j,i-1,max(1,i-100)) res=min(res,distance(a[i].r,a[i].y,a[i].x,a[j].r,a[j].y,a[j].x));
    ll r1 = res*10000;
    res = (double)r1/10000;
    printf("%.4lf",res);
}

void solve2() {
    res=1000000;
    For(i,1,n)
        For(j,1,i-1)
		 res=min(res,distance(x[i],y[i],r[i],x[j],y[j],r[j]));
    printf("%.4lf",(res*100000)/100000);
}

int main() {
    freopen("input.txt","r",stdin);
    freopen("","w",stdout);
    scanf("%d",&n);
    For(i,1,n) scanf("%lld%lld%lld\n",&x[i],&y[i],&r[i]);
    solve();
    //solve2();
}


