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
#define N 20000001
#define NN 1048576

int M,BASE;
ll res,A,d,a,b,c,AA;
int dp[NN][2];

inline void CalPower(int n, ll a) {
    int x = n; ll res = 1;
    while (x) {
        if (x & 1) res *= a;
        if (res >= BASE) res %= BASE;
        a *= a;
        if (a >= BASE) a %= BASE;
        x >>= 1;
    }
    dp[n][0] = res;
    x = n; res = 1;
    a = AA;
    while (x) {
        if (x & 1) res *= a;
        if (res >= BASE) res %= BASE;
        a *= a;
        if (a >= BASE) a %= BASE;
        x >>= 1;
    }
    dp[n][1] = res;
}

inline int GetPower(ll n) {
    return (ll(dp[n & 1048575][0])*dp[n >> 20][1]) % BASE;
}

inline void init() {
	AA = A;
	For(i,1,20) AA = (AA*AA) % BASE;
    For(tt,0,(1 << 20)-1) CalPower(tt,A);
}

inline void solve() {
    A %= BASE;
    init();
    res = GetPower(a);
    //For(i,0,(1 << 20)-1) cout << dp[i][1] << "\n";
   // cout << dp[1][1];
    //cout << GetPower(1);
   // cout << dp[2][0];
    //cout << res << ' ';
    ll T = a;
 //   printf("%lld ",T);
    For(i,2,M) {
        T = (T*b+c) % d;
   //     printf("%lld ",T);
        res = (res + GetPower(T)) % BASE;
    }
    cout << res;
}

int main() {
   // freopen("VOSEXP.INP","r",stdin);
   // freopen("VOSEXP.OUT","w",stdout);
    cin >> M >> A >> a >> b >> c >> d >> BASE;
    solve();
}



