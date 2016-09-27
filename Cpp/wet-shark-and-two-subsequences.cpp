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
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 110
#define BASE 1000000007

int r, s, a[N], m, n, sa, sb, res;
int f[N][N][2001];

void add(int &a, int b) {
    a += b; if (a >= BASE) a -= BASE;
}

void cal(int len, int s) {
    reset(f, 0); f[0][0][0] = 1;
    For(i, 0, n-1) For(j, 0, len) For(sum, 0, s) if (f[i][j][sum]) {
        if (sum + a[i+1] <= s)
        add(f[i+1][j+1][sum+a[i+1]], f[i][j][sum]);
        add(f[i+1][j][sum], f[i][j][sum]);
    }
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> n >> r >> s;
    For(i, 1, n) cin >> a[i];
    if ((r-s)%2 || (r+s)%2) res = 0; else {
        cal(n, (r+s)/2);
        For(len, 1, n) add(res, (ll(f[n][len][(r+s)/2])*f[n][len][(r-s)/2]) % BASE);
    }
    cout << res;
}
