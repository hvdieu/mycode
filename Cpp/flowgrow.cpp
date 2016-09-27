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

ll m,n;
unsigned int k,BASE,c[8][8],f[8],res;

unsigned int Pow(unsigned int a, ll n) {
    unsigned int res = 1;
    while (n) {
        if (n & 1) res = (ll(res) * a) % BASE;
        n >>= 1;
        a = (ll(a) * a) % BASE;
    }
    return res;
}

int main() {
    freopen("input.txt","r",stdin);
    freopen("flowgrow.out","w",stdout);
    BASE = 2370823708;
    For(i,0,7) c[0][i] = 1;
    For(j,1,7) For(i,1,j) c[i][j] = c[i-1][j-1] + c[i][j-1];
    while (scanf("%lld %lld %d",&m,&n,&k) != -1) {
        f[1] = 1;
        For(i,2,7) {
            f[i] = Pow(i,n);
            For(j,1,i-1) f[i] = (ll(f[i]) + BASE - (ll(f[j]) * c[j][i]) % BASE) % BASE;
        }
       // For(i,1,7) cout << f[i] << ' '; cout << "\n";
        res = 0;
        For(i,k,7) res = (ll(res) + (ll(f[i]) * c[i][7]) % BASE) % BASE;
        cout << Pow(res,m) << "\n";
    }
}


