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
#define N 60

const int h[9] = { -1, -1, -1, 0, 0, 0, 1, 1, 1 };
const int c[9] = { -1, 0, 1, -1, 0, 1, -1, 0, 1 };

struct triple {
    int i, j, t;
    triple(int a, int b, int c) {
        t = a; i = b; j = c;
    }
};

int m, n, dem, uu, vv;
char s[N][N][N];
int d[N][N][N];
queue<triple> q;

void init() {
    For(t, 1, n-1) {
        For(i, 1, m) {
            if (i % 2 == 1) {
                For(j, 2, n) s[t][i][j] = s[t-1][i][j-1];
                s[t][i][1] = s[t-1][i][n];
            } else {
                For(j, 1, n-1) s[t][i][j] = s[t-1][i][j+1];
                s[t][i][n] = s[t-1][i][1];
            }
        }
    }
    reset(d, 0x7f); uu = vv = 0;
    For(i, 1, m) For(j, 1, n) if (s[0][i][j] == 'B') {
        d[0][i][j] = 0;
        q.push(triple(0, i, j));
    } else if (s[0][i][j] == 'T') {
        uu = i; vv = j;
    }
}

void bfs() {

    while (!q.empty()) {
        int i = q.front().i, j = q.front().j, t = q.front().t;
        q.pop();
        if (i == uu && j == vv) { printf("%d", d[t][i][j]); return; }
        For(k, 0, 8) {
            int u = i+h[k], v = j+c[k];
            if (u && v && u <= m && v <= n && s[(t+1)%n][u][v] != 'X' && d[(t+1)%n][u][v] > d[t][i][j]+1) {
                d[(t+1)%n][u][v] = d[t][i][j]+1;
                q.push(triple((t+1)%n, u, v));
            }
        }
    }
    printf("Impossible"); return;
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d\n", &m, &n); m += 2;
    For(i, 1, m) scanf("%s\n", s[0][i]+1);
    init();
    bfs();
}
