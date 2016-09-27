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
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 1001

struct edge {
    int u, v, l;
};

bool cmp(edge a, edge b) {
    return a.l < b.l;
}

int n, root[N], m, res;
edge e[100010];

int getroot(int u) {
    return root[u] == u ? u : root[u] = getroot(root[u]);
}

int main() {
    freopen("howl.inp","r",stdin);
    freopen("howl.out","w",stdout);
    scanf("%d%d", &n, &m);
    For(i, 1, m) scanf("%d%d%d", &e[i].u, &e[i].v, &e[i].l);
    //For(i, 1, m) cout << e[i].u << e[i].v << e[i].l << endl;
    sort(e+1, e+m+1, cmp);
    //cout << 1 << endl;
    For(i, 1, n) root[i] = i;
    For(i, 1, m) {
        int r1 = getroot(e[i].u), r2 = getroot(e[i].v);
        if (r1 != r2) {
            res = e[i].l;
            root[r1] = root[r2];
        }
    }
    cout << res;
}
