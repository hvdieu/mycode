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
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 1000010

char s[N];
int n, BASE;
int f[N][5][3][3];

int cal(int i, int cur, int mi, int ma) {
    if (abs(cur - mi) > 2 || abs(cur - ma) > 2 || cur > 2 || cur < -2) return 0;
    if (i > n) {
    	return 1;
	}
    if (f[i][cur+2][mi+2][ma] != -1) return f[i][cur+2][mi+2][ma];
    int res = 0;
    res += cal(i+1, cur+1, mi, max(ma, cur+1));
    res += cal(i+1, cur-1, min(mi, cur-1), ma);
    if (res >= BASE) res -= BASE;
    f[i][cur+2][mi+2][ma] = res;
    return res;
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d\n", &n);
    scanf("%d\n", &BASE);
    scanf("%s\n", s+1);
    reset(f, -1);
    int res = 0;
    int cur = 0, mi = 0, ma = 0;
    For(i, 1, n) {
        if (s[i] == 'P') {
        	res += cal(i+1, cur+1, min(mi, cur+1), max(ma, cur+1));
		}
        if (s[i] == 'L') cur++; else cur--;
        if (res >= BASE) res -= BASE;
        mi = min(mi, cur);
        ma = max(ma, cur);
    }
    res++; if (res >= BASE) res -= BASE;
    cout << res;
}
