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
#define pb push_back
#define sz(s) int(s.size())
#define reset(f,x) memset(f,x,sizeof(f))
#define all(x) x.begin(), x.end()
#define N 710
#define eps 0.00000000001
#define inf 1000000000
const int h[4] = {-1, 0, 1, 0};
const int c[4] = {0, 1, 0, -1};

struct edge {
    int u, v;
    double time;
    edge (int a, int b, double c) {
        u = a; v = b; time = c;
    }
};

int a[N][N], b[N][N], root[N][N], dem, lab[N*N], f[N*N], g[N*N], res, n;
vector<edge> Q;
queue<int> qx, qy;

double cal(int a1, int b1, int a2, int b2) {
    if (a1 == a2) return inf;
    return double(b2 - b1) / (a1 - a2);
}

void bfs() {
    while (!qx.empty()) {
        int i = qx.front(), j = qy.front();
        qx.pop(); qy.pop();
        root[i][j] = dem; f[dem]++; g[dem]++;
        For(k, 0, 3) {
            int u = i + h[k], v = j + c[k];
            if (u && v && u <= n && v <= n) {
                if (a[u][v] == a[i][j] && b[u][v] == b[i][j] && !root[u][v]) {
                    root[u][v] = dem;
                    qx.push(u); qy.push(v);
                }
                else if (root[u][v] && root[u][v] != root[i][j]) {
                    double x = cal(b[i][j], a[i][j], b[u][v], a[u][v]);
                    if (x < inf) Q.pb(edge(root[i][j], root[u][v], x));
                }
            }
        }
    }
}

bool cmp(edge a, edge b) {
    return a.time < b.time;
}

int getroot(int u) {
    if (lab[u] != u) lab[u] = getroot(lab[u]);
    return lab[u];
}

void Union(int r1, int r2) {
    if (f[r1] < f[r2]) {
        f[r2] += f[r1];
        lab[r1] = r2;
    } else {
        f[r1] += f[r2];
        lab[r2] = r1;
    }
    res = max(res, max(f[r1], f[r2]));
}

void solve() {
    For(i, 1, n) For(j, 1, n) if (!root[i][j]) {
        dem++; qx.push(i); qy.push(j);
        bfs();
    }
    sort(Q.begin(), Q.end(), cmp);
    For(i, 1, dem) lab[i] = i;
    int i = 0;
    while (i < sz(Q)) {
        int j = i;
        while (j < sz(Q)-1 && abs(Q[j+1].time - Q[i].time) <= eps) j++;
        For(k, i, j) {
            int u = Q[k].u, v = Q[k].v;
            int r1 = getroot(u), r2 = getroot(v);
            if (r1 != r2) Union(r1, r2);
        }
        For(k, i, j) {
            int u = Q[k].u, v = Q[k].v;
            lab[u] = u; lab[v] = v; f[u] = g[u]; f[v] = g[v];
        }
        i = j + 1;
    }
    //cout << sz(Q) << endl;
    cout << res;
}

int main() {
    freopen("suma.inp","r",stdin);
    //freopen("suma.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) For(j, 1, n) scanf("%d", &a[i][j]);
    For(i, 1, n) For(j, 1, n) scanf("%d", &b[i][j]);
    solve();
}


