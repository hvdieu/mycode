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
#define N 2001
#define BASE 1000000007

int n, p, q;
vector<char> correct[N];
char s[2][N];

int main() {
    freopen("input.txt", "r", stdin);
    scanf("%d%d%d\n", &n, &p, &q);
    For(i, 1, n) scanf("%c ", &s[0][i]); scanf("\n");
    For(i, 1, n) scanf("%c ", &s[1][i]); scanf("\n");
    For(i, 1, n) {
        string c;
        cin >> c;
        REP(j, 5) if (c[j] != '.') correct[j].pb('a' + j);
    }
    f[0][0] = 1;

}
