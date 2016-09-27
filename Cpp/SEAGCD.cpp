#include <vector>
#include <algorithm>
#include <math.h>
#include <iostream>
#include <stdio.h>
#include <string.h>
#include <cmath>
#include <cstring>
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
#define ld long double
#define pb push_back
#define all(x) x.begin(), x.end()
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 10000010
#define BASE 1000000007

int ntest, n, M, L, R, a[N], b[N], res;

int CalPow(ll a, int n) {
    ll res = 1;
    while (n) {
        if (n & 1) res = res * a;
        if (res >= BASE) res %= BASE;
        n >>= 1;
        a = a * a; if (a >= BASE) a %= BASE;
    }
    return res;
}

int main() {
 //   freopen("seagcd.inp","r",stdin);
  //  freopen("seagcd.out","w",stdout);
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d%d%d%d", &n, &M, &L, &R);
        res = 0;
        Rep(d, M, L) {
            if (d < M && M / d == M / (d+1)) a[d] = a[d+1];
            else a[d] = CalPow(M / d, n);
            int S = 0;
            for(int i = 2*d; i <= M; i += d) {
                S += b[i];
                if (S >= BASE) S -= BASE;
            }
            b[d] = a[d] - S; if (b[d] < 0) b[d] += BASE;
            if (d <= R) res += b[d];
            if (res >= BASE) res -= BASE;
        }
        printf("%d\n", res);
    }
}
