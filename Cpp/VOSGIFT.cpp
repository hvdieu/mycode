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
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 110
#define K 4000010
#define inf 1000000000

int n, a[N], sum;
int f[2][K];

int id(int x) {
    return x + sum;
}

int main() {
    //freopen("VOSGIFT.INP","r",stdin);
    //freopen("VOSGIFT.OUT","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) {
        scanf("%d", &a[i]); sum += a[i];
    }
    For(x, -sum, sum) f[0][id(x)] = -inf;
    f[0][id(0)] = 0;
    int tt = 0;
    For(i, 1, n) {
        tt = 1 - tt;
        int y = a[i];
        For(x, -sum, sum) {
            int u = id(x);
            f[tt][u] = f[1-tt][u];
            for(int s = -y; s <= y; s += 2*y) {
                int v = id(s+x);
                if (s+x >= -sum && s+x <= sum && f[1-tt][v] >= 0)
                    if (f[tt][u] < f[1-tt][v] + y) f[tt][u] = f[1-tt][v] + y;
            }
        }
    }
    printf("%d", f[tt][id(0)] / 2);
}




