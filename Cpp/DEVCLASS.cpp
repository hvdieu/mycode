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
#define N 100010

int n, kind, a[N], ntest, s0, s1;
char s[N];
vector<int> b, g;

int Do(int t) {
    b.clear(); g.clear();
    For(i, 1, n) {
        if (a[i] != t) if (!t) b.pb(i); else g.pb(i);
        t = 1 - t;
    }
    int res = 0;
    if (!kind) return sz(g);
    For(i, 0, sz(b)-1) {
        int u = b[i], v = g[i]; if (u > v) swap(u, v);
        if (kind == 1) res += abs(b[i] - g[i]);
        else res += v - u ;
    }
    return res;
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d\n", &kind);
        scanf("%s\n", s+1);
        n = strlen(s+1); s0 = s1 = 0;
        For(i, 1, n) if (s[i] == 'B') a[i] = 0, s0++; else a[i] = 1, s1++;
        if (abs(s0-s1) > 1) printf("-1\n");
        else {
            int res;
            if (s0 == s1) res = min(Do(0), Do(1));
            else if (s0 > s1) res = Do(0);
            else res = Do(1);
            printf("%d\n", res);
        }
    }
}
