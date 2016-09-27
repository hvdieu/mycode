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

const int M = 1e9 + 7;
const int N = 5e5 + 10;
const int p1 = 1e9 + 9;
const int base = 47;

char s[N];
int n, m;
ll pw[N], h[N];

void init() {
    pw[0] = 1;
    For(i, 1, n) {
        pw[i] = (pw[i-1] * base) % M;
        h[i] = (h[i-1] * base + s[i] - 'a') % M;
    }
}

int getHash(int i, int j) {
    return (h[j] - (h[i-1] * pw[j-i+1]) % M + M) % M;
}

void solve() {
    int add = m / n;
    if (m % n == 0) add--;
    ll ans = m / n;
    //cout << m << ' ' << n << ' ' << add << "\n";
    For(len, 1, min(n-1, m)) {
        int x = getHash(1, len);
        int y = getHash(n-len+1, n);
        int l = n-len;
        int a = getHash(1, l), b = getHash(n-l+1, n);
       // cout << x << ' ' << y << "\n";
        if (x == y && a == b) {
            if (len <= m % n) ans += add+1;
            else ans += add;
        }
        ans %= M;
    }
    cout << ans;
}

int main() {
    //freopen("in.txt","r",stdin);
    scanf("%s\n", s+1);
    n = strlen(s+1);
    scanf("%d", &m);
    init();
    solve();
}


