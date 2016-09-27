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
#define N 500010
int n, q;
ll s[N];
ll x = 0;
int a[N];

int main() {
    //ios_base::sync_with_stdio(false);
   // freopen("input.txt","r",stdin);
   // freopen("","w",stdout);
    cin >> n;
    For(i, 1, n) {
        scanf("%d", &a[i]);
    }
    sort(a+1, a+n+1);
    For(i, 1, n) s[i] = s[i-1] + a[i];
    cin >> q;
    while (q) {
        q--;
        int y;
        scanf("%d", &y); x += y;
        int d = 1, c = n, mid, ans = 0;
        ll res = 0;
        while (d <= c) {
            mid = (d + c) / 2;
            if (a[mid] + x < 0) {
                ans = mid;
                d = mid + 1;
            } else c = mid - 1;
        }
        res = abs(s[ans] + x * ans) + (s[n] - s[ans] + x * (n - ans));
        printf("%lld\n", res);
    }
}
