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
#define MAX 5000
#define BASE 1000
#define N 100000
#define MONEY 4000
#define MMON 200

int n, m, p, s, t, a[N];

int main() {
    srand(time(NULL));
    //freopen("","r",stdin);
    freopen("toll2015.inp","w",stdout);
    n = BASE + (rand() % (MAX - BASE)) + 1;
    m = 5000;
    p = MONEY + (rand() % (MAX - MONEY)) + 1;
    s = (rand() % n) + 1;
    t = s;
    while (s == t) t = (rand() % n) + 1;
    printf("%d %d %d %d %d\n", n, m, s, t, p);
    For(i, 1, n) a[i] = i;
    For(i, 1, n) swap(a[i], a[(rand() % n)+1]);
    For(i, 2, n) {
        int j = (rand() % n) + 1;
        int c = rand() % MMON;
        printf("%d %d %d\n", a[i], a[j], c);
    }
    For(i, 1, m-n+1) {
        int u = (rand() % n) + 1;
        int v = u;
        while (u == v) v = (rand() % n) + 1;
        int c = rand() % MMON;
        printf("%d %d %d\n", u, v, c);
    }
}


