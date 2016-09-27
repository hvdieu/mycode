#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define x first
#define y second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define pi acos(-1)
#define N 100010
#define inf 1000000000000000000LL

ii a[N], origin;
int n, m;
ll a1, b1, c1;
vector<ii> t[8*N];

void operator -= (ii &a, ii b) {
    a.x -= b.x; a.y -= b.y;
}

double goc(ii A) {
    int x = A.x, y = A.y;
    if (!x) {
        if (!y) return 0;
        if (y > 0) return pi/2;
        else return ((3.0/2)*pi);
    } else if (!y) {
        if (x > 0) return 0;
        return pi;
    }
    double o = abs(atan(double(y)/x));
    if (x > 0) {
        if (y > 0) return o;
        return 2.0*pi - o;
    } else {
        if (y > 0) return pi-o;
        return pi+o;
    }
}

bool cmp(ii a, ii b) {
    a -= origin; b -= origin;
    return goc(a) < goc(b);
}

bool ccw(ii o, ii a, ii b) {
    a -= o; b -= o;
    return ll(a.x)*b.y >= ll(a.y)*b.x;
}

bool cmp2(ii a, ii b) {
    return ccw(origin, a, b);
}

void Merge(int i, int c1, int c2) {
    For(j, 0, sz(t[c1])-1) t[i].pb(t[c1][j]);
    For(j, 0, sz(t[c2])-1) t[i].pb(t[c2][j]);
    sort(all(t[i]));
    origin = t[i][0];
    sort(t[i].begin()+1, t[i].end(), cmp); t[i].pb(origin);
    int n = sz(t[i])-1;
    int j = 0;
    For(ii, 1, n) {
        while (j > 1 && !ccw(t[i][j-1], t[i][j], t[i][ii])) j--;
        t[i][++j] = t[i][ii];
    }
    n = j-1;
	t[i].erase(t[i].begin()+n+1, t[i].end());
}

void init(int i, int lo, int hi) {
    if (lo == hi) {
        t[i].pb(a[lo]); return;
    }
    int mid = (lo + hi) / 2;
    init(i*2, lo, mid);
    init(i*2+1, mid+1, hi);
    Merge(i, i*2, i*2+1);
}

void build(ii A, ii B) {
    a1 = A.y - B.y;
    b1 = B.x - A.x;
    c1 = ll(A.x)*B.y - ll(A.y)*B.x;
    if (c1 < 0) {
        a1 *= -1; b1 *= -1; c1 *= -1;
    }
}

int Find(ii A, int t) {
    int d = 1, c = n, mid, ans;
    if (!t) ans = n+1; else ans = 0;
    while (d <= c) {
        int mid = (d+c) / 2;
        if (!t) {
            if (goc(A) <= goc(a[mid])) {
                ans = mid; c = mid-1;
            } else d = mid+1;
        } else {
            if (goc(A) >= goc(a[mid])) {
                ans = mid; d = mid+1;
            } else c = mid-1;
        }
    }
    return ans;
}

ll Query(int i, int lo, int hi, int u, int v) {
    ll res = -inf;
    if (lo == u && hi == v) {
        For(j, 0, sz(t[i])-1) res = max(res, a1*t[i][j].x + b1*t[i][j].y);
        return res;
    }
    int mid = (lo + hi) / 2;
    if (u <= mid) res = max(res, Query(i*2, lo, mid, u, min(mid, v)));
    if (v > mid) res = max(res, Query(i*2+1, mid+1, hi, max(mid+1, u), v));
    return res;
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("tri_.inp","r",stdin);
    freopen("tri.out","w",stdout);
    scanf("%d%d", &n, &m);
    For(i, 1, n) scanf("%d%d", &a[i].x, &a[i].y);
    origin = ii(0, 0);
    sort(a+1, a+n+1, cmp);
    init(1, 1, n);
   // For(i, 1, 4*n) cout << sz(t[i]) << ' ';
    For(test, 1, m) {
    	//if (test == 358) {
    	//	bool flag = true;
		//}
        ii A, B;
        scanf("%d%d%d%d", &A.x, &A.y, &B.x, &B.y);
        build(A, B);
        if (goc(A) > goc(B)) swap(A, B);
        int u = Find(A, 0), v = Find(B, 1);
        if (u && v && u <= n && v <= n) {
            ll temp = Query(1, 1, n, u, v);
            temp += c1; //printf("%lld %d %d ", temp, u, v);
            if (temp > 0) printf("Y\n"); else printf("N\n");
        } else printf("N\n");
    }
}
