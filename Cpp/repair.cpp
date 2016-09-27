#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define REP(i, n) for(int i = 0; i < n; i++)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define x first
#define y second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 150010

struct point {
    int x, y, color;
    point(int _x, int _y, int _color) {
        x = _x; y = _y; color = _color;
    }
};

struct query {
    int x1, y1, x2, y2;
    query(int _x1, int _y1, int _x2, int _y2) {
        x1 = _x1; y1 = _y1; x2 = _x2; y2 = _y2;
    }
};

int m, n, p, q;
int t[N];
vector<point> a;
vector<ii> b;
vector<query> Q;
map<ii, int> f;

void solve() {
    sort(all(b));
    b.erase(unique(all(b)), b.end());
    REP(i, sz(b)) a.pb(point(b[i].x, b[i].y, 0));
    b.clear();
    REP(i, q) {
        int x1, y1, x2, y2;
        scanf("%d%d%d%d", &x1, &y1, &x2, &y2);
        b.pb(ii(x1-1, y1-1)); b.pb(ii(x2, y2));
        b.pb(ii(x2, y1-1)); b.pb(ii(x1-1, y2));
        Q.pb(query(x1, y1, x2, y2));
    }
    sort(all(b));
    b.erase(unique(all(b)), b.end());
    REP(i, sz(b)) a.pb(point(b[i].x, b[i].y, 4));

}

int main() {
    freopen("repair.inp","r",stdin);
    freopen("repair.out","w",stdout);
    scanf("%d%d", &n, &m);
    scanf("%d%d\n", &p, &q);
    REP(i, p) {
        char kind; int x, y;
        scanf("%c %d %d\n", &kind, &x, &y);
        b.pb(ii(x, y));
        if (kind == 'h') b.pb(ii(x+1, y)), a.pb(point(x, y, 1));
        else b.pb(ii(x, y+1)), a.pb(point(x, y, 2));
    }
    solve();
}
