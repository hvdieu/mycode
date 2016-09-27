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
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 500010

struct query {
    char c;
    int a, b;
};

struct node {
    int key, con;
    node *left, *right, *cha;
};

int n, ntest, res, dem;
query q[N];
vector<ii> l;
node *t[N], *nilt;

void init() {
    nilt = new node(); nilt->left = nilt->right = nilt->cha = nilt;
    sort(all(l));
    n = 1;
    For(i, 0, sz(l)-1) {
        if (i && l[i].fi != l[i-1].fi) n++;
        q[l[i].se].a = n;
    }
    For(i, 1, n) t[i] = nilt;
}

node *tao(int x) {
    node *i; i = new node();
    i->left = i->right = i->cha = nilt;
    i->key = x; i->con = 1;
    return i;
}

void cnt(node *i, node *j, bool ok) {
    j->cha = i;
    if (ok) i->left = j; else i->right = j;
}

void cc(node *i) {
    i->con = i->left->con + i->right->con + 1;
}

void uptree(node *i) {
    node *j, *p = i->cha, *pp = p->cha;
    if (p->left == i) {
        j = i->right;
        cnt(i, p, false);
        cnt(p, j, true);
    } else {
        j = i->left;
        cnt(i, p, true);
        cnt(p, j, false);
    }
    cnt(pp, i, pp->left == p);
    cc(p); cc(i);
}

node* splay(node *i) {
    node *p, *pp;
    while (i->cha != nilt) {
        p = i->cha; pp = p->cha;
        if (pp != nilt)
            if ((pp->left == p) == (p->left == i)) uptree(p); else uptree(i);
        uptree(i);
    }
    return i;
}

void insert(node *&root, node *j) {
    if (root == nilt) {
        root = j; return;
    }
    node *i = root;
    while (1) {
        i->con++;
        if (j->key < i->key) {
            if (i->left == nilt) { cnt(i, j, true); return; }
            i = i->left;
        } else {
            if (i->right == nilt) { cnt(i, j, false); return; }
            i = i->right;
        }
    }
    root = splay(j);
}

void count_great(node *&root, int x) {
    node *i = root, *j = nilt;
    while (i != nilt) {
        j = i;
        if (x <= i->key) {
            res += i->right->con+1;
            i = i->left;
        } else i = i->right;
    }
    if (j != nilt) root = splay(j);
}

void update(int i, int x) {
    for(i; i <= n; i += i & (-i)) {
    	//cout << i << ' ';
        node *j = tao(x);
        insert(t[i], j);
    }
   // cout << endl;
}

void get(int i, int x) {
    for(i; i; i -= i & (-i)) {
    	//cout << i << ' ';
    	count_great(t[i], x);
	}
	//cout << endl;
}

void solve() {
    For(test, 1, ntest) {
        int a = q[test].a, b = q[test].b;
        if (q[test].c == '+') update(a, b);
        else {
            res = 0;
            get(a, b);
            printf("%d\n", res);
        }
    }
}

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    scanf("%d\n", &ntest);
    For(i, 1, ntest) {
        scanf("%c %d %d\n", &q[i].c, &q[i].a, &q[i].b);
        l.pb(ii(q[i].a, i));
    }
    init();
    solve();
}
