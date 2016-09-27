#include <bits/stdc++.h>

using namespace std;
typedef pair<double, double> point;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
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
#define N 1001
#define sl 50

const double inf = 1000000000000.0;

int n, k;
point a[N];
double f[N][N];
int trace[N][N];
int lef[N], righ[N];
double res;
point kq[N];

bool cmp(point a, point b) {
    if (a.x != b.x) return a.x < b.x;
    return a.y < b.y;
}

double dis(point a, point b) {
    double xx = a.x - b.x, yy = a.y - b.y;
    return sqrt(xx*xx + yy*yy);
}

point cal(int l, int r) {
    double ymax, ymin, xmax, xmin;
    ymax = xmax = 0;
    ymin = xmin = inf;
    For(i, l, r) {
        xmax = max(xmax, a[i].x);
        xmin = min(xmin, a[i].x);
        ymax = max(ymax, a[i].y);
        ymin = min(ymin, a[i].y);
    }
    point center = point((xmin + xmax)/2, (ymin + ymax)/2);
    return center;
}

double tinh() {
    double res = 0;
    For(i, 1, n) {
        double tmp = inf;
        For(j, 1, k) tmp = min(tmp, dis(kq[j], a[i]));
        res = res + tmp;
    }
    return res;
}

int main() {
    freopen("sieuthi.inp","r",stdin);
    freopen("sieuthi.out","w",stdout);
    cin >> n >> k;
    For(i, 1, n) cin >> a[i].x >> a[i].y;
    sort(a+1, a+n+1, cmp);
    int p = n / k;
    For(i, 1, k) {
        lef[i] = righ[i-1] + 1;
        righ[i] = lef[i] + p - 1;
    }
    righ[k] = n;
    For(i, 1, k) kq[i] = cal(lef[i], righ[i]);
    res = tinh();
    For(test, 1, sl) {
        int id = rand() % k + 1;
        while (righ[id] < righ[id+1]-1) {
            if (righ[id] == n) break;
            righ[id]++; lef[id+1]++;
            For(i, 1, k) kq[i] = cal(lef[i], righ[i]);
            double tmp = tinh();
            if (tmp < res) res = tmp;
            else {
                righ[id]--; lef[id+1]--;
                break;
            }
        }
        while (lef[id] > lef[id-1]+1) {
            if (lef[id] == 1) break;
            lef[id]--; righ[id-1]--;
            For(i, 1, k) kq[i] = cal(lef[i], righ[i]);
            double tmp = tinh();
            if (tmp < res) res = tmp;
            else {
                lef[id]++; righ[id-1]++;
                break;
            }
        }
    }
    For(i, 1, k) {
        kq[i] = cal(lef[i], righ[i]);
        printf("%.2lf %.2lf\n", kq[i].x, kq[i].y);
    }
}
