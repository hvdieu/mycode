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
#define eps 0.00000001


double a1,b1,c1,a2,b2,c2,x,y,hs;

int main() {
    freopen("sle.inp","r",stdin);
    freopen("sle.out","w",stdout);
    cin >> a1 >> b1 >> c1;
    cin >> a2 >> b2 >> c2;
    if (a1*b2 == a2*b1 && b1*c2 == b2*c1) printf("INFINITE");
    else if (a1*b2 == a2*b1 && b1*c2 != b2*c1) printf("NO SOLUTION");
    else {
        hs = a1 / a2;
        y = (c2*hs - c1) / (b2*hs - b1);
        x = (c1 - b1*y) / a1;
        printf("%.2lf %.2lf",x, y);
    }
}
