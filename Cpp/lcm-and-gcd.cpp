#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;
typedef vector<ii> VI;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 51
#define BASE 10000000

int n, ntest, a[N], res;
map<VI, int> f[N][251];
map<VI, int> dd;
map<VI, int>::iterator it;
vector<ii> b[N];
vector<VI> l;

int gcd(int a, int b) {
    if (!b) return a;
    return gcd(b, a%b);
}

VI lcm(VI a, VI b) {
    For(j, 0, sz(b)-1) a.pb(b[j]);
    VI tmp; tmp.clear();
    sort(all(a));
    int i = 0;
    while (i <= sz(a)-1) {
        int j = i; int ma = a[i].se;
        while (j < sz(a)-1 && a[i].fi == a[j+1].fi) { j++; ma = max(ma, a[j].se); }
        tmp.pb(ii(a[i].fi, ma));
        i = j+1;
    }
    return tmp;
}

void tach(int x, int i) {
    b[i].clear();
    int y = x;
    For(j, 2, y) if (x % j == 0) {
        b[i].pb(ii(j, 0));
        while (x % j == 0) {
            b[i][sz(b[i])-1].se++;
            x /= j;
        }
    }
}

int cal(VI a) {
    int res = 1;
    For(i, 0, sz(a)-1) {
        int x = 1; For(j, 1, a[i].se) x = (ll(x) * a[i].fi) % BASE;
        res = (ll(res) * x) % BASE;
    }
    return res;
}

void add(int &a, int b) {
    a += b; if (a >= BASE) a -= b;
}

void solve() {
    For(i, 1, n) tach(a[i], i);
    dd.erase(all(dd)); l.clear();
    For(i, 0, n) For(gc, 0, 250) f[i][gc].erase(all(f[i][gc]));
    VI tmp; tmp.clear();
    res = 0;
    f[0][0][tmp] = 1; l.pb(tmp);
    For(i, 0, n-1) For(gc, 0, 250) {
        For(j, 0, sz(l)-1) {
            VI lc = l[j];
            int x = f[i][gc][lc];
            VI newlc = lcm(lc, b[i+1]);
            int newgc = gcd(a[i+1], gc);
            add(f[i+1][newgc][newlc], x);
            add(f[i+1][gc][lc], f[i][gc][lc]);
            if (!dd[newlc]) {
                dd[newlc] = 1; l.pb(newlc);
            }
        }
	}
    For(gc, 1, 250) For(j, 1, sz(l)-1) {
        int lc = cal(l[j]);
        lc = (ll(lc) * gc) % BASE;
        int x = f[n][gc][l[j]];
        lc = (ll(lc) * x) % BASE;
        add(res, lc);
    }
    cout << res << endl;
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("input.txt","r",stdin);
   // freopen("output.txt","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d", &n);
        For(i, 1, n) scanf("%d", a+i);
        solve();
    }
}
