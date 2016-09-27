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

unsigned int random(int x) {
    return ((rand() << 16) | (rand())) % x;
}

set<ii> ff;
int n, m;

int main() {
   // freopen("","r",stdin);
    freopen("reform.inp","w",stdout);
    n = 20, m = 145;
    printf("%d %d\n", n, m);
    For(i, 1, m) {
        while (1) {
            int u = random(n) + 1, v = random(n) + 1;
            if (u > v) swap(u, v);
            if (u == v) continue;
            if (ff.find(ii(u, v)) == ff.end()) {
                printf("%d %d\n", u, v);
                ff.insert(ii(u, v));
                break;
            }
        }
    }
}
