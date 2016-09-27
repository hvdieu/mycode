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
#define N 72

const int h[4] = { -1, 0, 1, 0 };
const int c[4] = { 0, 1, 0, -1 };

int m, n; a[N][N];
vector<int> ke[N*N], cap[N*N], f[N*N];

int id (int i, int j) {
    return i*(n-1) + j;
}

int main() {
    freopen("input.txt","r",stdin);
    freopen("output.txt","w",stdout);
    scanf("%d%d", &m, &n);
    For(i, 1, m) For(j, 1, n) scanf("%d", &a[i][j]);
    For(i, 1, m) For(j, 1, n) if (a[i][j]) {
        cnt(0, id(i, j), a[i][j]);
        int u = i + h[k], v = j + c[k];
        if (a[u][v]) cnt(id(i, j), id(u, v));
    }
}
