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
#define N 40010

int n, d;
ll res;
int t[4*N][4], a[N];

void update(int i, int lo, int hi, int u, int x) {
    if (lo > u || hi < u) return;
    if (lo == hi) {
        if (i % 2 == 0) t[i][0] = x;
        else t[i][1] = x;
        return;
    }
    int mid = (lo + hi) / 2, c1 = i*2, c2 = c1+1;
    update(c1, lo, mid, u, x);
    update(c2, mid+1, hi, u, x);
    t[i][0] = max(t[c1][0], t[c1][2]);
    if (mid-lo > 0 && hi-mid > 1) {
        t[i][0] = max(t[i][0], t[c1][0] + max(t[c2][0], t[c2][3]));
        t[i][0] = max(t[i][0], t[c1][2] + t[c2][3]);
    }
    t[i][1] = max(t[c2][1], t[c2][2]);
    if (mid-lo > 0 && hi-mid > 1) {
        t[i][1] = max(t[i][1], max(t[c1][1], t[c1][3]) + t[c2][1]);
        t[i][1] = max(t[i][1], t[c1][3] + t[c2][2]);
    }
    if (hi-lo>1) {
        t[i][2] = t[c1][0] + t[c2][1];
        if (mid-lo>0) t[i][2] = max(t[i][2], t[c1][0] + t[c2][2]);
        if (hi-mid>1) t[i][2] = max(t[i][2], t[c1][2] + t[c2][1]);
    }
    t[i][3] = t[c1][3] + t[c2][3];
    if (hi-mid > 1) t[i][3] = max(t[i][3], t[c1][3] + t[c2][0]);
    if (mid-lo > 0) t[i][3] = max(t[i][3], t[c1][1] + t[c2][3]);
}

int main() {
    freopen("money.inp","r",stdin);
    freopen("money.out","w",stdout);
    scanf("%d%d", &n, &d);
    For(i, 1, n) {
        int u, x; scanf("%d", &x);
        update(1, 1, n, i, x);
    }
   // res += max(max(t[1][4], t[1][0]), max(t[1][1], t[1][2]));
    For(i, 1, d) {
    	int u, x; scanf("%d%d", &u, &x);
    	update(1, 1, n, u, x);
    	res += max(max(t[1][3], t[1][0]), max(t[1][1], t[1][2]));
	}
    cout << res;
}


