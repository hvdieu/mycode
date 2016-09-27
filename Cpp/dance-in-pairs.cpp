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
#define getbit(x, i) ((x >> (i-1)) & 1LL)
#define onbit(x, i) (x | (1LL << (i-1)))
#define offbit(x, i) (x & ~(1 << (i-1)))
#define N 100010

int n, k;
int a[N], b[N];

int main() {
   // freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d", &n, &k);
    int res = 0;
    For(i, 1, n) scanf("%d", a+i);
    For(i, 1, n) scanf("%d", b+i);
    sort(a+1, a+n+1); sort(b+1, b+n+1);
    int i = 1, j = 1;
    while (i <= n && j <= n) {
        if (abs(a[i] - b[j]) <= k) {
            res++; i++; j++;
        } else if (a[i] - b[j] > k) j++;
        else i++;
    }
    cout << res;
}


