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
#define offbit(x, i) (x & ~(1 << (i-1)))

int onbit(int x, int i) {
    if (!i) return x;
    return (x | (1 << (i-1)));
}

ll L, R;
int K, ntest, timer, cnt;
ll f[20][512][2520][2];
bool d[512][2520];
string s;

int check(int mask, int mod) {
    if (__builtin_popcount(mask) < K) return 0;
    int cnt = 0;
    For(i, 1, 9) if (getbit(mask, i))
        cnt += (mod % i == 0);
    return cnt >= K;
}

ll cal(int i, int ok, int mask, int mod) {
    cnt++;
    if (f[i][mask][mod][ok] != -1)
        return f[i][mask][mod][ok];
    if (i == sz(s))
        return f[i][mask][mod][ok] = d[mask][mod];

    f[i][mask][mod][ok] = 0;
    int last = 9;
    if (!ok) last = s[i] - '0';
    For(j, 0, last)
        f[i][mask][mod][ok] += cal(i+1, ok | (j < last), onbit(mask, j), (mod * 10 + j) % 2520);
    return f[i][mask][mod][ok];
}

ll solve(ll x) {
    s = to_string(x);
    reset(f, -1);
    return cal(0, 0, 0, 0);
}


int main() {
    freopen("in.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> ntest;
    while (ntest--) {
        cin >> L >> R >> K;
        REP(mask, 1 << 9) REP(mod, 2520) d[mask][mod] = check(mask, mod);
        ll ans1 = solve(R);
        ll ans2 = solve(L-1);
        cout << ans1 - ans2 << "\n";
        //cout << solve(R) - solve(L-1) << "\n";
    }
    cout << cnt;
}


