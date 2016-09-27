#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 1010

const int h[2] = {0, 1};
const int c[2] = {1, 0};

struct edge {
    int u, v, time;
    edge (int a, int b, int c) {
        u = a; v = b; time = c;
    }
};

bool cmp(edge a, edge b) {
    return a.time < b.time;
}

int n, a[N][N], root[N*N], res, f[N*N];
vector<edge> Q;

int id(int i, int j) {
    return (i-1)*n + j;
}

int getroot(int u) {
    if (root[u] != u) root[u] = getroot(root[u]);
    return root[u];
}

void Union(int r1, int r2) {
    if (f[r1] < f[r2]) {
        root[r1] = r2;
        f[r2] += f[r1];
    } else {
        root[r2] = r1;
        f[r1] += f[r2];
    }
    res = max(res, f[r1]);
    res = max(res, f[r2]);
}

void solve() {
    For(i, 1, n*n) {
        root[i] = i;
        f[i] = 1;
    }
    res = 1;
    For(i, 1, n) For(j, 1, n) For(k, 0, 1) {
        int u = i + h[k], v = j + c[k];
        if (u && v && u <= n && v <= n) Q.pb(edge(id(i, j), id(u, v), abs(a[i][j] - a[u][v])));
    }
    sort(all(Q), cmp);
    int i = 0;
    while (i <= sz(Q)-1) {
        int j = i;
        while (j < sz(Q)-1 && Q[i].time == Q[j+1].time) j++;
        For(k, i, j) {
            int r1 = getroot(Q[k].u), r2 = getroot(Q[k].v);
            if (r1 != r2) Union(r1, r2);
        }
        For(k, i, j) {
            int u = Q[k].u, v = Q[k].v;
            root[u] = u; root[v] = v;
            f[u] = 1; f[v] = 1;
        }
        i = j + 1;
    }
    //cout << sz(Q) << endl;
    cout << res;
}

int main() {
 //   freopen("RSELECT.INP","r",stdin);
 //   freopen("RSELECT.OUT","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) For(j, 1, n) scanf("%d", &a[i][j]);
    solve();
}




