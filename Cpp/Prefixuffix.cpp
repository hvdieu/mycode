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
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 1000010
#define BASE 27
#define M 1000000007

int n, res, nex[N];
char s[N], tmp[N];
ll h[N], mu[N];

void KMP() {
    reset(nex, 0);
    nex[1] = 0;
    For(i, 2, n) {
        int j = nex[i-1];
        while (j && s[i] != s[j+1]) j = nex[j];
        if (s[i] == s[j+1]) nex[i] = j+1;
        else nex[i] = 0;
    }
}

ll get(int i, int j) {
    return (h[j] - (h[i-1]*mu[j-i+1]) % M + M) % M;
}

int main() {
    //ios_base::sync_with_stdio(false);
  //  freopen("prefixuffix.inp","r",stdin);
   // freopen("prefixuffix.out","w",stdout);
    scanf("%d\n", &n);
    scanf("%s", s+1);
    KMP();
    mu[0] = 1;
    For(i, 1, n) {
        h[i] = (h[i-1]*BASE + int(s[i]) - int('a') + 1) % M;
        mu[i] = (mu[i-1]*BASE) % M;
    }
    int j = nex[n];
    while (j) {
        if (j <= n / 2) {
            res = max(res, j);
            Rep(len, n/2 - j, 1)
            if (get(j+1, j+len) == get(n-j-len+1, n-j)) { res = max(res, j+len); break; }
        }
        j = nex[j];
    }
    cout << res;
}
