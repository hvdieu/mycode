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

int n,a[N],res[N];
ll X,Y;

int main() {
    freopen("pseq.inp","r",stdin);
    freopen("pseq.out","w",stdout);
    scanf("%d",&n);
    For(i,1,n) scanf("%d",&a[i]);
    res[n] = 1;
    X = a[n];
    Rep(i,n-1,2) {
        if (X <= 0) {
            res[i] = 1;
            X += a[i];
        } else {
            res[i] = -1; X -= a[i];
        }
    }
    if (X <= 0) res[1] = 1;
    else res[1] = -1;
    For(i,1,n) if (res[i] < 0) printf("-"); else printf("+");
}
