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
#define N 100001
#define inf 5000000000000000000ULL

const int a[3] = {1, 2, 2};
const string s[3] = {"a", "ab", "bb"};

ull f[N][2], n, m, g[N], len, ff[N][2];

void init() {
    g[0] = 1;
    g[1] = 1; g[2] = 4;
    f[1][0] = 1; f[2][0] = 1; f[2][1] = 1; f[2][2] = 1;
    ff[1][0] = 1; ff[2][0] = 2; ff[2][1] = 1;
    for(len = 3; ; len++) {
        f[len][0] = g[len-1] - g[len-2];
        f[len][1] = f[len][2] = (g[len-2] - g[len-3])*2;
        g[len] = f[len][0] + f[len][1] + f[len][2] + g[len-1];
        ff[len][0] = f[len][0] + f[len][1];
        ff[len][1] = f[len][2];
        if (g[len] >= inf) break;
    }
}

void cal(ull k) {
    int jj = 1;
	while (g[jj] < k) jj++;
    k -= g[jj-1];
    while (jj) {
        For(j, 0 ,1)
		if (k > ff[jj][j]) k -= ff[jj][j];
        else {
            if (!j) {
                For(ch, 0, 1) if (k > f[jj][ch]) k -= f[jj][ch];
                else {
                    cout << s[ch]; break;
                }
            } else cout << s[2];
            break;
        }
    }
}

int main() {
    freopen("love.in","r",stdin);
  //  freopen("love.out","w",stdout);
    init();
    while (1) {
        cin >> n >> m;
        if (!n) break;
        cal(n * (m-1) + 1); cout << ' ';
        cal(n * m); cout << endl;
    }
}
