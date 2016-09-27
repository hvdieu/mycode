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
#define N 100010

int n, ntest, a[N], res, L, s;

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d%d%d", &s, &n, &L);
        For(i, 1, n) scanf("%d", &a[i]);
        sort(a+1, a+n+1);
        int u, v; u = v = 0;
        res = 0;
        For(i, 1, n) {
            int len = s - a[i];
            while (v < i-1 && a[i] - a[v+1] > L) v++;
            if (a[i-1] > L && !u) u = i-1;
            if (len > L) res += i-1;
            else {
                if (u) res += i-1-u+1;
                if (v) res += v;
                if (u && v && v >= u) res -= v-u+1;
            }
        }
        cout << res << endl;
    }
}
