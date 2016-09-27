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
#define ld long double
#define pb push_back
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 100010
#define inf 1000000000
struct edge {
    int x, y, l, c;
};

struct node {
    int val, u;
    node(int a, int b) {
        val = a; u = b;
    }
};

bool operator > (const node &a, const node &b) {
    return a.val > b.val;
}

struct Query {
    int val, id;
};

int n, m, A, B, d[2][N], ntest, res[N], kq[N];
vector<int> ke[2][N], w[2][N];
edge Q[N];
Query P[N];
priority_queue <node, vector<node>, greater<node> > heap;

void Dij(int t, int start) {
    For(i, 1, n) d[t][i] = inf;
    d[t][start] = 0;
    heap.push(node(0, start));
    while (!heap.empty()) {
        int gt = heap.top().val, u = heap.top().u;
        heap.pop();
        if (gt == d[t][u]) {
            For(j, 0, sz(ke[t][u]) - 1) {
                int v = ke[t][u][j];
                if (d[t][v] > d[t][u] + w[t][u][j]) {
                    d[t][v] = d[t][u] + w[t][u][j];
                    heap.push(node(d[t][v], v));
                }
            }
        }
    }
}

bool cmp(Query A, Query B) {
    return A.val < B.val;
}

int Find (int d, int c, int key) {
    int mid, ans = -1;
    while (d <= c) {
        mid = (d + c) / 2;
        if (P[mid].val >= key) {
            ans = mid; c = mid - 1;
        } else d = mid + 1;
    }
    return ans;
}

void solve() {
    Dij(0, A);
	Dij(1, B);
    scanf("%d", &ntest);
    For(i, 1, ntest) {
        int D;
        scanf("%d", &D);
        P[i].val = D; P[i].id = i;
    }
    sort(P + 1, P + 1 + ntest, cmp);
    For(i, 1, m) {
        int u = Q[i].x, v = Q[i].y, len = Q[i].l;
        int x = d[0][u] + len + d[1][v];
        int j = Find(1, ntest, x);
        if (j != -1) res[j] += Q[i].c;
    }
    For(i, 1, ntest) {
        res[i] += res[i-1]; kq[P[i].id] = res[i];
    }
    For(i, 1, ntest) printf("%d\n", kq[i]);
}

int main() {
    freopen("king.inp","r",stdin);
    freopen("king.out","w",stdout);
    scanf("%d%d%d%d", &n, &m, &A, &B);
    For(i, 1, m) {
        int u, v, l, c;
        scanf("%d%d%d%d", &u, &v, &l, &c);
        Q[i].x = u; Q[i].y = v; Q[i].l = l; Q[i].c = c;
        ke[0][u].pb(v); w[0][u].pb(l);
        ke[1][v].pb(u); w[1][v].pb(l);
    }
    solve();
}
