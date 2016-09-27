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
#define N 5000

int n, a[N], MAX, res, f[N];

void dfs(int i) {
    if (i*2 <= n) {
        dfs(i*2);
        f[i] = max(f[i], f[i*2] + a[i*2]);
    }
    if (i*2+1 <= n) {
        dfs(i*2+1);
        f[i] = max(f[i], f[i*2+1] + a[i*2+1]);
    }
}

void visit(int i, int s) {
    if (i*2 <= n) {
        int x = MAX - s - f[i*2] - a[i*2];
        res += x;
        visit(i*2, s + a[i*2] + x);
    }
    if (i*2+1 <= n) {
        int x = MAX - s - f[i*2+1] - a[i*2+1];
        res += x;
        visit(i*2+1, s + a[i*2+1] + x);
    }
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> n; n = two(n+1) - 1;
    For(i, 2, n) cin >> a[i];
    dfs(1);
    MAX = f[1];
    visit(1, 0);
    cout << res;
}
