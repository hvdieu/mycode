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
#define inf 9223372036854775806LL

const int maxC = (1 << 20);

int n,k,T,mul,seed;
ll BASE,c,Q;
int a[maxC],p[maxC];
ll f[maxC];

inline ll phi(ll x) {
    int ss = ceil(sqrt(x));
    long double z = x;
    For(i,2,ss) if (x % i == 0){
        z *= (1 - double(1)/i);
        while (x % i == 0) x /= i;
    }
    if (x > 1) z *= (1 - double(1)/x);
    return ceil(z);
}

inline ll bigmod(ll a,ll b,ll c) {
    if (a <= (inf / b)) return (a * b) % c;
    if (a >= c) a %= c;
    if (b >= c) b %= c;
    if (a < b) swap(a,b);
    if (b == 0) return 0;
    if (b == 1) return a;
    ll temp = bigmod(a,b/2,c);
    temp = (temp + temp);
    if (temp >= c) temp -= c;
    if (b % 2 == 0) return temp;
    temp = (temp + a);
    if (temp >= c) temp -= c;
    return temp;
}

inline ll mu(ll a, ll n, ll c) {
    if (n == 0) return 1;
    if (n == 1) return a % c;
    ll temp = mu(a,n/2,c);
    temp = bigmod(temp,temp,c);
    if (n % 2 == 0) return temp;
    return bigmod(temp,a,c);
}

inline void init() {
    p[1] = 1;
    int ss = ceil(sqrt(maxC-1));
    For(i,2,ss) if (!p[i]){
        int j = i*i;
        while (j <= maxC-1) {
            p[j] = i;
            j += i;
        }
    }
}

inline void solve() {
    c = phi(BASE);
  //  cout << c << "\n";
    Q = mu(k,T,c);
    if (Q == 0) Q += c;
    ll res = 0;
    if (n >= 10000) {
        int x = (ll(mul) * seed + seed) % maxC;
        a[x]++;
        For(i,2,n) {
            x = (ll(x) * mul + seed) % maxC;
            a[x]++;
        }
        init();
        f[1] = 1; res = a[1];
        For(i,2,maxC-1) {
        if (!p[i]) f[i] = mu(i,Q,BASE);
            else f[i] = bigmod(f[i / p[i]] , f[p[i]], BASE);
        if (a[i]) res = (res + bigmod(f[i],a[i],BASE)) % BASE;
        }
    } else {
        int x = (ll(mul) * seed + seed) % maxC;
        res = mu(x,Q,BASE);
        For(i,2,n) {
            x = (ll(x) * mul + seed) % maxC;
            res = (res + mu(x,Q,BASE)) % BASE;
        }
    }
    cout << res;
}

int main() {
    freopen("vospow.inp","r",stdin);
    //freopen("vospow.out","w",stdout);
    cin >> n >> k >> T >> BASE;
    cin >> mul >> seed;
    solve();
}




