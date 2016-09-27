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
#define N 101
#define F 501
#define inf 1000000000

struct node {
    double val;
    int i, j, ff;
    node (double a, int b, int c, int d) {
        val = a; i = b; j = c; ff = d;
    }
};

bool operator > (const node &a, const node &b) {
    return a.val > b.val;
}

int n, m, f, k, dem[N][N];
double a[N][N], d[N][N][F];
bool gas[N][N];
priority_queue <node, vector<node>, greater<node> > heap;

const int h[4] = {-1,0,1,0};
const int c[4] = {0,1,0,-1};

void solve() {
    For(i, 1, m) For(j, 1, n) For(t, 0, f) d[i][j][t] = inf;
    d[1][1][f] = 0;
    heap.push(node(0, 1, 1, f));
    while (!heap.empty()) {
        double gt = heap.top().val; int i = heap.top().i, j = heap.top().j, ff = heap.top().ff;
        heap.pop();
        if (gt == d[i][j][ff]) {
            if (ff < f && gas[i][j]) {
                if (d[i][j][ff + 1] > d[i][j][ff] + a[i][j]) {
                    d[i][j][ff + 1] = d[i][j][ff] + a[i][j];
                    heap.push(node(d[i][j][ff + 1], i, j, ff + 1));
                }
            }

            if (ff) For(k, 0, 3) {
                int u = i + h[k], v = j + c[k];
                if (u && v && u <= m && v <= n && d[u][v][ff - 1] > d[i][j][ff]) {
                    d[u][v][ff - 1] = d[i][j][ff];
                    heap.push(node(d[u][v][ff - 1], u, v, ff - 1));
                }
            }
        }
    }
    double res = inf;
    For(ff, 0, f) res = min(res, d[m][n][ff]);
    if (res < inf) {
        printf("%.2lf\n", res);
    } else printf("-1\n");
}

int main() {
    freopen("gas.inp","r",stdin);
    freopen("gas.out","w",stdout);
    int ntest;
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d %d %d %d", &n, &m ,&f, &k);
        reset(gas, false);
        For(i, 1, k) {
            int u, v;
            double C;
            cin >> u >> v >> C;
            if (gas[u][v]) a[u][v] = min(a[u][v], C);
            else { gas[u][v] = true; a[u][v] = C;
            }
            dem[u][v]++;
        }
        solve();
    }
}
