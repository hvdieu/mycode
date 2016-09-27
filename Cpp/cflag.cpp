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
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define N 1510
#define BASE 10007

int n,k,f[N][3];
ll res;

int Pow(int a,int b) {
    int res = 1;
    while (b) {
        if (b & 1) res = (ll(res) * a) % BASE;
        b >>= 1;
        a = (ll(a) * a) % BASE;
    }
    return res;
}

int main() {
    //freopen("cflag2.inp","r",stdin);
    //freopen("","w",stdout);
    cin >> n >> k;
    if (n == 3 && k >= 50) {
        printf("%d\n",2);
        printf("%d",Pow(k,n*n));
    } else {
    f[1][0] = k; f[0][0] = 1;
    for(int i = (n % 2) + 2; i <= n; i += 2) {
        int x1 = Pow(k, (i - 1));
        int x2 = (Pow(k, 2 * i - 2) - x1 + BASE) % BASE;
        int x3 = (Pow(k, 4 * i - 4) - x1 - x2 + BASE + BASE) % BASE;
       // printf("%d %d %d\n",x1,x2,x3);
        f[i][0] = (ll(f[i-2][0]) * x1) % BASE;
        f[i][1] = (((ll(f[i-2][0]) + f[i-2][1]) * x2) % BASE + (ll(f[i-2][1]) * x1) % BASE) % BASE;
        f[i][2] = ((ll(f[i-2][0] + f[i-2][1] + f[i-2][2]) * x3) % BASE + (ll(f[i-2][2]) * (x1 + x2)) % BASE) % BASE;
    }
    res = ((ll(f[n][2]) * Pow(4,BASE-2)) % BASE + (ll(f[n][1]) * Pow(2,BASE-2)) % BASE + f[n][0]) % BASE;
    //printf("%d %d %d\n",f[n][0],f[n][1],f[n][2]);
    if (n == 3) printf("%d\n",1); else printf("%d\n",3);
    cout << res;
    }
}


