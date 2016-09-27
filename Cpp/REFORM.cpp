#include <bits/stdc++.h>

using namespace std;

typedef long long ll;
typedef pair<int, int> ii;
typedef long double ld;

#define For(i, a, b) for(int i = a; i <= b; i++)
#define Rep(i, a, b) for(int i = a; i >= b; i--)
#define fi first
#define se second
#define pb push_back
#define all(x) x.begin(), x.end()
#define sz(x) (int(x.size()))
#define reset(f, x) memset(f, x, sizeof(f))
#define bit(x, i) ((x >> i) & 1)
#define two(x) (1LL << x)
#define onbit(x, i) (x | (1LL << i))
#define N 100010
#define M 200010

int n, m, x[M], y[M], a[101][101], cnt, low[N], num[N], timer, cha[N];
int dem[N], con[N];
ll res;
vector<int> ke[N];
bool fr[N], was[101];

void visit(int u) {
    was[u] = false;
    For(v, 1, n) if (a[u][v] && was[v]) visit(v);
}

void sub1() {
    For(i, 1, m) {
        int u = x[i], v = y[i];
        a[u][v] = a[v][u] = 1;
    }
    For(i, 1, n) For(j, i+1, n) if (!a[i][j]) {
        a[i][j] = a[j][i] = 1;
        For(k, 1, m) {
            int u = x[k], v = y[k];
            a[u][v] = a[v][u] = 0;
            cnt = 0; reset(was, true);
            For(t, 1, n) if (was[t]) {
                cnt++;
                visit(t);
            }
            if (cnt == 1) res++;
            a[u][v] = a[v][u] = 1;
        }
        a[i][j] = a[j][i] = 0;
    }
    cout << res;
}

void dfs(int u) {
    fr[u] = false;
    con[u] = 1;
    dem[cnt]++;
    num[u] = ++timer; low[u] = num[u];
    For(j, 0, sz(ke[u])-1) {
        int v = ke[u][j];
        if (fr[v]) {
            cha[v] = u;
            dfs(v);
            con[u] += con[v];
            low[u] = min(low[u], low[v]);
        } else if (cha[u] != v && cha[v] != u) low[u] = min(low[u], num[v]);
    }
}

bool cau(int u, int v) {
    if (v == cha[u]) swap(u, v);
    if (u != cha[v]) return false;
    if (low[v] >= num[v]) return true;
    return false;
}

void sub3() {
    ll sl1 = dem[1], sl2 = dem[2];
    For(i, 1, m) {
        int u = x[i], v = y[i];
        if (!cau(u, v)) res += sl1 * sl2;
    }
}

void sub4() {
    ll sc = (ll(n) * (n-1)) / 2;
    ll sl1, sl2;
    For(i, 1, m) {
        int u = x[i], v = y[i];
        if (v == cha[u]) swap(u, v);
        bool flag = cau(u, v);
        if (flag) {
            sl1 = con[v], sl2 = n - con[v];
            res += sl1 * sl2 - 1;
        } else res += sc - m;
    }
}

void sub2() {
    reset(fr, true);
    For(u, 1, n) if (fr[u]) {
        cnt++;
        cha[u] = u;
        dfs(u);
    }
    if (cnt > 2) {
        cout << 0; return;
    }
    if (cnt == 2) sub3();
    else sub4();
    cout << res;
}

int main() {
    freopen("REFORM.INP", "r", stdin);
    freopen("REFORM.OUT", "w", stdout);
    scanf("%d%d", &n, &m);
    For(i, 1, m) {
        int u, v;
        scanf("%d%d", &u, &v);
        x[i] = u; y[i] = v;
        ke[u].pb(v); ke[v].pb(u);
    }
    if (n <= 20) sub1();
    else
    sub2();
}
