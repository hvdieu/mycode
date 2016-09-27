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
#define pb push_back
#define sz(s) int(s.size())
#define reset(f,x) memset(f,x,sizeof(f))
#define all(x) x.begin(), x.end()

ull A, B, f[20][200], lo, hi, res, mu[20];
bool check[20][200];

ull cal(int i, ull n, int sum) {
    ull l = n * mu[i], r = (n + 1) * mu[i] -  1;
    if (l > hi || r < lo) return 0;
    if (i == 0) return n && sum == 0;
    if (lo <= l && r <= hi && check[i][sum]) return f[i][sum];
    ull res = 0;
    For(j, 0, min(sum, 9)) res += cal(i-1, n * 10 + j, sum - j);
    if (lo <= l && r <= hi) {
        check[i][sum] = true; f[i][sum] = res;
    }
    return res;
}

int main() {
    freopen("snad.inp","r",stdin);
    freopen("snad.out","w",stdout);
    int ntest;
    scanf("%d", &ntest);
    mu[0] = 1; For(i, 1, 19) mu[i] = mu[i-1] * 10;
    while (ntest) {
        ntest--;
        cin >> A >> B;
        reset(check, false);
        res = 0;
        For(i, 1, 162) {
            lo = ceil( (long double)A / i );
            hi = B / i;
            res += cal(19, 0, i);
        }
        cout << res << endl;
    }
}


