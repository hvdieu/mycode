#include <vector>
#include <algorithm>
#include <math.h>
#include <iostream>
#include <stdio.h>
#include <string.h>
#include <cmath>
#include <cstring>
#include <queue>
#include <stack>

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
#define two(i) (ll(1) << i)
#define N 1000010
#define BASE 1000000007

int n, k, ntest, pos[70], f[N], g[N], cnt[N], h[N];
char s[N];
bool dd[70];

int ord(char ch) {
    if (ch >= 'a' && ch <= 'z') return int(ch - 'a')+1;
    if (ch >= 'A' && ch <= 'Z') return 26 + int(ch - 'A')+1;
    return 52 + int(ch - '0') + 1;
}

void solve() {
	n = strlen(s+1);
    For(ch, 1, k) pos[ch] = n+1;
    reset(g, 0); g[0] = k;
    reset(cnt, 0); cnt[0] = k;
    reset(h, 0); h[n+1] = 1;
    f[n+1] = 0; int mi = 0;
    Rep(i, n, 0) {
        if (!cnt[mi]) mi++;
        f[i] = mi + 1;
        g[f[i]] = (g[f[i]] + g[mi]) % BASE;
        cnt[f[i]]++;
        h[i] = g[mi];
        if (i) {
            int ch = ord(s[i]);
            int j = pos[ch];
            cnt[f[j]]--; g[f[j]] = (ll(g[f[j]]) - h[j] + BASE) % BASE;
            pos[ch] = i;
        }
    }
    printf("%d %d\n", f[0], h[0]);
}

int main() {
    freopen("NOTSUB.INP","r",stdin);
    freopen("NOTSUB.OUT","w",stdout);
    scanf("%d\n", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d %s\n", &k, s+1);
        solve();
    }
}
