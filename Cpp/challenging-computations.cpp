#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;
typedef long double ld;

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
#define N 100010

struct line {
    int a, b;
    long double x;
};

int n, m, ntest, top, k, lmin;
ll tu, mau;
ii a[N], b[N];
line st[N];

void add(ii d) {
    ld a1 = ld(1) / d.fi, b1 = d.se;
    while (top) {
        ld a2 = ld(1) / st[top-1].a, b2 = st[top-1].b;
        if (!st[top-1].a) a2 = 0;
        ld xx = (b2-b1) / (a1-a2);
        if (xx <= st[top].x) top--;
        else break;
    }
    top++; st[top].a = d.fi; st[top].b = d.se;
    ld a2 = ld(1) / st[top-1].a, b2 = st[top-1].b;
    if (!st[top-1].a) a2 = 0;
    ld xx = (b2-b1) / (a1-a2);
    st[top].x = xx;
}

ll gcd(ll a, ll b) {
    if (!b) return a;
    return gcd(b, a % b);
}

line Find(ll key) {
    int d = 1, c = top, mid, ans;
    while (d <= c) {
        mid = (d+c)/2;
        if (st[mid].x <= key) {
            ans = mid; d = mid+1;
        } else c = mid - 1;
    }
    return st[ans];
}

bool cmp(ii a, ii b) {
	if (a.se != b.se) return a.se < b.se;
	return a.fi > b.fi;
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d%d", &n, &k);
        int lmax = 0, luu = 0;
        For(i, 1, n) {
            scanf("%d%d", &a[i].fi, &a[i].se);
        }
        sort(a+1, a+n+1, cmp); m = 0;
        For(i, 1, n) if (a[i].fi > lmax && a[i].se != luu) {
            lmax = a[i].fi; b[++m] = a[i]; luu = a[i].se;
        }
        top = 0; st[0].a = a[1].fi;
        For(i, 1, m)
		add(b[i]);
        For(i, 1, k) {
            ll x; scanf("%lld", &x);
            line d = Find(x);
            tu = x + ll(d.a)*d.b;
            mau = d.a;
            ll f = gcd(tu, mau); tu /= f; mau /= f;
            printf("%lld/%lld\n", tu, mau);
        }
    }
}
