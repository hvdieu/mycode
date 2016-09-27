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
#define N 9

int n, m, a[N], test;
int u[N*N], v[N*N];
map<vector<int>, int> f[9];
vector<int> p, q;
ll res;
int dd[N*N];

void trau(int i) {
    if (dd[i]) {
        f[dd[i]][p]++;
        if (dd[i] == n) return;
    }
    int x = u[i], y = v[i];
        p[x] += 3;
        trau(i+1);
        p[x] -= 3;

        p[x]++; p[y]++;
        trau(i+1);
        p[x]--; p[y]--;

        p[y] += 3;
        trau(i+1);
        p[y] -= 3;
}

void ql(int i) {
    if (i > m) {
        REP(j, 8) q[j] = a[j] - p[j];
        if (f[n].find(q) != f[n].end()) res += f[n][q];
        return;
    }
    int x = u[i], y = v[i];
        if (p[x] + 3 <= a[x]) {
        p[x] += 3;
        ql(i+1);
        p[x] -= 3;
    }
    if (p[x] + 1 <= a[x] && p[y] + 1 <= a[y]) {
        p[x]++; p[y]++;
        ql(i+1);
        p[x]--; p[y]--;
    }
    if (p[y] + 3 <= a[y]) {
        p[y] += 3;
        ql(i+1);
        p[y] -= 3;
    }
}

void solve() {
    res = 0;
    REP(i, 8) p[i] = 0, q[i] = 0;
	m = (n * (n + 1)) / 2;
    ql(m/2+1);
}

void init() {
    m = 0; n = 5;
    For(i, 1, n) {
        int mm = (i * (i-1)) / 2;
        dd[mm/2+1] = i;
    }
    REP(i, n) REP(j, i) {
        u[++m] = i; v[m] = j;
    }
    For(i, 1, 8) p.pb(0), q.pb(0);
    trau(1);
}

int main() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    init();
    while (1) {
        scanf("%d", &n);
        if (!n) break;
        test++;
        reset(a, 0);
        REP(i, n) scanf("%d", a + i);
        solve();
        printf("Case #%d: %lld\n", test, res);
    }
}


