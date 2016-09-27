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
#define two(x) (1 << x)
#define bit(x, i) ( (x >> i) & 1)
#define N 21

const int n = 20;

char s[N][N];
int k, c[N], res, stt[N], cnt[N];

bool cmp(int a, int b) {
    return a > b;
}

void solve() {
    reset(stt, 0); reset(cnt, 0);
    For(j, 1, n) For(i, 1, n) if (s[i][j] == '#') {
        stt[j] |= two(i-1); cnt[j]++;
    }
    res = 0;
    For(tt, 0, two(20)-1) {
        int dem = n - __builtin_popcount(tt);
        if (dem >= k) continue;
        For(j, 1, n) {
            int x = stt[j] & tt;
            c[j] = cnt[j] - __builtin_popcount(x);
        }
        sort(c+1, c+n+1, cmp);
        int temp = 0;
        For(i, 1, min(k-dem, n)) temp += c[i];
        if (temp > res) {
        	res = temp;
        	//cout << res << ' ' << tt << endl;
		}
    }
    printf("%d\n", res);
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    while (1) {
        scanf("%d\n", &k);
        if (!k) break;
        For(i, 1, n) scanf("%s\n", s[i]+1);
        solve();
    }
}
