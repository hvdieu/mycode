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
#define N 1000010
#define BASE 1000000007

int n, m, a[N], nex[N], nn;
char s[N];
int sum[N];
bool dd[N];

void init() {
    nex[1] = 0;
    For(i, 2, nn) {
        int j = nex[i-1];
        while (j && s[i] != s[j+1]) j = nex[j];
        if (s[i] == s[j+1]) nex[i] = j+1; else nex[i] = 0;
    }
    int j = nex[nn];
    while (j) {
        dd[j] = true;
        j = nex[j];
    }
}

void solve() {
    For(i, 1, m) {
        int l = a[i], r = a[i] + nn - 1;
        bool ok = true;
        if (l > a[i-1] + nn-1) ok = true;
        else if (dd[a[i-1] + nn - 1 - l + 1]) ok = true;
        else ok = false;
        if (!ok) {
            cout << 0; return;
        }
        sum[l]++; sum[r+1]--;
    }
    int dem = 0;
    ll res = 1;
    For(i, 1, n) {
        sum[i] += sum[i-1];
        if (sum[i] == 0) res = (res*26) % BASE;
    }
    cout << res;
}

int main() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d", &n, &m);
    scanf("%s\n", s+1);
    nn = strlen(s+1);
    For(i, 1, m) scanf("%d", a+i);
    a[0] = -nn;
    init();
    solve();
}
