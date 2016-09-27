#include <vector>
#include <algorithm>
#include <math.h>
#include <iostream>
#include <stdio.h>
#include <string.h>
#include <cmath>
#include <cstring>
#include <queue>
#include <stack>
#include <set>

using namespace std;
typedef pair<double, double> ii;

typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ld long double
#define pb push_back
#define all(x) x.begin(), x.end()
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define two(i) (ll(1) << i)
#define bit(x, i) ( (x >> i) & 1 )
#define onbit(x, i) ( x | (1 << i ) )
#define N 1000010
#define M 1000001

struct node {
    double a, b;
    int id;
};

node make_node(double aa, double bb, int c) {
    node X;
    X.a = aa; X.b = bb; X.id = c;
    return X;
}

set<node, greater<node> > t[4*N];
set<node, greater<node> >::iterator it;
int l[N], r[N], n, q, xx, r1, res;
double a[N], b[N];
bool deleted[N];
node line;

bool operator > (const node &a, const node &b) {
    double y1 = a.a * xx + a.b;
    double y2 = b.a * xx + b.b;
    return y1 > y2;
}

void build(int x1, int y1, int x2, int y2, double &a, double &b) {
    a = (double(y1) - y2) / (x1 - x2);
    b = double(y1) - a * x1;
}

void update(int i, int lo, int hi, int u, int v, node line) {
    if (lo == u && hi == v) {
        xx = (lo + hi) / 2;
        t[i].insert(line);
        return;
    }
    int mid = (lo + hi) / 2;
    if (u <= mid) update(i*2, lo, mid, u, min(mid, v), line);
    if (v > mid) update(i*2+1, mid+1, hi, max(mid+1, u), v, line);
}

void del(int i, int lo, int hi, int u, int v, node line) {
    if (lo == u && hi == v) {
        xx = (lo + hi) / 2;
        it = t[i].find(line);
        t[i].erase(it);
        return;
    }
    int mid = (lo+hi) / 2;
    if (u <= mid) del(i*2, lo, mid, u, min(mid, v), line);
    if (v > mid) del(i*2+1, mid+1, hi, max(mid+1, u), v, line);
}

void get(int i, int lo, int hi, int x, node line) {
    xx = x;
    it = t[i].lower_bound(line);
    if (it != t[i].end()) {
        int temp = it->a * x + it->b;
        if (temp > r1) {
            r1 = temp; res = it->id;
        }
    }
    if (lo == hi) return;
    int mid = (lo + hi) / 2;
    if (x <= mid) get(i*2, lo, mid, x, line);
    else get(i*2+1, mid+1, hi, x, line);
}

int main() {
   // freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &q);
    For(i, 1, q) {
        int kind, x1, y1, x2, y2;
        scanf("%d", &kind);
        if (kind == 1) {
            scanf("%d%d%d%d", &x1, &y1, &x2, &y2);
            if (x1 > x2) {
                swap(x1, x2); swap(y1, y2);
            }
            n++; l[n] = x1; r[n] = x2;
            build(x1, y1, x2, y2, a[n], b[n]);
            update(1, 1, M, x1, x2, make_node(a[n], b[n], n));
        } else if (kind == 2) {
            int u; scanf("%d", &u);
            if (!deleted[u]) {
                deleted[u] = true;
                del(1, 1, M, l[u], r[u], make_node(a[u], b[u], u));
            }
        } else {
            int x, y;
            scanf("%d %d", &x, &y);
            res = r1 = 0;
            line.a = 0; line.b = y;
        //    if (line < make_node(a[1], b[1], 1)) cout << -1;
         //   else cout << 1; cout << endl;
            get(1, 1, M, x, line);
            printf("%d\n", res);
        }
    }
}


