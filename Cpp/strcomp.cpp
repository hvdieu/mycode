#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 300010

struct node {
    int sum;
    ull h;
};

int n;
ull mu[N];
char s[N];
node t[4*N];

void init(int i, int lo, int hi) {
    if (lo == hi) {
        t[i].sum = 1;
        t[i].h = s[lo] - '0';
        return;
    }
    int mid = (lo + hi) / 2;
    init(i*2, lo, mid);
    init(i*2+1, mid+1, hi);
    t[i].sum = t[i*2].sum + t[i*2+1].sum;
    t[i].h = t[i*2].h* mu[t[i*2+1].sum] + t[i*2+1].h;
}

void update(int i, int lo, int hi, int u) {
    if (lo == hi) {
        t[i].sum = 0;
        t[i].h = 0;
        return;
    }
    int mid = (lo + hi) / 2;
    if (u <= t[i*2].sum) update(i*2, lo, mid, u);
    else update(i*2+1, mid+1, hi, u - t[i*2].sum);
    t[i].sum = t[i*2].sum + t[i*2+1].sum;
    t[i].h = t[i*2].h* mu[t[i*2+1].sum] + t[i*2+1].h;
}

node get(int i, int lo, int hi, int u, int v) {
    node res;
    if (u <= lo && hi <= v) return t[i];
    if (lo > v || hi < u) {
        res.sum = 0; res.h = 0;
        return res;
    }
    int mid = lo + t[i*2].sum - 1;
    node l = get(i*2, lo, mid, u, v);
    node r = get(i*2+1, mid+1, hi, u, v);
    res.sum = l.sum + r.sum;
    res.h = l.h * mu[r.sum] + r.h;
    return res;
}

int main() {
    freopen("strcomp.inp","r",stdin);
    freopen("strcomp.out","w",stdout);
    scanf("%s\n", s+1);
    n = strlen(s+1);
    mu[0] = 1; For(i, 1, n) mu[i] = mu[i-1]*47;
    init(1, 1, n);
    int ntest;
    scanf("%d\n", &ntest);
    For(test, 1, ntest) {
        char kind;
        int u, v, k;
        scanf("%c ", &kind);
        if (kind == '-') {
            scanf("%d\n", &u);
            update(1, 1, n, u);
        } else {
            scanf("%d %d %d\n", &u, &v, &k);
            if (get(1, 1, t[1].sum, u, u + k - 1).h == get(1, 1, t[1].sum, v, v + k - 1).h) printf("YES\n");
            else printf("NO\n");
        }
    }
}
