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
#define N 51
#define FORE(i, c) for(typeof(c.begin()) i=c.begin(); i!=c.end(); ++i)

int a[N], n;
int f[N][512];

int cal(int i, int x) {
    if (f[i][x] >= 0) return f[i][x];
    if (x == 511) return 1;
    if (i > n) return 0;
    int dem = 0, res = 0;
    For(j, 1, n) if ((x | a[j]) == x) dem++;
    For(j, 1, n) if ((x | a[j]) != x && !cal(i+1, x | a[j])) res = 1;
    if (dem-i && !cal(i+1, x)) res = 1;
    f[i][x] = res;
    return res;
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("orgame.inp","r",stdin);
    freopen("orgame.out","w",stdout);
    cin >> n;
    For(i, 1, n) cin >> a[i];
    reset(f, -1);
    if (cal(0, 0)) cout << "Fox Ciel"; else cout << "Toastman";
}
