#include <bits/stdc++.h>
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

ll BASE, res, last, first, k, nho;

int main() {
    freopen("multi.inp","r",stdin);
   // freopen("multi.out","w",stdout);
    while (scanf("%lld%lld%lld\n", &BASE, &last, &k) != -1) {
        res = 0;
        first = last;
        while (1) {
            res++;
            ll x = last * k + nho;
            last = x % BASE;
            nho = x / BASE;
            if (nho == 0 && last == first) break;
        }
        printf("%lld\n", res);
    }
}
