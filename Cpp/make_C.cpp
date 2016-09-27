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
#define MAX 2
int main() {
    srand(time(0));
   // freopen("","r",stdin);
    freopen("input.txt","w",stdout);
    int n = 1000;
    For(i, 1, n) cout << char(rand() % MAX + 'a'); cout << endl;
    int q = 1000; cout << q << endl;
    For(qq, 1, q) {
        int i = rand() % n + 1, j = i + rand() % (n - i + 1);
        int u = rand() % n + 1, v = u + rand() % (n - u + 1);
        cout << i << ' ' << j << ' ' << u << ' ' << v << endl;
    }
}


