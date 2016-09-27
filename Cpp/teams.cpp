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
#define a first
#define b second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define getbit(x, i) ((x >> (i-1)) & 1LL)
#define onbit(x, i) (x | (1LL << (i-1)))
#define offbit(x, i) (x & ~(1 << (i-1)))
#define N 500010
#define Q 200010

struct node {
    node *left, *right;
    int val;
};

int n, q, k[Q], m;
ii s[N];
node *t[N], *used;

/* nối nút parent làm cha nút child, is_left == true nếu child là con trái */

void noi(node *parent, node *child, bool is_left) {
    if (is_left) parent->left = child;
    else parent->right = child;
}

node *khoitao(int lo, int hi) { /* Trả về cây rỗng, các nút đều có giá trị = 0 */
    node *root = new node(); root->val = 0;
    if (lo == hi) return root;
    int mid = (lo + hi) / 2;
    noi(root, khoitao(lo, mid), true);
    noi(root, khoitao(mid+1, hi), false);
    return root;
}

/* cập nhật vị trí u giá trị x, nếu x == 0 thì gán vị trí u = 0, nếu không thì tăng giá trị nút đó lên x */

void update(node *r1, node *r2, int lo, int hi, int u, int x) {
    if (lo == hi) {
        if (!x) r2->val = 0; else r2->val = r1->val + x;
        return;
    }
    int mid = (lo + hi) / 2;
    if (u <= mid) {
        noi(r2, r1->right, false);
        node *left = new node();
        update(r1->left, left, lo, mid, u, x);
        noi(r2, left, true);
    } else {
        noi(r2, r1->left, true);
        node *right = new node();
        update(r1->right, right, mid+1, hi, u, x);
        noi(r2, right, false);
    }
    r2->val = r2->left->val + r2->right->val;
}

void init() { /* Khởi tạo cây t[i] */
    sort(s+1, s+n+1); /* sort các đoạn thẳng theo giá trị tăng dần của a */
    int j = 1;
    t[0] = khoitao(1, n); /* xây dựng cây t[0] là cây rỗng, tất cả các nút đều có giá trị 0 */
    For(i, 1, n) {
        t[i] = new node(); /* tạo nút mới cho cây t[i] */
        t[i]->val = t[i-1]->val; t[i]->left = t[i-1]->left; t[i]->right = t[i-1]->right; /* khởi tạo cây t[i] giống cây t[i-1] */
        update(t[i], t[i], 1, n, i-1, 0); /* loại bỏ các giá trị b phủ i-1 mà không phủ i */
        while (j <= n && s[j].a <= i) {
            if (s[j].b >= i) update(t[i], t[i], 1, n, s[j].b, 1); /* thêm giá trị b phủ i nhưng không phủ i-1 */
            j++;
        }
    }
}

bool can;

/* hàm walk cập nhật lại cây used dựa trên cây avail, sử dụng K giá trị b nhỏ nhất */

node *walk(node *avail, node *used, int lo, int hi, int K) {
    if (avail->val - used->val < K) { /* nếu không đủ giá trị thì kết quả = 0 */
        can = false; return NULL;
    }
    node *root = new node();
    if (lo == hi) { /* sử dụng K giá trị ở nút lá và thoát */
    	root->val = used->val + K;
    	return root;
	}
    int leftVal = avail->left->val - used->left->val; /* số giá trị có thể sử dụng ở con trái */
    node *newLeft, *newRight;
    int mid = (lo + hi) / 2;
    if (leftVal >= K) { /* nếu bên trái đủ */
        newLeft = walk(avail->left, used->left, lo, mid, K); /* đi sử dụng K nút ở con trái */
        newRight = used->right; /* giữ nguyên con phải */
    } else {
        newLeft = avail->left; /* dùng hết con trái */
        newRight = walk(avail->right, used->right, mid+1, hi, K - leftVal); /* đi dùng tiếp K - leftVal ở con phải */
    }

    noi(root, newLeft, true); noi(root, newRight, false); /* xây dựng nút mới */
    root->val = newLeft->val + newRight->val;
    return root;
}

/* hàm Fill xét nút trên cây persistent gốc r2, quản lí đoạn lo->hi và gán đoạn u->v = 0 */

node *Fill(node *r1, node *r2, int lo, int hi, int u, int v) {
    if (u > v) return r2;
    if (u <= lo && hi <= v) return r1; /* r1 là nút rỗng */
    if (u > hi || v < lo) return r2;
    int mid = (lo + hi) / 2;
    node *newLeft = Fill(r1->left, r2->left, lo, mid, u, v);
    node *newRight = Fill(r1->right, r2->right, mid+1, hi, u, v);
    node *root = new node();
    noi(root, newLeft, true); noi(root, newRight, false);
    root->val = newLeft->val + newRight->val;
    return root;
}

int solve() {
    sort(k+1, k+m+1); /* sort tăng theo giá trị các điểm */
    can = true;
    used = t[0]; /* khởi tạo cây used là cây rỗng, các giá trị = 0 */
    For(i, 1, m) {
        if (i > 1) used = Fill(t[0], used, 1, n, k[i-1], k[i]-1); /* loại bỏ trong used các giá trị đã sử dụng nhưng không phủ K[i] */
        used = walk(t[k[i]], used, 1, n, k[i]); /* cập nhật lại cây used */
        if (!can) return 0; /* nếu không đủ trả về 0 */
    }
    return 1; /* trả về 1 nếu tất cả đều thỏa mãn */
}


int main() {
    freopen("teams.inp","r",stdin);
    freopen("teams.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d%d", &s[i].a, &s[i].b); /* Mảng s lưu các đoạn thẳng (s[i].a, s[i].b) */
    init();
    scanf("%d", &q);
    For(test, 1, q) {
        scanf("%d", &m);
        For(i, 1, m) scanf("%d", k+i); /* mảng k lưu các điểm */
        printf("%d\n", solve());
    }
}


