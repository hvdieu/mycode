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
#define N 100010

struct edge {
    int u, v, id;
    edge(int _u, int _v, int _id) {
        u = _u; v = _v; id = _id;
    }
};

ii a[N];

struct Compare {
    bool operator () (const edge &A, const edge &B) {
        if (a[A.u].x != a[B.u].x) return a[A.u].x < a[B.u].x;
        if (a[A.v].x != a[B.v].x) return a[A.v].x < a[B.v].x;
        return a[A.u].y > a[B.u].y;
    }
};

bool be(ii a, ii b) {
    if (a.x < b.x || (a.x == b.x && a.y < b.y)) return true;
    return false;
}

int n, m;
vector<ii> ke[N];
set<edge, Compare> ff;
int xx[2*N], yy[2*N];
vector<int> was, res;
int origin;
int dd[2*N];

int dis(ii a, ii b) {
	return abs(a.x - b.x) + abs(a.y - b.y);
}

int ccw(ii o, ii a, ii b) {
	int temp2 = dis(o, a) + dis(a, b) - dis(o, b);
    a.x -= o.x; a.y -= o.y;
    b.x -= o.x; b.y -= o.y;
    ll tmp = ll(a.x)*b.y - ll(a.y)*b.x;
    if (tmp != 0) {
    	if (tmp > 0) return 1;
    	return 3;
	}
	if (temp2 == 0) return 2;
	return 4;
}

bool avai(int i) {
    auto it = ff.find(edge(xx[i], yy[i], i));
    if (it == ff.end()) return false;
    return dd[i] < 2;
}

void dfs(int u, int v) {
    if (v == origin) return;
    For(i, 0, sz(ke[v])-1)
    For(j, i+1, sz(ke[v])-1) if (ccw(a[u], a[v], a[ke[v][i].x]) > ccw(a[u], a[v], a[ke[v][j].x]))
    swap(ke[v][i], ke[v][j]);
    For(i, 0, sz(ke[v])-1)
//	cout << ke[v][i].x << ' ' << ccw(a[u], a[v], a[ke[v][i].x]) << endl;
//	cout << endl;
 //   int luu;
    REP(i, sz(ke[v])) if (avai(ke[v][i].y)) {
        was.pb(ke[v][i].y);
        dd[ke[v][i].y]++;
        int next = ke[v][i].x;
        dfs(v, next);
        return;
    }
}

void del(int i) {
    int u = xx[i], v = yy[i];
    auto it = ff.find(edge(u, v, i));
    if (it != ff.end()) ff.erase(it);
}

void solve() {
   // For(i, 0, sz(ke[15])-1) cout << ccw(a[2], a[15], a[ke[15][i].x]) << ' '; cout << endl;
    while (!ff.empty()) {
        int u = ff.begin()->u, v = ff.begin()->v;
        was.clear();
		was.pb(ff.begin()->id);
		dd[ff.begin()->id]++;
        origin = u;
        dfs(u, v);
        sort(all(was));
      //  FOR(i, was) cout << *i << ' '; cout << endl;
        del(was[0]);
        For(i, 1, sz(was)-1) {
            if (was[i] == was[i-1]) res.pb(was[i]);
            del(was[i]);
        }
    }
}

void inkq() {
    printf("%d\n", sz(res));
    FOR(i, res) printf("%d\n", *i);
}

int main() {
   // freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d%d", &a[i].x, &a[i].y);
    scanf("%d", &m);
    For(i, 1, m) {
        int u, v;
        scanf("%d%d", &u, &v);
        if (!be(a[u], a[v])) swap(u, v);
        xx[i] = u; yy[i] = v;
        ke[u].pb(ii(v, i)); ke[v].pb(ii(u, i));
        ff.insert(edge(u, v, i));
    }
  //  cout << ccw(a[14], a[15], a[14]);
    solve();
    inkq();
}
