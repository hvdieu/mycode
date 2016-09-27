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
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 2001

int n, d1[N][N], d2[N][N], h[N];
char s[N][N];

void solve() {
    For(i, 1, n) {
        int len = 0;
        For(j, 1, n) if (s[i][j] == '#') {
            len++; h[j]++;
            int x = d1[i-1][j-1];
            if (min(len,h[j]) > x + 1) d1[i][j] = x + 2;
            else d1[i][j] = min(len, h[j]);
        } else len = h[j] = d1[i][j] = 0;
    }

    reset(h, 0);
    For(i, 1, n) {
        int len = 0;
        Rep(j, n, 1) if (s[i][j] == '#') {
            len++; h[j]++;
            int x = d2[i-1][j+1];
            if (min(len, h[j]) > x + 1) d2[i][j] = x + 2;
            else d2[i][j] = min(len, h[j]);
        } else len = h[j] = d2[i][j] = 0;
    }
    ll res = 0;
    For(i, 1, n)
		For(j, 1, n)
		res += min(d1[i][j], d2[i][j]);
    cout << res;
}

int main() {
    freopen("triangles.inp","r",stdin);
    //freopen("triangles.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%s\n", (s[i] + 1));
    solve();
}
