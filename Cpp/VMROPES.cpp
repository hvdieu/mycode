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
#define BASE 1000000007
#define N 100010

int n, k, A, B, m;
int l[N], r[N];
int f[N], g[N];

int sum(int i, int j) {
	if (j < 0) return 0;
    i = max(i, 0);
    j = max(j, 0);
    if (!i) return g[j];
    return (g[j] - g[i-1] + BASE) % BASE;
}

bool check(int x) {
    int last = x % 10;
    while (x) {
        int ch = x % 10; x /= 10;
        if (abs(ch-last) > k) return false;
        last = ch;
    }
    return true;
}

int add(int &a, int b) {
    a += b;
    if (a >= BASE) a -= BASE;
}

int main() {

    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> n >> k >> A >> B;
    int last = -1;
    For(i, A, B) if (check(i)) {
        if (i - last > 1) {
            l[++m] = i; r[m] = i;
        } else r[m] = i;
        last = i;
    }
  //  cout << m << endl;
    f[0] = g[0]= 1;
    For(i, 1, n) {
        For(j, 1, m) add(f[i], sum(i-r[j], i-l[j]));
        g[i] = g[i-1];
        add(g[i], f[i]);
    }
    cout << f[n];
}


