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

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    int ntest;
    ll m, n;
    cin >> ntest;
    For(test, 1, ntest) {
        cin >> m >> n;
        if ((m*n) % 3 == 0) printf("YES\n");
        else if (m == 2) printf("NO %d\n", (n % 3) * 2);
        else if (n == 2) printf("NO %d\n", (m % 3) * 2);
        else printf("NO %d\n", (m*n) % 3);
    }
}
