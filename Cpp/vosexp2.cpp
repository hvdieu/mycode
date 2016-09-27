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

int M,BASE,A,first,last,length;
ll a,b,c,d,res;
int mu[N];

void init() {
    A = A % BASE;
    mu[0] = 1;
    For(i,1,N) {
        ll x = mu[i-1];
        x = x*A;
        if (x >= BASE) x %= BASE;
        mu[i] = x;
    }
}

int GetPower(ll x) {
    if (x <= N-1) return mu[x];
    ll temp = GetPower(x/2);
    temp = temp * temp;
    if (temp >= BASE) temp %= BASE;
    if (x%2==0) return temp;
    temp = temp*A;
    if (temp >= BASE) temp %= BASE;
    return temp;
}

void solve() {
    init();
    res = GetPower(a);
   // For(i,0,(1 << 20)-1) cout << GetPower(ll(i)<<20) << "\n";
   cout << GetPower(1048576);
    ll T = a;
   // cout << res << ' ';
    //printf("%lld ",T);
    For(i,2,M) {
        T = T*b+c;
        if (T >= d) T %= d;
      //  printf("%lld ",T);
        res += GetPower(T);
        if (res >= BASE) res %= BASE;
    }
  //  cout << res;
}

int main() {
    freopen("VOSEXP.INP","r",stdin);
    freopen("VOSEXP.OU1","w",stdout);
    cin >> M >> A >> a >> b >> c >> d >> BASE;
    solve();
}


