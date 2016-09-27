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
#define N 200010

int ntest, n, a[N], k, st[N], top, lef[N], righ[N];
ll res;

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d%d", &n, &k);
        For(i, 1, n) scanf("%d", a+i);
        res = 0;
        top = 0; st[0] = 0;
        For(i, 1, n) {
            while (top && a[i] > a[st[top]]) top--;
            lef[i] = i - st[top]; st[++top] = i;
        }
        top = 0; st[0] = n+1;
        Rep(i, n, 1) {
            while (top && a[i] > a[st[top]]) top--;
            righ[i] = st[top] - i; st[++top] = i;
        }
        For(i, 1, n) if (a[i] > k) res += ll(lef[i])*righ[i];
        printf("%lld\n", res);
    }
}
