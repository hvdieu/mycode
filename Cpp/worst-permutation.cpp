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
const int N = 100010;

int n, k, a[N], pos[N];

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    scanf("%d%d", &n, &k);
    For(i, 1, n) {
        scanf("%d", a+i);
        pos[a[i]] = i;
    }
    int x = n;
    For(i, 1, n) {
        if (!k) break;
        int j = pos[x];
        if (j != i) {
            pos[a[i]] = j; pos[x] = i; k--;
            swap(a[i], a[j]);
        }
        x--;
    }
    For(i, 1, n) printf("%d ", a[i]);
}
