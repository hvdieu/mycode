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

char a[N],b[N];
int n,m,BASE,c,Q;

int phi(int x) {
    double res = x;
    int ss = ceil(sqrt(x));
    For(i,2,ss) if (x % i == 0) {
        res = res * (1 - double(1)/i);
        while (x % i == 0) x /= i;
    }
    if (x > 1) res = (res * (1 - double(1)/x));
    return ceil(res);
}

int mu(int a,int n,int BASE) {
    int res = 1;
    while (n) {
        if (n & 1) res = (ll(res) * a) % BASE;
        n >>= 1;
        a = (ll(a) * a) % BASE;
    }
    return res;
}

void solve() {
    c = phi(BASE);
    Q = 0;
    n = strlen(b+1);
    For(i,1,n) {
        int ch = int(b[i]) - int('0');
        Q = (ll(Q)*10 + ch) % c;
    }
    if (Q == 0) Q += c;
    n = strlen(a+1);
    int x = 0;
    For(i,1,n) x = (ll(x)*10 + int(a[i]) - int('0')) % BASE;
    int res = mu(x,Q,BASE);
    cout << res;
}

int main() {
    //freopen("tnhtest.inp","r",stdin);
    //freopen("tnhtest.out","w",stdout);
    scanf("%s\n",(a+1));
    scanf("%s\n",(b+1));
    scanf("%d",&BASE);
    solve();
}



