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

struct track {
    int r, c1, c2;
    track(int _r, int _c1, int _c2) {
        r = _r; c1 = _c1; c2 = _c2;
    }
};

bool cmp(track a, track b) {
    if (a.r != b.r) return a.r < b.r;
    if (a.c1 != b.c1) return a.c1 < b.c1;
    return a.c2 < b.c2;
}

const int N = 1000 + 10;

int n, m, k;
vector<track> t;
vector<ii> c;
ll ans;

int main() {
    freopen("in.txt","r",stdin);
    cin >> n >> m >> k;
    For(i, 1, k) {
        int r, c1, c2;
        cin >> r >> c1 >> c2;
        t.pb(track(r, c1, c2));
    }
    sort(all(t), cmp);
    int i = 0;
    int cnt = 0;
    while (i < k) {
        cnt++;
        int j = i;
        while (j < k-1 && t[j+1].r == t[i].r) j++;
        int tmp = 0, last = 0;
        int sum = 0;
        c.clear();
        For(z, i, j) c.pb(ii(t[z].c1, 1)), c.pb(ii(t[z].c2+1, -1));
        sort(all(c));
        REP(z, sz(c)) {
            if (!tmp) last = c[z].fi;
            tmp += c[z].se;
            if (!tmp) sum += c[z].fi - last;
        }
        ans += m-sum;
        i = j + 1;
        //cout << ans << "\n";
    }
    ans += ll(m) * (n-cnt);
    cout << ans;
}


