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
#define N 100010

struct node {
    int a, b, c, d;
    node (int _a, int _b, int _c, int _d) {
        a = _a; b = _b; c = _c; d = _d;
    }
};

int n, f[2][4][4][4][4], dem[4];
queue<node> q[2];

int gmax(int &a, int b) {
    if (b > a) a = b;
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d\n", &n);
    reset(f[0], -1);
    f[0][0][0][0][0] = 0;
    q[0].push(node(0, 0, 0, 0));
    int t = 0;
    For(i, 1, n) {
        char ch; scanf("%c", &ch);
        int x;
        if (ch == 'M') x = 1; else if (ch == 'B') x = 2; else x = 3;
        reset(f[1-t], -1);
        while (!q[t].empty()) {
            int a = q[t].front().a, b = q[t].front().b, c = q[t].front().c, d = q[t].front().d;
            q[t].pop();
            int cp; cp = 0; dem[a] = dem[b] = dem[x] = 0;
            if (a && !dem[a]) cp++, dem[a]++;;
            if (b && !dem[b]) cp++, dem[b]++;
            if (x && !dem[x]) cp++, dem[x]++;
            if (f[1-t][b][x][c][d] == -1) q[1-t].push(node(b, x, c, d));
            gmax(f[1-t][b][x][c][d], f[t][a][b][c][d] + cp);
            cp = 0; dem[c] = dem[d] = dem[x] = 0;
            if (c && !dem[c]) cp++, dem[c]++;
            if (d && !dem[d]) cp++, dem[d]++;
            if (x && !dem[x]) cp++, dem[x]++;
            if (f[1-t][a][b][d][x] == -1) q[1-t].push(node(a, b, d, x));
            gmax(f[1-t][a][b][d][x], f[t][a][b][c][d] + cp);
        }
        t = 1 - t;
    }
    int res = 0;
    For(a, 0, 3) For(b, 0, 3) For(c, 0, 3) For(d, 0, 3) res = max(res, f[t][a][b][c][d]);
    cout << res;
}
