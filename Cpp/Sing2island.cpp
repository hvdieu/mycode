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
#define N 90

const int h[4] = {-1, 0, 1, 0};
const int c[4] = {0, 1, 0, -1};

char s[N][N];
int m, n, test;
int islands, bridges, buses;
bool fr[N][N];

void dfs1(int i, int j) {
    fr[i][j] = false;
    REP(k, 4) {
        int u = i + h[k], v = j + c[k];
        if (u && v && u <= m && v <= n && fr[u][v])
            if (s[u][v] == '#' || s[u][v] == 'X') dfs1(u, v);
    }
}

void dfs2(int i, int j) {
    fr[i][j] = false;
        REP(k, 4) {
            int u = i + h[k], v = j + c[k];
            if (u && v && u <= m && v <= n && fr[u][v] && s[u][v] != '.')
                if (s[u][v] == '#' || s[u][v] == 'X') dfs2(u, v);
                else if (s[u][v] == 'B' && (s[i][j] == 'X' || s[i][j] == 'B')) dfs2(u, v);
        }
}


void solve() {
    islands = bridges = buses = 0;
    reset(fr, true);
    For(i, 1, m) For(j, 1, n) if (fr[i][j] && s[i][j] != 'B' && s[i][j] != '.') {
        dfs1(i, j);
        //cout << i << ' ' << j << endl;
        islands++;
    }
    reset(fr, true);
    For(i, 1, m) For(j, 1, n) if (fr[i][j] && s[i][j] != '.' && s[i][j] != 'B') {
        dfs2(i, j);
        buses++;
    }
    For(i, 1, m) For(j, 1, n) if (s[i][j] == 'X') {
        REP(k, 4) {
            int u = i + h[k], v = j + c[k];
            if (u && v && u <= m && v <= n && s[u][v] == 'B') bridges++;
        }
    }
    printf("islands: %d\nbridges: %d\nbuses needed: %d", islands, bridges / 2, buses);
}

int main() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    while (1) {
        m = 1;
        reset(s, 0);
        if (gets(s[1]+1) == NULL) return 0;
        if (test) printf("\n\n");
        printf("Map %d\n", ++test);
        while (1) {
            gets(s[++m]+1);
            if (strlen(s[m]+1) == 0) {
            	m--; break;
			}
        }
        n = strlen(s[1]+1);
        //For(i, 1, m) cout << s[i] + 1 << endl;
        solve();
    }
}


