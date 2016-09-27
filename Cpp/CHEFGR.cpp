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
const int N = 110;

int ntest,n,m,a[N],ma;

int main() {
   // freopen("input.txt","r",stdin);
   // freopen("output.txt","w",stdout);
    cin >> ntest;
    while (ntest) {
        ntest--;
        scanf("%d%d",&n,&m);
        ma = 0;
        For(i,1,n) {
            scanf("%d",&a[i]);
            ma = max(ma,a[i]);
        }
        For(i,1,n) m -= ma-a[i];
        if (m < 0 || (m%n)!=0) printf("No\n");
            else printf("Yes\n");
    }
}


