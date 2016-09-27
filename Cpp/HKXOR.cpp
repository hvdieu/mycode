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
#define N 500001
#define BASE 1000000007
#define inf 1E18

int n, m, bit[N][88];
ll a[N], f[N][2], g[N], res, mm;
int Q[100001];

void cal(int i, ll k) {
    Rep(j, m-1, 0) {
        if (k > g[j]) {
            bit[i][j] = 1;
            k -= g[j];
        }
    }
}

void sub2() {
    g[1] = 2; g[0] = 1;
    f[1][0] = 1; f[1][1] = 1;
    For(i, 2, 1000) {
        f[i][0] = f[i-1][0] + f[i-1][1];
        f[i][1] = f[i-1][0];
        g[i] = f[i][0] + f[i][1];
        if (f[i][1] > inf) {
            m = i; break;
        }
    }

    For(i, 1, n) cal(i, a[i]+1);
    ll power = 1;
    For(j, 0 ,m-1) {
        int mem = bit[1][j];
        For(i, 2, n) mem = mem ^ bit[i][j];
        if (mem != 0) res = (res + power) % BASE;
        power = (power * 2) % BASE;
    }
    cout << res;
}

int bug(int x, int i) {
    return (x >> i) & 1;
}

void sub1() {
    int dem = 0;
    for(int x = 1;; x++) {
        bool flag = true;
        For(j, 1, 30) if (bug(x, j) && bug(x, j-1)) {
            flag = false; break;
        }
        if (flag) Q[++dem] = x;
        if (dem == mm) break;
    }

    res = Q[a[1]];
    For(i, 2, n) res ^= Q[a[i]];
    cout << res;
}

int main() {
    freopen("HKXOR.in","r",stdin);
    freopen("HKXOR.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) {
        cin >> a[i]; mm = max(mm, a[i]);
    }
    if (mm <= 100000) sub1(); else
    sub2();
}
