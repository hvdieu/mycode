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
#define getbit(x, i) ((x >> (i)) & 1LL)
#define onbit(x, i) (x | (1LL << (i-1)))
#define offbit(x, i) (x & ~(1 << (i-1)))

const int N = 18;

int a[N], n;
int p[N*100000 + 1];

int main() {
   // freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> n;
    For(i, 0, n-1) cin >> a[i];
    p[0] = p[1] = 1;
    int ss = trunc(sqrt(1800000));
    for(int i = 2; i <= ss; i++) if (!p[i]) {
        for(int j = i*i; j <= 1800000; j = j + i) p[j] = 1;
    }
    int res = 0;
    for(int tt = 0; tt < two(n); tt++) {
        int sum = 0;
        for(int i = 0; i < n; i++) if (getbit(tt, i)) sum += a[i];
        if (!p[sum]) {
            res++;
            p[sum] = 1;
        }
    }
    cout << res;
}


