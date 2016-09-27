#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 100010

int n, c;
int x[N];

bool check(int len) {
    int dem = 0, last = -1000000000;
    For(i, 1, n) if (x[i] - last >= len) dem++, last = x[i];
    return dem >= c;
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d", &n, &c);
    For(i, 1, n) scanf("%d", x+i);
    sort(x+1, x+n+1);
    int d = 0, c = 1000000000, mid, ans;
    while (d <= c) {
        mid = (d + c) / 2;
        if (check(mid)) {
            ans = mid; d = mid + 1;
        } else c = mid - 1;
    }
    cout << ans;
}
