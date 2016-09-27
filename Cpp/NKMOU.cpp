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
#define inf 1000000001

struct node {
    int S, H;
    int f;
    node *l, *r;
};

int n;
node *t;
char c;
int u, v, d, h, sum, res;

void tao(node *&t) {
    if (t == NULL) {
        t = new node();
        t->l = t->r = NULL;
        t->S = t->H = t->f = inf;
    }
}

void gan(node *&t, int l, int r, int d) {
    t->S = ll(d)*(r-l+1);
    if (d >= 0) t->H = ll(d)*(r-l+1);
    else t->H = 0;
}

void down(node *&t, int l, int r) {
    tao(t->l); tao(t->r);
    int mid = (l+r)/2;
    if (t->f != inf) {
        gan(t->l, l, mid, t->f);
        gan(t->r, mid+1, r, t->f);
        t->l->f = t->r->f = t->f;
        t->f = inf;
    }
}

void update(node *&t, int l, int r, int u, int v, int d) {
    if (l > v || r < u) return;
    tao(t);
    if (u <= l && r <= v) {
        t->f = d;
        gan(t, l, r, d);
        return;
    }
    down(t, l, r);
    int mid = (l+r)/2;
    update(t->l, l, mid, u, v, d);
    update(t->r, mid+1, r, u, v, d);
    t->S = t->l->S + t->r->S;
    t->H = max(t->l->H, t->l->S + t->r->H);
}

void Query(node *&t, int l, int r, int h) {
    if (l == r) {
    	if (sum + t->H <= h) res = l;
    	return;
	}
    down(t, l, r);
    int mid = (l + r) / 2;
    if (sum + t->l->H <= h) {
    	res = mid;
        sum += t->l->S;
        Query(t->r, mid+1, r, h);
    } else Query(t->l, l, mid, h);
    t->S = t->l->S + t->r->S;
    t->H = max(t->l->H, t->l->S + t->r->H);
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("nkmou.inp","r",stdin);
    freopen("nkmou.out","w",stdout);
    scanf("%d\n", &n);
    t = NULL;
    update(t, 0, n, 0, n, 0);
    while (1) {
        scanf("%c", &c);
        if (c == 'E') break;
        if (c == 'I') scanf("%d %d %d\n", &u, &v, &d);
        else scanf("%d\n", &h);
        if (c == 'I') update(t, 0, n, u, v, d);
        else {
            sum = 0;
            res = 0;
            Query(t, 0, n, h);
            printf("%d\n", res);
        }
    }
}
