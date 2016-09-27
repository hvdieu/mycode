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
#define N 2000010

struct node {
    int f;
    int MAX, MIN;
    ll sum;
};

int m, n;
ll s[N];
ii a[N], b[N];
int t[N];

void update(int i, int val) {
    for(i; i <= n; i += i & (-i));
}

ll get(int i) {
    ll s = 0;
    for(i; i; i -= i & (-i)) s += t[i];
}

void inc(int l, int r, int val) {
    update(l, val);
    update(r+1, -val);
}

int Find(ll x) {
    int d = 1, c = n, mid, ans = -1;
    while (d <= c) {
        mid = (d+c)/2;
        if (s[mid] <= x) {
            ans = mid; d = mid+1;
        } else c = mid - 1;
    }
    if (ans < 0) return -1;
    x -= s[ans];
    if (x) ans++;
    if (ans > n) return -1;
    int val = b[ans].fi + get(ans);
    if (!val) return -1;
    int d = 1, c = n, mid, ans = -1;
    while (d <= c)
}

int main() {
    freopen("input.txt","r",stdin);
    freopen("output.txt","w",stdout);
    scanf("%d", &m);
    For(i, 1, m) scanf("%d%d", &a[i].se, &a[i].fi);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d%d", &b[i].se, &b[i].fi);
    sort(a+1, a+m+1, greater<ii> );
    sort(b+1, b+n+1, greater<ii> );
    For(i, 1, n) s[i] = s[i-1] + b[i].se;
    For(i, 1, m) {

    }
}
