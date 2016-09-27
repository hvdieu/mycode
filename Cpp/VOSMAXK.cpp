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
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 1000010

int n, k, top;
ll res;

int main() {
    freopen("vosmaxk.inp","r",stdin);
    freopen("vosmaxk.out","w",stdout);
    scanf("%d%d", &n, &k);
    int first = 0, last = -1;
    For(i, 1, n) {
        int x;
        scanf("%d", &x);
        if (x == k) last = i;
        if (x > k) first = i;
        if (first >= 0 && last > 0 && first <= last) res += last - first;
    }
    cout << res;
}




