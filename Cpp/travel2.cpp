#include<iostream>
#include<cstdio>
#include<queue>
#include<vector>
#include<queue>

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
#define all(x) x.begin(), x.end()
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 1010
#define M 110
#define inf 1000000010000LL

struct node {
    ll val; int  u, e;
    node (ll a, int b, int c) {
        val = a; u = b; e = c;
    }
};

bool operator > (const node &a, const node &b) {
    return a.val > b.val;
}

int m, n, s, t, k, x[M], y[M], z[M];
ll d[2][N][M];
vector<int> ke[N], w[N];
priority_queue< node, vector<node>, greater<node> > heap;

void Dij(int t, int start) {
    For(i, 1, n) For(j, 0, m) d[t][i][j] = inf;
    d[t][start][0] = 0;
    heap.push(node(0, start, 0));
    while (!heap.empty()) {
        int u = heap.top().u, gt = heap.top().val, e = heap.top().e;
        heap.pop();
        if (gt == d[t][u][e] && e < m) {
            For(j, 0, sz(ke[u])-1) {
                int v = ke[u][j];
                if (d[t][v][e+1] > d[t][u][e] + w[u][j]) {
                    d[t][v][e+1] = d[t][u][e] + w[u][j];
                    heap.push(node(d[t][v][e+1], v, e+1));
                }
            }
        }
    }
}

void solve() {
    Dij(0, s);
    Dij(1, t);
    ll res = inf;
    For(i, 1, m) {
        int u = x[i], v = y[i], l = z[i];
        For(c1, 0, m) For(c2, 0, m) {
            int c3 = k - c1 - c2;
            if (c3 >= 0) {
                if (c3 % 2) {
                    res = min(res, d[0][u][c1] + ll(l)*c3 + d[1][v][c2]);
                    res = min(res, d[0][v][c1] + ll(l)*c3 + d[1][u][c2]);
                }
                else {
                    res = min(res, d[0][u][c1] + ll(l)*c3 + d[1][u][c2]);
                    res = min(res, d[0][v][c1] + ll(l)*c3 + d[1][v][c2]);
                }
            }
        }
    }
    cout << res;
}

int main() {
   //freopen("input.txt","r",stdin);
  //  freopen("output.txt","w",stdout);
    scanf("%d%d%d%d", &k, &m, &s, &t);
    n = 1000;
    For(i, 1, m) {
        int u, v, l;
        scanf("%d%d%d", &l, &u, &v);
        x[i] = u; y[i] = v; z[i] = l;
        ke[u].pb(v); ke[v].pb(u);
        w[u].pb(l); w[v].pb(l);
    }
    solve();
}
