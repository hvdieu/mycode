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
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define getbit(x, i) ((x >> (i-1)) & 1LL)
#define onbit(x, i) (x | (1LL << (i-1)))
#define offbit(x, i) (x & ~(1 << (i-1)))
#define N 500010
#define BASE 1000000007

/* nút interval lưu các giá trị
    p : lưu tích X[i] mod BASE
    id : lưu vị trí P[i] * Y[i] max nhất
    MAX : lưu giá trị log(P[i]) + log(Y[i]) max nhất
    f : biến nhớ để lazy update
*/

struct node {
    int p, id;
    double MAX, f;
};

int n, m, x[N], y[N];
double p[N];
node t[4*N];

/* hàm lazy update truyền từ nút cha xuống nút con */

void down(int i) {
    t[i*2].f += t[i].f; t[i*2].MAX += t[i].f;
    t[i*2+1].f += t[i].f; t[i*2+1].MAX += t[i].f;
    t[i].f = 0;
}

/* khởi tạo cây interval với dãy X Y ban đầu */

void init(int i, int lo, int hi) {
    if (lo == hi) {
        t[i].id = lo;
        t[i].MAX = log(y[lo]) + p[lo];
        t[i].p = x[lo];
        return;
    }
    int mid = (lo + hi) / 2, c1 = i*2, c2 = c1 + 1;
    init(c1, lo, mid); init(c2, mid+1, hi);
    int j;
    if (t[c1].MAX >= t[c2].MAX) j = c1; else j = c2;
    t[i].MAX = t[j].MAX; t[i].id = t[j].id;
    t[i].p = (1LL * t[c1].p * t[c2].p) % BASE;
}

/* trả về P[i] mod BASE */

int get(int i, int lo, int hi, int u, int v) {
    if (u <= lo && hi <= v) return t[i].p;
    if (u > hi || v < lo) return 1;
    int mid = (lo + hi) / 2, c1 = i*2, c2 = c1 + 1;
    down(i);
    return (1LL * get(i*2, lo, mid, u, v) * get(i*2+1, mid+1, hi, u, v)) % BASE;
    int j;
    if (t[c1].MAX >= t[c2].MAX) j = c1; else j = c2;
    t[i].MAX = t[j].MAX; t[i].id = t[j].id;
    t[i].p = (1LL * t[c1].p * t[c2].p) % BASE;
}

void inkq() {
    int i = t[1].id;
    int P = get(1, 1, n, 1, i);
    int res = (1LL * P * y[i]) % BASE;
    printf("%d\n", res);
}

/* lazy update tăng đoạn u v giá trị val */

void update(int i, int lo, int hi, int u, int v, double val) {
    if (u > hi || v < lo) return;
    if (u <= lo && hi <= v) {
        t[i].MAX += val;
        t[i].f += val;
        return;
    }
    int mid = (lo + hi) / 2, c1 = i*2, c2 = c1 + 1;
    down(i);
    update(i*2, lo, mid, u, v, val);
    update(i*2+1, mid+1, hi, u, v, val);
    int j;
    if (t[c1].MAX >= t[c2].MAX) j = c1; else j = c2;
    t[i].MAX = t[j].MAX; t[i].id = t[j].id;
    t[i].p = (1LL * t[c1].p * t[c2].p) % BASE;
}

/* cập nhật lại vị trí X[u] = val để tính P[i] */

void modify(int i, int lo, int hi, int u) {
    if (lo == hi) {
        t[i].p = x[lo];
        return;
    }
    if (u > hi || u < lo) return;
    int mid = (lo + hi) / 2, c1 = i*2, c2 = c1 + 1;
    down(i);
    modify(i*2, lo, mid, u);
    modify(i*2+1, mid+1, hi, u);
    int j;
    if (t[c1].MAX >= t[c2].MAX) j = c1; else j = c2;
    t[i].MAX = t[j].MAX; t[i].id = t[j].id;
    t[i].p = (1LL * t[c1].p * t[c2].p) % BASE;
}

void updateX(int pos, int val) {
    update(1, 1, n, pos, n, -log(x[pos])+log(val)); // chia đoạn pos -> n đi x[pos] và nhân với val
    x[pos] = val;
    modify(1, 1, n, pos);
}

void updateY(int pos, int val) {
    update(1, 1, n, pos, pos, -log(y[pos])+log(val)); // chia vị trí pos đi y[pos] và nhân với val
    y[pos] = val;
}

int main() {
    freopen("horses.inp","r",stdin);
    freopen("horses.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) {
        scanf("%d", x + i);
        p[i] = p[i-1] + log(x[i]); /* p[i] lưu tổng log(X[j]) với j : 1 -> i */
    }
    For(i, 1, n) scanf("%d", y + i);
    init(1, 1, n);
    inkq();
    scanf("%d", &m);
    For(i, 1, m) {
        int type, pos, val;
        scanf("%d%d%d", &type, &pos, &val);
        if (type == 1) updateX(pos+1, val);
        else           updateY(pos+1, val);
        inkq();
    }
}


