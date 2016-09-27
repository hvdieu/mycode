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
#define N 21
#define inf 1000000000

int n, a[N], b[N], m;
int resa, resb;
int x[N];
vector<ii> f;
ii st[two(20)+1];
int top;

bool cmp(ii a, ii b) {
    if (a.fi != b.fi) return a.fi < b.fi;
    return a.se < b.se;
}

void solve() {
    int T = two(n)-1;
    For(tt, 0, T) {
        int sa =0, sb = 0;
        For(i, 1, n) if (bit(tt, i-1)) sa += a[i];
        else sb += b[i];
        f.pb(ii(sa, sb));
    }
    sort(all(f), cmp);
    int m = sz(f) - 1;
    top = 0;
    For(i, 0, m) {
        while (top && st[top].se <= f[i].se) top--;
        st[++top] = f[i];
    }
    resa = st[1].fi + 1; resb = st[1].se + 1;
    For(i, 1, top-1) if (st[i].fi + st[i+1].se < resa + resb) {
        resa = st[i].fi; resb = st[i+1].se;
    }
    cout << resa+1 << endl;
    cout << resb+1 << endl;
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("glove.inp", "r", stdin);
    freopen("glove.out", "w", stdout);
    cin >> n;
    For(i, 1, n) cin >> a[i];
    For(i, 1, n) cin >> b[i];
    resa = resb = inf;
    solve();
}
