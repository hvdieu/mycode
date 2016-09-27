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
#define N 500010

int a[N], t[N], n, b[N], pos[N], res;

void update(int i, int val) {
    for(i; i <= n; i += i & (-i)) t[i] = max(t[i], val);
}

int get(int i) {
    int s = 0;
    for(i; i; i -= i & (-i)) s = max(s, t[i]);
    return s;
}

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d", &a[i]);
    For(i, 1, n) {
        scanf("%d", &b[i]);
        pos[b[i]] = i;
    }
    Rep(i, n, 1) {
        int x = get(pos[a[i]]) + 1;
        res = max(res, x);
        update(pos[a[i]], x);
    }
    cout << res;
}
