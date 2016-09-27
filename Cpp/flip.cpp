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
#define ld long double
#define pb push_back
#define all(x) x.begin(), x.end()
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 1010
#define BASE 1000000007
int n, k, ntest;
int f[N][N], gt[N];
char s[N];

void solve() {
    reset(f, 0);
    f[0][0] = 1;
    For(i, 1, n) {
        int bound = 0; if (s[i] == '1') bound = 1;
        for(int j = bound; j <= k; j += 2)
    }
}

int main() {
    freopen("flip.inp","r",stdin);
    freopen("flip.out","w",stdout);
    scanf("%d\n", &ntest);
    gt[0] = 1;
    For(i, 1, n) gt[i] = (ll(gt[i-1]) * i) % BASE;
    while (ntest) {
        ntest--;
        scanf("%d%d\n", &n, &k);
        scanf("%s\n", s+1);
        solve();
    }
}
