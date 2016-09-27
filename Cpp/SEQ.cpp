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
#define N 1000010
#define inf 1000000000000000000LL

int n, a[N], m;
ll sum, res;

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d", &n, &m);
    For(i, 1, n) scanf("%d", a+i);
    For(i, 1, n-1) sum += abs(a[i] - a[i+1]);
    For(i, 2, n-1) if (a[i] < a[i-1] && a[i] < a[i+1]) {
        int x = min(m, min(a[i-1], a[i+1])-a[i]);
        a[i] += x;
        m -= x;
    }
    if (a[1] < a[2]) {
        int x = min(m, a[2]-a[1]);
        m -= x; a[1] += x;
    }
    if (a[n] < a[n-1]) {
        int x = min(m, a[n-1] - a[n]);
        m -= x; a[n] += x;
    }
    int i = 1, j = n;
    while (m && i < j) {
        while (i < n && a[i] == a[i+1]) i++;
        while (j > 1 && a[j] == a[j-1]) j--;
        ll ca, cb;
        if (i < n && a[i] < a[i+1]) ca = ll(i)*(a[i+1] - a[i]);
        else ca = inf;
        if (j > 1 && a[j] < a[j-1]) cb = ll(n-j+1)*(a[j-1] - a[j]);
        if (min(ca, cb) > m) break;
        if (ca < cb) m -= ca, i++;
        else m -= cb, j--;
    }
    Rep(k, i, 1) a[k] = a[i];
    For(k, j, n) a[k] = a[j];
    For(i, 1, n-1) res += abs(a[i] - a[i+1]);
    cout << sum - res;
}
