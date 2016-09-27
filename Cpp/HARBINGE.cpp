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

int n, s[N], v[N], cha[N];
ll d[N];
vector<int> ke[N], w[N];
ll f[N];
line st[N];
int top;
vector<line> q[N];

ll cal(ll x) {
    int d = 1, c = top, mid, ans=0;
    while (d <= c) {
        mid = (d + c) / 2;
        if (x >= st[mid].x) {
            ans = mid; d = mid + 1;
        } else c = mid - 1;
    }
    return st[ans].a * x + st[ans].b;
}

void dfs(int u) {
    line luu; int l = top, ans = top+1;
    if (u != 1) {
        ll temp = cal(v[u]);
        f[u] = ll(d[u])*v[u] + ll(s[u]) + min(temp, 0LL);
        ll a1 = -d[u], b1 = f[u];
        int lef = 1, righ = top, mid;
        while (lef <= righ) {
            mid = (lef + righ) / 2;
            ll a2 = st[mid-1].a, b2 = st[mid-1].b;
             double xx = (double(b2)-b1) / (a1-a2);
            if (xx <= st[mid].x) {
                ans = mid; righ = mid - 1;
            } else lef = mid + 1;
        }
        top = ans;
        luu = st[ans];

        ll a2 = st[top-1].a, b2 = st[top-1].b;
        double xx = (double(b2)-b1) / (a1-a2);
        double yy = xx*a1 + b1;
        st[top].x = xx; st[top].y = yy;
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
        top = l; st[ans] = luu;
    }
}

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("harbinge.inp","r",stdin);
    //freopen("harbinge.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n-1) {
        int u, v, l;
        scanf("%d%d%d", &u, &v, &l);
        ke[u].pb(v); ke[v].pb(u);
        w[u].pb(l); w[v].pb(l);
    }
    For(i, 2, n) scanf("%d%d", s+i, v+i);
    top = 0; st[top].a = 0; st[top].b = 0; st[top].x = 0;st[top].y = 0;
    cha[1] = 1;
    dfs(1);
    For(i, 2, n) printf("%lld ", f[i]);
}
