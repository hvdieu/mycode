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
#define N 1010

int n, a[N][N], st[N], top;
ll f[N], g[27];
int h[N];

int solve(int ch) {
    int res = 0;
    reset(h, 0);
    For(i, 1, n) {
        top = 0; reset(f, 0);
        For(j, 1, n) {
            if (a[i][j] < ch) h[j]++; else {
                h[j]++;
                if (h[j] >= 2) {
                    while (top && h[st[top]] >= h[j]) top--;
                    if (st[top]) {
                    	f[j] = f[st[top]];
                     	if (st[top]) f[j]++;
					}
                }
                h[j] = 0;
            }
            while (top && h[st[top]] >= h[j]) top--;
            st[++top] = j;
            res += f[j];
        }
    }
    return res;
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("ssdj.inp","r",stdin);
  //  freopen("ssdj.out","w",stdout);
    scanf("%d\n", &n);
    For(i, 1, n) {
        char c; For(j, 1, n) { scanf("%c", &c); a[i][j] = int(c) - int('a') + 1; }
        scanf("\n");
    }
    ll kq = 0;
    solve(2);
    Rep(i, 26, 1) {
        g[i] = solve(i);
       // For(j, i+1, 26) g[i] -= g[j];
        kq += g[i];
    }
    cout << kq << endl;
    For(i, 1, 26) cout << g[i] << ' ';
}
