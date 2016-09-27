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
#define reset(f,x) memset(f,x,sizeof(f))
#define N 10010

int n,m,ntest,k,a[N],b[N],l[N],r[N],f[N][2];

int main() {
    freopen("box.inp","r",stdin);
    freopen("box.out","w",stdout);
    scanf("%d",&ntest);
    while (ntest) {
        ntest--;
        scanf("%d%d%d",&n,&k,&m);
        For(i,1,k) scanf("%d",&b[i]);
        For(i,1,m) scanf("%d",&a[i]);
        sort(a+1,a+m+1);
        int j = 1;
        For(i,1,m) {
            while (j <= k && b[j] < a[i]) j++;
            if (j <= k) r[i] = b[j]-1; else r[i] = n;
            if (j == 1) l[i] = 1; else l[i] = b[j-1]+1;
        }
        reset(f,0);
        f[0][0] = 1;
        For(i,1,m) {
            int u = a[i] - l[i];
            int v = r[i] - a[i];
            if (!u) {
                if (f[i-1][0]) f[i][0] = 1;
                if (f[i-1][1]) f[i][1] = 1;
            } else {
                if (f[i-1][0]) f[i][1] = 1;
                if (f[i-1][1]) f[i][0] = 1;
            }
            if (!v) {
                if (f[i-1][0]) f[i][0] = 1;
                if (f[i-1][1]) f[i][1] = 1;
            } else {
                if (f[i-1][0]) f[i][1] = 1;
                if (f[i-1][1]) f[i][0] = 1;
            }
        }
        if (f[m][1]) cout << 1; else cout << 0;
    }
}
