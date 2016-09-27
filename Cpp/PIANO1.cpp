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
#define N 110

char s[N];
int ntest, n;

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d\n", &ntest);
    For(test, 1, ntest) {
        scanf("%s\n", s+1);
        scanf("%d\n", &n);
        n *= 12;
        int x = 0, m = strlen(s+1);
        For(i, 1, m) if (s[i] == 'T') x += 2; else x++;
        int res = 0;
        For(i, 1, n) res += (n - i) / x;
        printf("%d\n", res);
    }
}
