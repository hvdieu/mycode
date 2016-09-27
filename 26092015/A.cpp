#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define REP(i, n) for(int i = 0; i < n; i++)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define getbit(x, i) ((x >> (i-1)) & 1LL)
#define onbit(x, i) (x | (1LL << (i-1)))
#define offbit(x, i) (x & ~(1 << (i-1)))
#define N 100010

int n, m, a[N];

bool check(int x) {
    int dem = 0;
    For(i, 1, n) {
        int y = (a[i] / x) + 1;
        if (a[i] % x == 0) y--;
        dem += y;
    }
    return dem <= m;
}

int main() {
   // freopen("input.txt","r",stdin);
   // freopen("","w",stdout);
    scanf("%d%d", &m, &n);
    For(i, 1, n) scanf("%d", &a[i]);
    int d = 0, c = 1000000000, res;
    while (d <= c) {
        int mid = (d + c) / 2;
        if (check(mid)){
            res = mid;
            c = mid - 1;
        } else d = mid + 1;
    }
    cout << res;
}


