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
#define N 100010

int root[N], n, res, m;

int getroot(int u) {
    return root[u] == u ? u : root[u] = getroot(root[u]);
}

int main() {
    freopen("connect.inp","r",stdin);
    freopen("connect.out","w",stdout);
    scanf("%d%d", &n, &m);
    For(i, 1, n) root[i] = i; res = n;
    For(i, 1, m) {
        int u, v;
        scanf("%d%d", &u, &v);
        int r1 = getroot(u), r2 = getroot(v);
        if (r1 != r2) {
            root[r1] = root[r2];
            res--;
        }
        if (res == 1) {
            cout << i;
            return 0;
        }
    }
    cout << "FAILURE";
}
