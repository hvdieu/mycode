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
#define N 1000010

int n,f[N][2];
char s[N];

int main() {
    freopen("overpass.inp","r",stdin);
    freopen("overpass.out","w",stdout);
    scanf("%d\n",&n);
    scanf("%s",(s+1));
    f[0][0] = 0; f[0][1] = 1;
    For(i,1,n) {
        if (s[i] == 'L') {
            f[i][0] = min(f[i-1][0]+1,f[i-1][1]+1);
            f[i][1] = min(f[i-1][1],f[i-1][0]+1);
        } else if (s[i] == 'R') {
            f[i][0] = min(f[i-1][0],f[i-1][1]+1);
            f[i][1] = min(f[i-1][1]+1,f[i-1][0]+1);
        } else {
            f[i][0] = f[i-1][0] + 1;
            f[i][1] = f[i-1][1] + 1;
        }
    }
    printf("%d",f[n][1]);
}
