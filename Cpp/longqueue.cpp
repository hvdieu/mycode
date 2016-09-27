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
#define N 200010

int n, k, m;
int a[N], t[N];

void update(int i, int val) {
    for(i; i <= n+m; i += i & (-i)) t[i] += val;
}

int get(int i) {
    int s = 0;
    for(i; i; i -= i & (-i))
	s += t[i];
    return s;
}

int main() {
    freopen("longqueue.inp","r",stdin);
    freopen("longqueue.out","w",stdout);
    scanf("%d%d", &n, &k);
    For(i, 1, n) scanf("%d", a+i);
    scanf("%d", &m);
    int res = 0;
    For(i, 1, n) if (a[i] >= k) update(i, 1), res++;
    int out = 0;
    For(test, 1, m) {
        int kind, u;
        scanf("%d", &kind);
        if (kind == 1) {
            scanf("%d", &u);
            a[++n] = u;
            if (u >= k) update(n, 1), res++;
        } else if (kind == 3) {
            scanf("%d", &u);
            u++; u += out;
            printf("%d\n", get(u-1));
        } else {
            out++; if (a[out] >= k) update(out, -1), res--;
        }
    }
}
