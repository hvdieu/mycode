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
#define N 510
#define inf 1000000000

int n, a[N];
double mi, ma;

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> n;
    For(i, 1, n) cin >> a[i];
    sort(a+1, a+n+1);
    mi = inf; ma = -inf;
    double sum = 0;
    For(i, 1, n) {
        sum += a[i];
        mi = min(mi, sum / i);
    }
    sum = 0;
    Rep(i, n, 1) {
        sum += a[i];
        ma = max(ma, sum / (n-i+1));
    }
    cout << trunc(ma-mi);
}
