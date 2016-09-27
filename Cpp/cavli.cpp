#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;
typedef list<ii>::iterator ite;

#define all(x) x.begin(), x.end()
#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define FOR(i, a, b) for(auto i=a; i != b; i++)
#define x first
#define y second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 300010
#define inf 1000000010

int n, xmin, xmax, ymin, ymax;
ii a[N];
set<ii> fx, fy;
set<ii>::iterator it;
char s[N];
list<ii> ff;
ite ex[5];
ll area, area2;
vector<ll> kq;

int ccw(ii O, ii A, ii B) {
    A.x -= O.x; A.y -= O.y;
    B.x -= O.x; B.y -= O.y;
    ll x = ll(A.x)*B.y - ll(A.y)*B.x;
    if (!x) return 0; if (x > 0) return 1; return -1;
}

ite next(ite it) {
    ++it; if (it == ff.end()) return ff.begin();
    return it;
}

ite prev(ite it) {
    if (it == ff.begin()) return --ff.end();
    return --it;
}

void update(ite it) {
    if (it->x < xmin) { xmin = it->x; ex[1] = it; }
    if (it->x > xmax) { xmax = it->x; ex[2] = it; }
    if (it->y < ymin) { ymin = it->y; ex[3] = it; }
    if (it->y > ymax) { ymax = it->y; ex[4] = it; }
}

ll cal(ii A, ii B) {
    return (ll(A.x) - B.x) * (A.y + B.y);
}

void init() {
    scanf("%s", s+1);
    For(i, 1, n-2) {
        bool ok;
        if (s[i] == 'L') it = fx.begin(), ok = true;
        else if (s[i] == 'R') it = --fx.end(), ok = true;
        else if (s[i] == 'D') it = fy.begin(), ok = false;
        else it = --fy.end(), ok = false;
        ii o = *it;
        if (ok == false) swap(o.x, o.y); a[i] = o;
        fx.erase(fx.find(o)); fy.erase(fy.find(ii(o.y, o.x)));
    }
    a[n-1] = *fx.begin(); fx.erase(fx.begin());
    a[n] = *fx.begin();
    if (ccw(a[n-2], a[n-1], a[n]) != 1) swap(a[n-1], a[n-2]);
    area = cal(a[n-2], a[n-1]) + cal(a[n-1], a[n]) + cal(a[n], a[n-2]);
    ff.pb(a[n-2]); ff.pb(a[n-1]); ff.pb(a[n]);
    xmin = ymin = inf; xmax = ymax = -inf;
    for(ite it = ff.begin(); it != ff.end(); it++) update(it);
}

void add(ii O) {
    int x = O.x, y = O.y;
    ite firs, las;
    int goc;

    if (x < xmin) if (y > ymax) goc = 1; else if (y < ymin) goc = 7; else goc = 8;
    if (y > ymax) if (x < xmin) goc = 1; else if (x > xmax) goc = 3; else goc = 2;
    if (x > xmax) if (y > ymax) goc = 3; else if (y < ymin) goc = 5; else goc = 4;
    if (y < ymin) if (x < xmin) goc = 7; else if (x > xmax) goc = 5; else goc = 6;
         if (goc == 1) firs = ex[4], las = ex[1];
    else if (goc == 2) firs = ex[4], las = ex[4];
    else if (goc == 3) firs = ex[2], las = ex[4];
    else if (goc == 4) firs = ex[2], las = ex[2];
    else if (goc == 5) firs = ex[3], las = ex[2];
    else if (goc == 6) firs = ex[3], las = ex[3];
    else if (goc == 7) firs = ex[1], las = ex[3];
    else               firs = ex[1], las = ex[1];
    while (ccw(*prev(firs), *firs, O) != 1) firs = prev(firs);
    while (ccw(*next(las), *las, O) != -1) las = next(las);
    if (next(firs) != las && firs != las) {
    	area -= cal(*las, *firs);
        for(auto it = firs; it != las; it = next(it)) area -= cal(*it, *next(it));
        while (1) {
            auto it = next(firs);
            if (it != las) ff.erase(it); else break;
        }
    }
    area += cal(*firs, O) + cal(O, *las) + cal(*las, *firs);
    ff.insert(las, O);
    area2 = 0;
	//for(ite it = ff.begin(); it != ff.end(); it++) {
		//printf("%d %d -> ", it->x, it->y);
	//	area2 += cal(*it, *next(it));
	//	printf("%d ", ccw(*it, *next(it), *next(next(it))));
	//}
    las--; update(las);
    //cout << endl;
}

void inkq(ll x) {
    printf("%lld", x/2);
    if (x % 2) printf(".5\n"); else printf(".0\n");
}

void solve() {
    kq.pb(area);
    Rep(i, n-3, 1) {
        add(a[i]);
        kq.pb(area);
    }
    reverse(all(kq));
    FOR(it, kq.begin(), kq.end()) inkq(*it);
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("cavli.in.10","r",stdin);
    freopen("cavli.out","w",stdout);
    scanf("%d\n", &n);
    For(i, 1, n) {
        int x, y; scanf("%d%d\n", &x, &y);
        fx.insert(ii(x, y)); fy.insert(ii(y, x));
    }
    init();
    solve();
}
