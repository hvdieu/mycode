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
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 1000010

int a, BASE, c;

int phi(int x) {
    int ss = trunc(sqrt(x));
    double z = x;
    For(i,2,ss) if (x % i == 0){
        z *= (1 - double(1)/i);
        while (x % i == 0) x /= i;
    }
    if (x > 1) z *= (1 - double(1)/x);
    return trunc(z);
}

int CalPow(int a, int n, int b) {
    int res = 1;
    while (n) {
        if (n & 1) res = (ll(res) * a) % b;
        n >>= 1;
        a = (ll(a) * a) % b;
    }
    return res;
}

int main() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> a >> BASE;
    c = phi(BASE);
    ll q = 1;
    For(i, 1, a) q = (q * 2) % c;
    if (!q) q += c;
    ll res = 1;
    For(i, 1, q) res = (res * 2) % BASE;
    cout << res;
}




