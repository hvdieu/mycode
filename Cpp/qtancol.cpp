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
#define BASE 1000000007
#define N 2010

int m,k,f[N][N];

int main() {
    freopen("qtancol.inp","r",stdin);
    freopen("qtancol.out","w",stdout);
    scanf("%d%d",&n,&k);
    f[1][0] = 1;
    For(i,2,n) For(j,1,k)
}
