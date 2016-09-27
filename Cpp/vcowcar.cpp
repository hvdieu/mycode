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
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f,x) memset(f,x,sizeof(f))
#define N 50010

int n,a[N],m,d,l,res;

int main() {
   // freopen("","r",stdin);
   // freopen("","w",stdout);
   scanf("%d%d%d%d",&n,&m,&d,&l);
   For(i,1,n) scanf("%d",&a[i]);
   sort(a+1,a+n+1);
   For(i,1,n) if (a[i] - d * (res / m) >= l) res++;
   cout << res;
}


