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

ll n, res;
int a[16], len;
bool check[16][10][10][2][7];
ll f[16][10][10][2][7];

void val(ll x) {
    len = 0;
    while (x) {
        a[++len] = x % 10;
        x /= 10;
    }
}

ll cal(int i, int cs1, int cs2, int ok1, int ok2, int du) {
    if (i == 0) {
        if (ok1 && !du) return 1;
        return 0;
    }
    if (check[i][cs1][cs2][ok1][ok2][du]) return f[i][cs1][cs2][ok1][ok2][du]
    int c;
    if (ok2) c = x[i]; else c = 9;
    For(ch, 0, 9) {

    }
}

int main() {
    freopen("sign.inp","r",stdin);
    freopen("sign.out","w",stdout);
    while (scanf("%lld", &n) != -1) {
        val(n); res = 0;
        if (len > 3) {
            reset(check, false);
            For(i, 1, (len-1) / 2) res += cal(len, 10, 10, 0, 0, i);
        }
        printf("%lld\n", res);
    }
}
