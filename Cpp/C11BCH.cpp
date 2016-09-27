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

int n;
long double x[N],y[N],res,S;

bool check(int x) {
    if (x>n/2) return true;
    if (n-x<3) return true;

}

void solve() {
    int d=1, c=n/2+1, mid;
    x[n+1]=x[1]; y[n+1]=y[1];
    For(i,1,n) S = S + (x[i+1]-x[i])*(y[i+1]+y[i]);
    S = abs(S)/2;
    res = 0;
    while (d<=c) {
        mid = (d+c)/2;
        if (check(mid)) {
            res=mid;
            c=mid-1;
        } else d=mid+1;
    }
}

int main() {
    freopen("C11BCH.INP","r",stdin);
    freopen("C11BCH.OUT","w",stdout);
    scanf("%d",&n);
    For(i,1,n) scanf("%Lf %Lf",&x[i],&y[i]);
    solve();
}


