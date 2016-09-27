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
typedef long double lb;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ll long long
#define ld long double
#define pb push_back
#define sz(s) int(s.size())
#define N 100010

struct point {
     double x,y;
};

int n;
point a[N];
double res;

bool cmp(point A, point B) {
    return A.x < B.x;
}

bool cmp2(point A,point B) {
    return A.y < B.y;
}

double Distance(point A,point B) {
    return sqrt((A.x-B.x)*(A.x-B.x) + (A.y-B.y)*(A.y-B.y));
}

void call(int l,int r) {
    if (l >= r) return;
    int mid = (l+r)/2;
    call(l,mid);
    call(mid+1,r);
    sort(a+l,a+1+r,cmp2);
    For(i,l,r)
     Ford(j,i-1,l) {
        lb D = Distance(a[i],a[j]);
        if (D >= res) break;
        res = D;
     }
}

int main() {
    freopen("NEAREST.INP","r",stdin);
    freopen("NEAREST.OUT","w",stdout);
    scanf("%d\n",&n);
    For(i,1,n) scanf("%lf %lf\n",&a[i].x,&a[i].y);
    sort(a+1,a+n+1,cmp);
    res = 1000000000;
    call(1,n);
    printf("%.3lf",res);
}


