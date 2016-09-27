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
#define N 36

int n, ntest;
vector<int> a;
map< vector<int>, ll> f[37][36];
map< vector<int>, ll>::iterator it;

ll cal(int i, int last) {
	if (i > n) {
		int MAX = 0;
		For(j, 0, n) MAX = max(MAX, a[j]);
		int res = 0;
		For(j, 0, n) if (MAX == a[j]) res++;
		return res;
	}
    it = f[i][last].find(a);
    if (it != f[i][last].end()) return it->se;
    ll res = 0;
    For(j, 0, n) if (last != j) {
        a[j]++;
        res += cal(i+1, j);
        a[j]--;
    }
    f[i][last][a] = res;
    return res;
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> ntest;
    For(test, 1, ntest) {
        cin >> n; n--;
        For(i, 0, n) For(j, 0, n+1) f[i][j].erase(all(f[i][j]));
        a.clear(); For(i, 0, n) a.pb(0);
        double res = cal(0, n+1);
        res /= (n+1); For(i, 1, n) res /= n;
        printf("%.6lf\n", res);
    }
}
