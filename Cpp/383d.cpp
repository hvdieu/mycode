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
#define N 1010
#define M 10010
#define BASE 1000000007

int n,a[N],f[N][2*M],bound,res;

int id(int i) {
    return i + bound;
}

int main() {
    //freopen("383d.inp","r",stdin);
    //freopen("383d.out","w",stdout);
    scanf("%d",&n);
    For(i,1,n) {
        scanf("%d",&a[i]);
        bound += a[i];
    }
    f[0][id(0)] = 1;
    For(i,1,n) {
        For(j,-bound,bound) {
            if (j - a[i] >= -bound) f[i][id(j)] = (f[i-1][id(j - a[i])] + f[i][id(j)]) % BASE;
            if (j + a[i] <= bound) f[i][id(j)] = (f[i-1][id(j + a[i])] + f[i][id(j)]) % BASE;
        }
        f[i][id(0)] = (f[i][id(0)] + 1) % BASE;
    }
    For(i,1,n) res = (ll(res) + ll(BASE) + ll(f[i][id(0)]) - 1) % BASE;
    cout << res;
}
