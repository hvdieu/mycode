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
#define N 1010

struct query {
    int kind, x1, y1, x2, y2;
};

int ntest, n, m, q, cnt, root[N*N], size[N*N], MAX;
int dd[N][N][3];
query Q[1000001];
ll res;

int GetRoot(int u) {
    if (u != root[u]) root[u] = GetRoot(root[u]);
    return root[u];
}

void Union(int r1, int r2) {
    cnt--;
    if (size[r1] < size[r2]) size[r2] += size[r1], root[r1] = r2;
    else size[r1] += size[r2], root[r2] = r1;
    MAX = max(MAX, max(size[r1], size[r2]));
}

int id (int x, int y) {
    return n * (x-1) + y;
}

void connect(int x1, int y1, int t) {
    if (dd[x1][y1][t]) return;
    int x2 = x1, y2 = y1;
    if (t == 1) y2++; else x2++;
    if (x2 <= m && y2 <= n) {
        int r1 = GetRoot(id(x1, y1));
        int r2 = GetRoot(id(x2, y2));
        if (r1 != r2) {
        	//printf("%d %d %d %d\n", x1, y1, x2, y2);
        	Union(r1, r2);
		}
    }
}

void init() {
    MAX = 1; cnt = m*n;
    For(i, 1, m*n) root[i] = i, size[i] = 1;
    For(i, 1, m) For(j, 1, n) {
        connect(i, j, 1);
        connect(i, j, 2);
    }
}

void solve() {
    res = 0;
    cnt = m*n;
    Rep(i, q, 1)
    if (Q[i].kind < 3) {
        dd[Q[i].x1][Q[i].y1][Q[i].kind]--;
        connect(Q[i].x1, Q[i].y1, Q[i].kind);
    } else if (Q[i].kind == 3)
        res += GetRoot(id(Q[i].x1, Q[i].y1)) == GetRoot(id(Q[i].x2, Q[i].y2));
    else res += MAX;
}

void inkq() {
    printf("%lld\n", res);
}

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d%d%d", &m, &n, &q);
        For(i, 1, q) {
            scanf("%d", &Q[i].kind);
            if (Q[i].kind < 3) {
                scanf("%d%d", &Q[i].x1, &Q[i].y1);
                dd[Q[i].x1][Q[i].y1][Q[i].kind]++;
            }
            else if (Q[i].kind == 3) scanf("%d%d%d%d", &Q[i].x1, &Q[i].y1, &Q[i].x2, &Q[i].y2);
        }
        init();
        solve();
        inkq();
    }
}
