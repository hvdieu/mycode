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
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 1000010
#define p1 1000000007
#define p2 236277

struct triple {
    int h1, h2, id;
    triple(int _h1, int _h2, int _id) {
        h1 = _h1; h2 = _h2; id = _id;
    }
};

bool cmp(triple a, triple b) {
    if (a.h1 != b.h1) return a.h1 < b.h1;
    return a.h2 < b.h2;
}

int n, m, kq[N];
char s[N];
vector<triple> a, b;

int main() {
    freopen("string.inp","r",stdin);
    freopen("string.out","w",stdout);
    scanf("%d%d\n", &n, &m);
    m = n / m;
    scanf("%s\n", s+1);
    int dem = 0;
    for(int i = 1; i <= n; i += m) {
        int h1 = 0, h2 = 0;
        For(j, i, i + m - 1) {
            h1 = (ll(h1) * 47 + s[j] - 'a' + 1) % p1;
            h2 = (ll(h2) * 57 + s[j] - 'a' + 1) % p2;
        }
        a.pb(triple(h1, h2, ++dem));
    }
    For(i, 1, n / m) {
        scanf("%s\n", s+1);
        int h1 = 0, h2 = 0;
        For(j, 1, m) {
            h1 = (ll(h1) * 47 + s[j] - 'a' + 1) % p1;
            h2 = (ll(h2) * 57 + s[j] - 'a' + 1) % p2;
        }
        b.pb(triple(h1, h2, i));
    }
    sort(all(a), cmp); sort(all(b), cmp);
    REP(i, sz(a)) kq[a[i].id] = b[i].id;
    For(i, 1, dem) printf("%d ", kq[i]);
}
