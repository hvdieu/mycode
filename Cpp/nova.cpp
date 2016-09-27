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

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define x first
#define y second
#define ld long double
#define pb push_back
#define all(x) x.begin(), x.end()
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define two(i) (ll(1) << i)
#define bit(x, i) ( (x >> i) & 1 )
#define onbit(x, i) ( x | (1 << i ) )
#define N 210

struct heros {
    int x, y, r, t;
};

struct creep {
    int x, y;
};

struct tree {
    int x, y, r;
};

struct line {
    ll a, b, c;
};

struct node {
    int val, i;
    node(int a, int b) {
        val = a; i = b;
    }
};

bool operator > (node a, node b) {
    return a.val > b.val;
}

int ntest, n, m, k, match[N];
heros a[N];
creep b[N];
tree c[N];
bool cankill[N][N];
priority_queue< node, vector<node>, greater<node> > heap;
bool was[N];

void input() {
    scanf("%d%d%d", &n, &m, &k);
    For(i, 1, n) scanf("%d%d%d%d", &a[i].x, &a[i].y, &a[i].r, &a[i].t);
    For(i, 1, m) scanf("%d%d", &b[i].x, &b[i].y);
    For(i, 1, k) scanf("%d%d%d", &c[i].x, &c[i].y, &c[i].r);
}

double dis(heros a, creep b) {
    int xx = a.x - b.x;
    int yy = a.y - b.y;
    return sqrt(xx * xx + yy * yy);
}

void build(ii A, ii B, line &d) {
    d.a = B.y - A.y;
    d.b = A.x - B.x;
    d.c = ll(A.x) * (A.y - B.y) + ll(A.y) * (B.x - A.x);
}

ii Vector(ii A, ii B) {
    return ii(B.x - A.x, B.y - A.y);
}

double goc(ii A, ii B) {
    return (A.x * B.x + A.y * B.y);
}

double kc(ii M, line d) {
    return abs(d.a * M.x + d.b * M.y + d.c) / sqrt(d.a * d.a + d.b * d.b);
}

bool notree(heros a, creep b) {
    ii A, B;
    A = ii(a.x, a.y); B = ii(b.x, b.y);
    line d;
    build(A, B, d);
    ii AB = Vector(A, B);
    ii BA = Vector(B, A);
    For(i, 1, k) {
        ii O = ii(c[i].x, c[i].y);
        ii AO = Vector(A, O);
        ii BO = Vector(B, O);
        if (goc(AB, AO) > 0 && goc(BA, BO) > 0 && kc(O, d) <= c[i].r) return false;
    }
    return true;
}

void init() {
    reset(cankill, false);
    For(i, 1, n) For(j, 1, m)
    if (dis(a[i], b[j]) <= a[i].r && notree(a[i], b[j]))
	cankill[i][j] = true;
}

bool dfs(int i) {
    if (was[i]) return false;
    was[i] = true;
    For(j, 1, m) if (cankill[i][j])
    if (!match[j] || dfs(match[j])) {
        match[j] = i; return true;
    }
    return false;
}

void solve() {
    int res = 0;
    while (!heap.empty()) heap.pop();
    reset(match, 0);
    For(i, 1, n) heap.push(node(0, i));
    int killed = 0;
    while (!heap.empty()) {
        if (killed == m) break;
        int i = heap.top().i, val = heap.top().val;
        res = max(res, val);
        heap.pop();
        bool flag = false;
        For(j, 1, m) if (cankill[i][j])
        if (!match[j] || dfs(match[j])) {
            match[j] = i; killed++;
            reset(was, false);
            flag = true; break;
        }
        if (flag) heap.push(node(val + a[i].t, i));
    }
    if (killed < m) cout << -1 << endl;
    else cout << res << endl;
}

int main() {
    freopen("input.txt","r",stdin);
   // freopen("output.txt","w",stdout);
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        input();
        init();
        solve();
    }
}
