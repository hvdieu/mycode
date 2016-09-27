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
#define N 10010

int a[N], b[N];
int n, res;

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
   // freopen("output.txt","w",stdout);
    scanf("%d\n", &n);
    char c;
    For(i, 1, n) {
        scanf("%c", &c); if (c == '1') a[i] = 1;
    }
    scanf("\n");
    For(i, 1, n) {
        scanf("%c", &c); if (c == '1') b[i] = 1;
    }
    For(i, 1, n) {
        if (a[i] != a[i-1] && a[i] != a[i+1] && b[i] != b[i-1] && b[i] != b[i+1]) {
            a[i] = 1 - a[i]; b[i] = 1 - b[i];
            res++;
        }
    }
    For(i, 1, n) {
        if (a[i] && !a[i-1]) res++;
        if (b[i] && !b[i-1]) res++;
    }
    cout << res;
}
