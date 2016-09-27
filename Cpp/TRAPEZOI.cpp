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
#define N 200001
#define BASE 30013

struct rec {
    int x1, x2, y1, y2;
};

int n, m, t[N], nn, f[N], res, mm, d1, d2, l[N], r[N], g[N], vt[N];
bool dd[N];
ii b[N], c[N];
rec a[N];
vector<int> open[N], cls[N];

void init() {
    sort(b+1, b+m+1);
    sort(c+1, c+m+1);
    d1 = 0, d2 = 0;
    For(i, 1, m) {
        if (b[i].fi != b[i-1].fi) d1++;
        if (c[i].fi != c[i-1].fi) d2++;
        int j = b[i].se; if (j > n) a[j-n].x2 = d1; else a[j].x1 = d1;
            j = c[i].se; if (j > n) a[j-n].y2 = d2; else a[j].y1 = d2;
    }
    d1++; d2++;
    a[n+1].x1 = d1; a[n+1].x2 = d1;
    a[n+1].y1 = d2; a[n+1].y2 = d2;
}

void update(int i, int val, int tt) {
    while (i <= d2) {
        if (!tt) t[i] = max(t[i], val);
        else t[i] = (t[i] + val + BASE) % BASE;
        i += i & (-i);
    }
}

int get(int i, int tt) {
    int s = 0;
    while (i) {
        if (!tt) s = max(s, t[i]);
        else s = (s + t[i]) % BASE;
        i -= i & (-i);
    }
    return s;
}

bool cmp(int i, int j) {
    return f[i] < f[j];
}

bool cmp2(int i, int j) {
    return a[i].x1 < a[j].x1;
}

bool cmp3(int i, int j) {
    return a[i].x2 < a[j].x2;
}

void solve() {
    init();
    n++;
    For(i, 1, n) {
        open[a[i].x1].pb(i);
        cls[a[i].x2].pb(i);
    }
    For(x, 1, d1) {
        For(j, 0, sz(open[x])-1) {
            int i = open[x][j];
            f[i] = get(a[i].y1-1, 0) + 1;
            res = max(res, f[i]);
        }

        For(j, 0, sz(cls[x])-1) {
            int i = cls[x][j];
            update(a[i].y2, f[i], 0);
        }
    }

    cout << f[n] - 1 << ' ';
    reset(t, 0);
    For(i, 1, n) vt[i] = i;
    sort(vt+1, vt+1+n, cmp);
    l[1] = 1; int j = 1; r[1] = 1;
    For(i, 2, n) {
        if (f[vt[i-1]] == f[vt[i]]) r[j] = i;
        else {
            j++; l[j] = i; r[j] = i;
        }
    }
    For(i, l[1], r[1]) g[vt[i]] = 1;
    For(len, 2, f[n]) {
        if (len - 2)
            For(i, l[len-2], r[len-2]) if (dd[i]) update(a[vt[i]].y2, -g[vt[i]], 1);
        sort(vt+l[len-1], vt+r[len-1]+1, cmp3);
        sort(vt+l[len], vt+r[len]+1, cmp2);
        j = l[len-1]-1;
        For(i, l[len], r[len]) {
            while (j < r[len-1] && a[vt[j+1]].x2 < a[vt[i]].x1) {
                j++; update(a[vt[j]].y2, g[vt[j]], 1); dd[j] = true;
            }

            g[vt[i]] = get(a[vt[i]].y1-1, 1);
            //if (!g[vt[i]]) cout << f[vt[i]] << endl;
        }
    }
    cout << g[n];
}

int main() {
    freopen("11-trapezoid.in","r",stdin);
   // freopen("TRAPEZOI.OUT","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) {
        int x1, x2, y1, y2;
        scanf("%d %d %d %d", &x1, &x2, &y1, &y2);
        b[++m] = ii(x1, i); c[m] = ii(y1, i);
        b[++m] = ii(x2, i+n); c[m] = ii(y2, i+n);
    }
    solve();
}


