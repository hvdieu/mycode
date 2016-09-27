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
#define N 1000010
#define inf 100000000
#define MAX 1000000000

int n, a[N], f[N], res, b[N];
int t[N];
vector<ii> q;
int h[30][N];

void update(int i, int val) {
    for(i; i <= n; i += i & (-i)) t[i] = min(t[i], val);
}

int get(int i) {
    int s = inf;
    for(i; i; i -= i & (-i)) s = min(s, t[i]);
    return s;
}

int main() {
    //freopen("input.txt","r",stdin);
   // freopen("output.txt","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) {
        scanf("%d", a+i);
        q.pb(ii(a[i]-i, i));
    }
    q.pb(ii(0, 0));
    sort(all(q));
    int dem = 0;
    For(i, 0, sz(q)-1) {
        if (!i || q[i].fi != q[i-1].fi) dem++;
        b[q[i].se] = dem;
    }
    For(i, 1, dem) t[i] = inf;
    update(b[0], 0);
    res = n;
    For(i, 1, n) {
        f[i] = min(inf, get(b[i]) + i - 1);
        res = min(res, f[i] + n-i);
        update(b[i], f[i]-i);
    }
    cout << res;
}
