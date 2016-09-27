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
#define N 310

int n, k, a[N], b[N];
int res;

int dis(int x, int y) {
    if (x <= y) return y-x;
    return y + k - x;
}

int main() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d", &n, &k); k++;
    For(i, 1, n) scanf("%d", a+i);
    For(i, 1, n) scanf("%d", b+i);
    res = 1000000000;
    For(xoay, 0, n-1) {
        For(i, 1, n) {
            int sum = 0;
            For(j, 1, n) sum += dis((a[j] + dis(a[i], b[i])) % k, b[j]);
            res = min(res, sum + xoay + dis(a[i], b[i]));
        }
        int tmp = a[n];
        Rep(i, n, 2) a[i] = a[i-1];
        a[1] = tmp;
    }
    cout << res;
}
