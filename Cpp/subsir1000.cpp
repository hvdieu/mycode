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
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 100000

int n, f[N], p[N], res;
vector<int> prime;
void init() {
    int ss = trunc(sqrt(31622));
    For(i, 2, ss) if (!p[i]) {
        int j = i * i;
        while (j <= 31622) {
            p[j] = i;
            j = j + i;
        }
    }
    For(i, 2, 31622) if (!p[i]) prime.pb(i);
    cout << sz(prime);
}

int main() {
    freopen("subsir1000.in","r",stdin);
    //freopen("subsir1000.out","w",stdout);
   // scanf("%d", &n);
    init();
  /*  For(i, 1, n) {
        int x; scanf("%d", &x);
        int y = 0; prime.clear();
        while (p[x]) {
            int j = p[x]; y = max(y, f[j]);
            prime.pb(j);
            while (x % j == 0) x /= j;
        }
        if (x > 1) {
            y = max(y, f[x]);
            prime.pb(x);
        }
        res = max(res, y+1);
        For(j, 0, sz(prime)-1) f[prime[j]] = max(f[prime[j]], y+1);
    }
    cout << res;*/
}
