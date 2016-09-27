#include <bits/stdc++.h>

using namespace std;

typedef long long ll;
typedef long double ld;
typedef pair<int, int> ii;

#define For(i, a, b) for(int i = a; i <= b; i++)
#define Rep(i, a, b) for(int i = a; i >= b; i--)
#define all(x) x.begin(), x.end()
#define sz(x) int(x.size())
#define pb push_back
#define reset(f, x) memset(f, x, sizeof(f))
#define fi first
#define se second
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1LL << i))
#define N 1010

int n, k, a[N], res, dd[N], lef[N], righ[N], st[N], top, b[N], root, dem;
int kk;
bool flag = true;
bool fr[N];

void dfs(int i) {
    fr[i] = false;
    if (lef[i] && fr[lef[i]]) dfs(lef[i]);
    if (righ[i] && fr[righ[i]]) dfs(righ[i]);
    b[++dem] = a[i];
}

void xay(int root, int l, int r) {
    if (l >= r) return;
    int u = 0, v = 0;
    For(j, l, root-1) if (a[j] > a[u]) u = j;
    For(j, root+1, r) if (a[j] > a[v]) v = j;
    lef[root] = u; righ[root] = v;
    xay(u, l, root-1);
    xay(v, root+1, r);
}

void sub1() {
    For(i, 1, n) if (a[i] == n) root = i;
    xay(root, 1, n);
}

void sub2() {
    top = 0; st[0] = 0;
    For(i, 1, n) {
        if (a[i] == n) root = i;
        while (top && a[i] > a[st[top]]) top--;
        righ[st[top]] = i;
        st[++top] = i;
    }
    top = 0; st[0] = 0;
    Rep(i, n, 1) {
        while (top && a[i] > a[st[top]]) top--;
        lef[st[top]] = i;
        st[++top] = i;
    }
}

void Play() {
    //For(i, 1, n) cout << a[i] << ' '; cout << endl;
    reset(lef, 0);
    reset(righ, 0);
    if (n*kk <= 10000)
    sub1();
    else
    sub2();
    reset(fr, true);
    dem = 0;
    dfs(root);
    bool ok = true;
    For(i, 1, n) if (b[i] != i) {
        ok = false; break;
    }
    if (ok) {
        res++;
        //For(i, 1, n) cout << a[i] << ' '; cout << endl;
    }
    k--;
    if (!k) cout << res;
}

void ql(int i) {
    if (!k) return;
    if (i > n) {
        Play();
        flag = false;
        return;
    }
    For(j, 1, n) if (dd[j] || (flag && j == a[i])) {
        a[i] = j;
        dd[j] = false;
        ql(i+1);
        dd[j] = true;
    }
}

void solve() {
    if (n*k > 1000000000) {
        cout << 0; return;
    }
    reset(dd, false);
    ql(1);
    if (k) cout << res;
}

int main() {
    freopen("TSORT.INP", "r", stdin);
   // freopen("TSORT.OUT", "w", stdout);
    scanf("%d%d", &n, &k);
    kk = k;
    For(i, 1, n) scanf("%d", &a[i]);
    solve();
}
