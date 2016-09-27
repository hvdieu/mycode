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
#define bit(x, i) ( (x >> i) & 1 )
#define onbit(x, i) ( x | (1 << i ) )
#define N 100010
#define p 32763

int n, L, R, cnt;
ull h[N], mu[N];
char s[N];
vector<ull> Q;

void init() {
    mu[0] = 1;
    For(i, 1, n) {
        h[i] = h[i-1] * p + int(s[i]) - int('a');
        mu[i] = mu[i-1] * p;
    }
}

ull get(int i, int j) {
    return h[j] - h[i-1] * mu[j-i+1];
}

int cal(int len) {
    Q.clear();
    int dem = 1;
    int res = 1;
    For(i, 1, n-len+1) Q.pb(get(i, i+len-1));
    sort(all(Q));
    For(i, 1, sz(Q)-1) {
        if (Q[i] == Q[i-1]) dem++;
        else dem = 1;
        res = max(res, dem);
    }
    return res;
}

void solve() {
    cnt = cal(L);
    int d = L, c = R, mid, ans = 0;
    while (d <= c) {
        int mid = (d + c) / 2;
        int x = cal(mid);
        if (x == cnt) {
            ans = mid; d = mid + 1;
        } else c = mid - 1;
    }
    cout << cnt << ' ' << ans;
}

int main() {
    freopen("loopstr.inp","r",stdin);
    freopen("loopstr.out","w",stdout);
    scanf("%d%d\n", &L, &R);
    scanf("%s\n", s+1);
    n = strlen(s+1);
    init();
    solve();
}
