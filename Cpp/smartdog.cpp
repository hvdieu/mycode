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
#define N 100010
#define MAX 1001
#define NN 1000
#define inf 1000000000

struct node {
    int val;
    node *l, *r;
};

int n, k, res;
node *t[8010];

void insert(node *&root, int lo, int hi, int u, int x) {
    if (hi < u || lo > u) return;
    if (root == NULL) {
        root = new node(); root->l = root->r = NULL;
        root->val = x;
    } else root->val = max(root->val, x);
    if (lo == hi) return;
    int mid = (lo+hi)/2;
    insert(root->l, lo, mid, u, x);
    insert(root->r, mid+1, hi, u, x);
}

void update(int i, int lo, int hi, int u, int v, int x) {
    if (hi < u || lo > u) return;
    insert(t[i], 0, 2000, v, x);
    if (lo == hi) return;
    int mid = (lo+hi)/2;
    update(i*2, lo, mid, u, v, x);
    update(i*2+1, mid+1, hi, u, v, x);
}

int query(node *root, int lo, int hi, int y1, int y2) {
    if (root == NULL) return -inf;
    if (lo > y2 || hi < y1) return -inf;
    if (y1 <= lo && hi <= y2) return root->val;
    int mid = (lo+hi)/2;
    return max(query(root->l, lo, mid, y1, y2),
               query(root->r, mid+1, hi, y1, y2));
}

int get(int i, int lo, int hi, int x1, int x2, int y1, int y2) {
    if (lo > x2 || hi < x1) return -inf;
    if (x1 <= lo && hi <= x2) return query(t[i], 0, 2000, y1, y2);
    int mid = (lo+hi)/2;
    return max(get(i*2, lo, mid, x1, x2, y1, y2),
               get(i*2+1, mid+1, hi, x1, x2, y1, y2));
}

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    res = 0;
    scanf("%d%d", &n, &k);
    update(1, 1, 2*MAX, 0+MAX, 0, 0);
    For(i, 1, n) {
        int x, y, c, u; scanf("%d%d%d", &x, &y, &c);
        u = x; x -= y; y += u;
        int x1 = max(x-k, -NN), x2 = min(x+k, NN), y1 = max(y-k, 0), y2 = min(y+k, 2000);
        int f = get(1, 1, 2*MAX, x1+MAX, x2+MAX, y1, y2) + c;
        res = max(res, f);
        update(1, 1, 2*MAX, x+MAX, y, f);
    }
    cout << res;
}
