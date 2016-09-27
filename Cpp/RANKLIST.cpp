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

int n, ntest, a[N];
ll s, sum;

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> ntest;
    For(test, 1, ntest) {
        cin >> n >> s;
        int x = n;
        while (ll(x)*(x+1)/2 > s) x--;
        ll du = s - ll(x)*(x+1)/2;
        int vt = n - x;
        int res = vt;
        while (du < vt) {
            du += x-1; x--;
            res++;
        }
        cout << res << endl;
    }
}
