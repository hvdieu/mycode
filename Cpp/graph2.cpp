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
#define N 1010
#define inf 1000000000

int n, a[N][N], d[N][N], k, l[N], s, t, temp;
bool dd[N], vs[N];
bool inqueue[N];
queue<int> q;
priority_queue<ii, vector<ii>, greater<ii> > heap;

inline void init(int i) {
    d[i][i] = 0;
    heap.push(ii(0, i));
    while (!heap.empty()) {
        int u = heap.top().se, gt = heap.top().fi;
        heap.pop();
        if (gt == d[i][u]) {
            For(v, 1, n) {
                int x = min(d[v][u], a[u][v]);
                if (d[i][v] > d[i][u] + x) {
                    d[i][v] = d[i][u] + x;
                    heap.push(ii(d[i][v], v));
                }
            }
        }
    }
}

bool cmp(int i, int j) {
    return d[s][i] < d[s][j];
}

void solve() {
    sort(l+1, l+k+1);
    For(i, 1, k / 2) {
        int j = rand() % (k / 2) + 1;
        swap(l[i], l[j]);
    }
    For(i, 1, k) {
        s = l[i], temp = -1, t;
        if (!vs[s]) {
			init(s); vs[s] = true;
		}
        For(j, 1, k) if (temp < d[s][l[j]]) {
            temp = d[s][l[j]]; t = l[j];
        }
        if (s < t) {
            bool flag = true;
            if (!vs[t]) init(t);
            For(j, 1, k) if (l[j] != s && l[j] != t)
            if (d[s][l[j]] + d[t][l[j]] != d[s][t]) {
                flag = false; break;
            }
            if (flag) {
                sort(l+1, l+k+1, cmp);
                For(i, 1, k) printf("%d ", l[i]);
                return;
            }
        }
    }
}

int main() {
    freopen("graph2.inp","r",stdin);
    freopen("graph2.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) For(j, 1, n) {
        scanf("%d", &a[i][j]);
        d[i][j] = inf;
    }
    scanf("%d", &k);
    For(i, 1, k) {
        int u;
        scanf("%d", &u); dd[u] = true;
        l[i] = u;
    }
    solve();
}
