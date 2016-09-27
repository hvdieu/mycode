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
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 100010
#define M 10010

int n, m, p[M], a[N];
ll res, step;
int prime[M], pos[M];
vector<int> mu[M];

void sieve() {
    p[1] = 0;
    int ss = sqrt(10000);
    For(i, 2, ss) if (!p[i])
    for(int j = i*i; j <= 10000; j += i) p[j] = i;
    For(i, 2, 10000) if (!p[i]) {
        prime[++m] = i;
        pos[i] = m;
    }
    //cout << m;
}

void tach(int x) {
    while (p[x]) {
        int j = p[x], dem = 0;
        while (x % j == 0) {
            dem++; x /= j;
        }
        mu[pos[j]].pb(dem);
    }
    if (x > 1) mu[pos[x]].pb(1);
}

ll cal(int a, int n) {
    ll res = 1;
    while (n) {
        if (n & 1) res = res * a;
        n >>= 1;
        a = a * a;
    }
    return res;
}

void solve() {
    res = 1;
    For(i, 1, n) tach(a[i]);
    int mid = (n+1) / 2;
    For(i, 1, m) {
        sort(all(mu[i]));
        int k = sz(mu[i]);
        int pp;
        if (n-k >= mid) pp = 0;
        else pp = mu[i][mid-1-(n-k)];
        res *= cal(prime[i], pp);
        step += ll(pp) * (n-k);
        For(j, 0, sz(mu[i])-1) {
            int x = mu[i][j];
            step += abs(pp-x);
        }
    }
    cout << step << ' ' << res;
}

int main() {
    freopen("P.INP","r",stdin);
    freopen("P.OUT","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d", &a[i]);
    sieve();
    solve();
}




