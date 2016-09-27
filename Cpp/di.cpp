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
#define N 210
#define M 1010
#define NN 1000010
#define eps 1e-7

struct triple {
    int x, y, z;
};

triple make_triple(int a, int b, int c) {
    triple d;
    d.x = a; d.y = b; d.z = c;
    return d;
}

struct node {
    double val;
    int x, y, z;
    node(double a, int b, int c, int d) {
        val = a; x = b; y = c; z = d;
    }
};

bool operator > (node a, node b) {
    return a.val > b.val;
}

double xmin, xmax, ymin, ymax, zmin, zmax;

int avai[N][N][N], n, na, nb, nc;
double d[N][N][N];
triple trace[N][N][N];
vector<triple> path[M][M];

double cp[M][M];
priority_queue< node, vector<node>, greater<node> > heap;

double a, b, c, t, aa, bb, cc;
double xx1[NN], yy1[NN], zz1[NN], xx2[NN], yy2[NN], zz2[NN];
vector<triple> l;
double f[21][1048578];
int trace2[21][1048578];
vector<triple> path2;

void truyvet(int i, int j) {
    int x = l[j].x, y = l[j].y, z = l[j].z;
    while (x != l[i].x || y != l[i].y || z != l[i].z) {
        path[i][j].pb(make_triple(x, y, z));
        int xx = trace[x][y][z].x, yy = trace[x][y][z].y, zz = trace[x][y][z].z;
        x = xx; y = yy; z = zz;
    }
    reverse(all(path[i][j]));
}

void Dij(int i) {
    reset(d, 0x7f);
    d[l[i].x][l[i].y][l[i].z] = 0;
    while (!heap.empty()) heap.pop();
    heap.push(node(0, l[i].x, l[i].y, l[i].z));
    while (!heap.empty()) {
        double gt = heap.top().val;
        int x = heap.top().x, y = heap.top().y, z = heap.top().z;
        heap.pop();
        if (gt == d[x][y][z]) {
            For(k1, -1, 1) For(k2, -1, 1) For(k3, -1, 1) {
                int x1 = x + k1, y1 = y + k2, z1 = z + k3;
                double cost = aa * abs(k1) + bb * abs(k2) + cc * abs(k3);
                if (x1 && y1 && z1 && x1 <= na && y1 <= nb && z1 <= nc && avai[x1][y1][z1] >= 0 && d[x1][y1][z1] > d[x][y][z] + cost) {
                    d[x1][y1][z1] = d[x][y][z] + cost;
                    trace[x1][y1][z1].x = x;
                    trace[x1][y1][z1].y = y;
                    trace[x1][y1][z1].z = z;
                    heap.push(node(d[x1][y1][z1], x1, y1, z1));
                }
            }
        }
    }
    For(j, 0, n) if (i != j) {
        cp[i][j] = d[l[j].x][l[j].y][l[j].z];
        truyvet(i, j);
    }
}

void nguoc(int i, int tt) {
    if (!tt) return;
    int j = trace2[i][tt];
    For(jj, 0, sz(path[i][j])-1) path2.pb(path[i][j][jj]);
    nguoc(j, tt - two(i));
}

void tam(int x, int y, int z) {
    double xx, yy, zz;
    xx = xmin + t / 2 + t * (x - 1);
    yy = ymin + t / 2 + t * (y - 1);
    zz = zmin + t / 2 + t * (z - 1);
    printf("%.6lf %.6lf %.6lf\n", xx, yy, zz);
}

void bug(int i, int j) {
    cout << i << ' ' << j << endl;
    For(jj, 0, sz(path[i][j])-1) cout << path[i][j][jj].x << ' ' << path[i][j][jj].y << ' ' << path[i][j][jj].z << endl;
}

void init() {
    n = sz(l) - 1;
    //cout << n << endl;
    a = xmax - xmin; b = ymax - ymin; c = zmax - zmin;
    na = a / t; if (a - na*t != 0) na++; if (!na) na++;
    nb = b / t; if (b - nb*t != 0) nb++; if (!nb) nb++;
    nc = c / t; if (c - nc*t != 0) nc++; if (!nc) nc++;
    na++; nb++; nc++;
    For(i, 0, n) Dij(i);
}

void sub1() {
   // bug(0, 1);
    reset(f, 0x7f);
    int T = two(n+1) - 1;
    f[0][1] = 0;
    For(tt, 0, T) For(i, 0, n) if (bit(tt, i)){
        For(j, 0, n) if (!bit(tt, j)) {
            int t1 = onbit(tt, j);
            if (f[j][t1] > f[i][tt] + cp[i][j]) {
                f[j][t1] = f[i][tt] + cp[i][j];
                trace2[j][t1] = i;
            }
        }
    }
    double res = 1000000000000000LL;
    int j = 0;
    For(i, 0, n) if (res > f[i][T]) {
        res = f[i][T]; j = i;
    }
    printf("%lf\n", res);
    path2.pb(l[j]);
    nguoc(j, T);
    reverse(all(path2));
    printf("%d\n", sz(path2));
    For(i, 0, sz(path2)-1) tam(path2[i].x, path2[i].y, path2[i].z);
}

bool dd[M];

void sub2() {
    n = sz(l)-1;
    reset(dd, true); dd[0] = false;
    int i = 0, len = 0;
    path2.pb(l[0]);
    double res = 0;
    while (len < n) {
        len++;
        double temp = 1000000000;
        int u = 0;
        For(j, 0, n) if (dd[j] && cp[i][j] < temp) {
            temp = cp[i][j]; u = j;
        }
        int j = u; res += cp[i][j]; dd[j] = false;
        For(jj, 0, sz(path[i][j])-1) path2.pb(path[i][j][jj]);
        i = j;
    }
    printf("%.6lf\n", res);
    printf("%d\n", sz(path2));
    For(i, 0, sz(path2)-1) tam(path2[i].x, path2[i].y, path2[i].z);
}

bool gb(double a, double b) {
    if (abs(a-b) <= eps) return true;
    return false;
}

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("","r",stdin);
    freopen("kq.out","w",stdout);
    freopen("thamso.inp", "r", stdin);
    cin >> t >> aa >> bb >> cc;
    xmin = ymin = zmin = 1000000000;
    xmax = ymax = zmax = -1000000000;
    freopen("cam.inp", "r", stdin);
    double x, y, z;
    int nn = 0, mm = 0;
    while (scanf("%lf %lf %lf\n", &x, &y, &z) != -1) {
        xmin = min(xmin, x); xmax = max(xmax, x);
        ymin = min(ymin, y); ymax = max(ymax, y);
        zmin = min(zmin, z); zmax = max(zmax, z);
        xx1[++nn] = x; yy1[nn] = y; zz1[nn] = z;
    }
    freopen("di.inp", "r", stdin);
    while (scanf("%lf %lf %lf", &x, &y, &z) != -1) {
        xmin = min(xmin, x); xmax = max(xmax, x);
        ymin = min(ymin, y); ymax = max(ymax, y);
        zmin = min(zmin, z); zmax = max(zmax, z);
        xx2[++mm] = x; yy2[mm] = y; zz2[mm] = z;
    }
    For(i, 1, nn) {
        x = xx1[i] - xmin; y = yy1[i] - ymin; z = zz1[i] - zmin;
        int tx = x/t, ty = y/t, tz = z/t;
        int dx1, dx2, dy1, dy2, dz1, dz2;
        dx1 = dx2 = dy1 = dy2 = dz1 = dz2 = 1;
        if (gb(0, x - t*tx)) dx2++;
        if (gb(0, y - t*ty)) dy2++;
        if (gb(0, z - t*tz)) dz2++;
        For(ii, dx1, dx2) For(jj, dy1, dy2) For(kk, dz1, dz2)
        avai[ii][jj][kk] = -1;
    }
    For(i, 1, mm) {
        x = xx2[i] - xmin; y = yy2[i] - ymin; z = zz2[i] - zmin;
        x = (x / t) + 1; y = (y / t) + 1; z = (z / t) + 1;
        if (avai[int(x)][int(y)][int(z)] < 1) l.pb(make_triple(x, y, z));
        avai[int(x)][int(y)][int(z)] = 1;
    }
    init();
    if (sz(l) <= 20) sub1();
    else sub2();
}
