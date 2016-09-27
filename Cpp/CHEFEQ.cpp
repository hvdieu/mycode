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

int ntest, n, a[N];
int res;

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d", &n);
        For(i, 1, n) scanf("%d", a+i);
        sort(a+1, a+n+1);
        res = n+1;
        int i = 1;
        while (i <= n) {
            int j = i; while (j < n && a[j+1] == a[i]) j++;
            res = min(res, n-(j-i+1));
            i = j+1;
        }
        printf("%d\n", res);
    }
}
