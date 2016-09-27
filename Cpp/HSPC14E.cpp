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
#define phi 40000000
#define BASE 100000000

int a,b,res;

int mu(int a,int n, int c) {
    ll res = 1;
    while (n) {
        if (n & 1) res = (res * a) % c;
        n >>= 1;
        a = (ll(a) * a) % c;
    }
    return res;
}


int main() {
    freopen("hspc14e.inp","r",stdin);
    //freopen("hspc14e.out","w",stdout);
    while (scanf("%d %d\n",&a,&b) != -1) {
        int x = a;
        if (b > 20) b = 20;
        For(i,2,b-1) x = mu(a,x,phi);
        //cout << x << "\n";
        if (x == 0) x += phi;
        if (b > 1) res = mu(a,x,BASE);
        else res = a;
        int len = 0; x = res;
        while (x) {
            len++; x /= 10;
        }
        For(i,1,8-len) cout << 0;
        if (res) cout << res;
        cout << "\n";
    }
}



