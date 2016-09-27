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
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 100010

struct line { ll a, b; double x, y; };

int n, s[N], v[N], cha[N], d[N];
vector<int> ke[N], w[N];
ll f[N];
line st[N];
int top, dd[N];
vector<line> q[N];

ll cal(ll x) {
    int d = 0, c = top, mid, ans;
    while (d <= c) {
        mid = (d + c) / 2;
        if (x >= st[mid].x) {
            ans = mid; d = mid + 1;
        } else c = mid - 1;
    }
    return st[ans].a * x + st[ans].b;
}

void dfs(int u) {
    if (u == 4) {
        bool flag = true;
    }
    if (u != 1) {
        if (dd[u]) {
            printf("%d\n", u);
            For(i, 1, top) printf("%lld %lld %.2lf\n", st[i].a, st[i].b, st[i].x);
            printf("\n");
        }
        ll temp = cal(v[u]);
        f[u] = ll(d[u])*v[u] + s[u] + min(temp, 0LL);
        ll a1 = -d[u], b1 = f[u];
        while (top) {
            ll a2 = st[top-1].a, b2 = st[top-1].b;
            double xx = (double(b2)-b1) / (a1-a2);
            double yy = xx*a1 + b1;
            if (xx <= st[top].x) {
                q[u].pb(st[top]); top--;
            } else break;
        }

        ll a2 = st[top].a, b2 = st[top].b;
        double xx = (double(b2)-b1) / (a1-a2);
        double yy = xx*a1 + b1;
        st[++top].x = xx; st[top].y = yy;
        st[top].a = a1; st[top].b = b1;
    }

    For(j, 0, sz(ke[u])-1) {
        int v = ke[u][j];
        if (!cha[v]) {
            cha[v] = u;
            d[v] = d[u] + w[u][j];
            dfs(v);
        }
    }
    if (u != 1) {
        top--;
        Rep(i, sz(q[u])-1, 0) st[++top] = q[u][i];
    }
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("input.txt","r",stdin);
    freopen("output.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n-1) {
        int u, v, l;
        scanf("%d%d%d", &u, &v, &l);
        ke[u].pb(v); ke[v].pb(u);
        w[u].pb(l); w[v].pb(l);
    }
    For(i, 2, n) scanf("%d%d", s+i, v+i);
    top = 0; st[0].a = 0; st[0].b = 0; st[0].x = 0;st[0].y = 0;
    cha[1] = 1;
    dd[1] = dd[4] = dd[10] = dd[74] = dd[65] = dd[13] = dd[6] = dd[72] = dd[8] = dd[66] = 1;
    dfs(1);
    //For(i, 2, n) printf("%lld\n", f[i]);
}

