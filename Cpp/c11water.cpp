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
#define N 1001
#define inf 1000000002
const int h[4] = {-1,0,1,0};
const int c[4] = {0,1,0,-1};

struct node {
    int val, i, j;
    node (int a, int b, int c) {
        val = a; i = b; j = c;
    }
};

bool operator > (const node &a, const node &b) {
    return a.val > b.val;
}

int m, n, d[N][N], a[N][N];
priority_queue<node, vector<node>, greater<node> > heap;

void solve() {
    For(i, 1, m) For(j, 1, n) {
        if (i == 1 || j == 1 || i == m || j == n) {
            d[i][j] = a[i][j];
            heap.push(node(a[i][j], i, j));
        } else d[i][j] = inf;
    }

    while (!heap.empty()) {
        int gt = heap.top().val, i = heap.top().i, j = heap.top().j;
        heap.pop();
        if (gt == d[i][j]) {
            For(k, 0, 3) {
                int u = i + h[k], v = j + c[k];
                if (u && v && u <= m && v <= n) {
                    int cp;
                    if (a[u][v] >= gt) cp = a[u][v]; else cp = gt;
                    if (d[u][v] > cp) {
                        d[u][v] = cp;
                        heap.push(node(cp, u, v));
                    }
                }
            }
        }
    }
    ll res = 0;
    For(i, 1, m) For(j, 1, n) res += d[i][j] - a[i][j];
    cout << res;
}

int main() {
   // freopen("c11water.inp","r",stdin);
  //  freopen("c11water.out","w",stdout);
    scanf("%d %d", &m, &n);
    For(i, 1, m) For(j, 1, n) scanf("%d", &a[i][j]);
    solve();
}
