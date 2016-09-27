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
ll a1, b1, c1, res;
vector<ii> t[4*N];
int giua[4*N];
bool flag = false;

inline void operator -= (ii &a, ii b) {
    a.x -= b.x; a.y -= b.y;
}

inline double goc(ii A) {
	return atan(double(A.y)/A.x);
}

inline bool cmp(ii a, ii b) {
    //a -= origin; b -= origin;
    return goc(a) < goc(b);
}

inline int ccw(ii o, ii a, ii b) {
    a -= o; b -= o;
    ll temp = ll(a.x)*b.y - ll(a.y)*b.x;
    if (temp > 0) return 1;
    if (temp == 0) return 0; return -1;
}

inline bool cmp2(ii a, ii b) {
	int x = ccw(origin, a, b);
	if (x != 0) return x > 0;
	ll len1 = ll(a.x)*a.x + ll(a.y)*a.y;
	ll len2 = ll(b.x)*b.x + ll(b.y)*b.y;
	return len1 < len2;
}

inline void Merge(int i, int c1, int c2) {
    For(j, 0, sz(t[c1])-1) t[i].pb(t[c1][j]);
    For(j, 0, sz(t[c2])-1) t[i].pb(t[c2][j]);
    if (t[c1][0].x < t[c2][0].x) origin = t[c1][0]; else {
        origin = t[c2][0];
        swap(t[i][0], t[i][sz(t[c1])]);
    }
    sort(t[i].begin()+1, t[i].end(), cmp2); t[i].pb(t[i][0]);
    int n = sz(t[i])-1;
    int j = 0;
    For(ii, 1, n) {
        while (j > 1 && ccw(t[i][j-1], t[i][j], t[i][ii]) < 0) j--;
        t[i][++j] = t[i][ii];
    }
    n = j-1;
	t[i].erase(t[i].begin()+n+1, t[i].end());
	n = sz(t[i])-1; giua[i] = 0;
	For(j, 0, n-1) if (t[i][j].x > t[i][j+1].x) {
		giua[i] = j; break;
	}
}

void init(int i, int lo, int hi) {
    if (lo == hi) {
        t[i].pb(a[lo]);
        return;
    }
    int mid = (lo + hi) / 2;
    init(i*2, lo, mid);
    init(i*2+1, mid+1, hi);
    Merge(i, i*2, i*2+1);
}

inline void build(ii A, ii B) {
    a1 = A.y - B.y;
    b1 = B.x - A.x;
    c1 = ll(A.x)*B.y - ll(A.y)*B.x;
    if (c1 < 0) {
        a1 *= -1; b1 *= -1; c1 *= -1;
    }
}

inline int Find(ii A, int t) {
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

inline ll thay(ii A) {
    return a1*A.x + b1*A.y;
}

void Search(int i, int d, int c) {
    ll c1, c2, c3; int mid;
    while (d <= c) {
        mid = (d+c) / 2;
        c2 = thay(t[i][mid]);
        if (mid) c1 = thay(t[i][mid-1]); else c1 = -inf;
        if (mid < sz(t[i])-1) c3 = thay(t[i][mid+1]); else c3 = -inf;
        if (c1 <= c2 && c2 >= c3) {
            res = max(res, c2); return;
        }
        if (c3 > c2) d = mid+1;
        else c = mid-1;
    }
}

void Query(int i, int lo, int hi, int u, int v) {
    if (lo == u && hi == v) {
        Search(i, 0, giua[i]);
        Search(i, giua[i]+1, sz(t[i])-1);
        return;
    }
    int mid = (lo + hi) / 2;
    if (u <= mid) Query(i*2, lo, mid, u, min(mid, v));
    if (v > mid) Query(i*2+1, mid+1, hi, max(mid+1, u), v);
}

int main() {
    freopen("tri_.inp","r",stdin);
    freopen("tri.out","w",stdout);
    scanf("%d%d", &n, &m);
    For(i, 1, n) scanf("%d%d", &a[i].x, &a[i].y);
    origin = ii(0, 0);
    sort(a+1, a+n+1, cmp);
    init(1, 1, n);
    For(test, 1, m) {
        ii A, B;
        scanf("%d%d%d%d", &A.x, &A.y, &B.x, &B.y);
        build(A, B);
        if (goc(A) > goc(B)) swap(A, B);
        int u = Find(A, 0), v = Find(B, 1);
        if (u && v && u <= n && v <= n) {
            res = -inf;
            Query(1, 1, n, u, v);
            if (res+c1 > 0) printf("Y\n"); else printf("N\n");
        } else printf("N\n");
    }
}
