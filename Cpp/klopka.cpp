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
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ll long long
#define ld long double
#define pb push_back
#define sz(s) int(s.size())

int n,xmin,xmax,ymin,ymax;

int main() {
  //  freopen("","r",stdin);
  //  freopen("","w",stdout);
    cin >> n;
    xmin = 110; ymin = 110;
    For(i,1,n) {
        int u,v;
        cin >> u >> v;
        xmin = min(xmin,u); xmax = max(xmax,u);
        ymin = min(ymin,v); ymax = max(ymax,v);
    }
    int x = max(ymax-ymin,xmax-xmin);
    cout << x*x;
}



