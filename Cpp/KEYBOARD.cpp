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
#define N 71

int m, n, root, MAX, sl, con[N*N], sl2;
char s[N][N], kt[N*N], dom[N][N];
int lab[N][N], d[N*N], sum;
int cha[N*N];
vector<int> ke[N*N];
vector<int> l;

int id (int i, int j) {
    return (i-1)*n + j;
}

void connect(int i, int j, int u, int v) {
    if (!i || !j || !u || !v || i > m || j > n || u > m || v > n) return;
    int x = id(i, j);
    int y = id(u, v);
    ke[x].pb(y); ke[y].pb(x);
}

bool inlist(char c) {
    if (c == 'a' || c == 'e' || c == 'u' || c == 'i' || c == 'o' || c == 'y') return true;
    return false;
}

void init() {
    For(i, 1, m) For(j, 1, n) {
        kt[id(i, j)] = s[i][j];
        if (inlist(s[i][j])) sl++;
        if (dom[i][j] == '.') {
            root = id(i, j);
            continue;
        }
        if (!lab[i][j] && dom[i][j] == '-' && dom[i][j+1] == '-') {
        	lab[i][j] = lab[i][j+1] = 1;
			connect(i, j, i, j+2);
			connect(i, j-1, i, j+1);
		}
        if (!lab[i][j] && dom[i][j] == '|' && dom[i+1][j] == '|') lab[i][j] = lab[i+1][j] = 2, connect(i, j, i+2, j), connect(i-1, j, i+1, j);
    }
}

void dfs(int u) {
    if (inlist(kt[u])) sl2++, MAX = max(MAX, d[u]), con[u] = 1;
    FOR(v, ke[u]) if (!cha[*v]) {
        d[*v] = d[u] + 1;
        cha[*v] = u;
        dfs(*v);
        con[u] += con[*v];
    }
}

void visit(int u) {
    FOR(v, ke[u]) if (cha[*v] == u && con[*v]) {
        sum++;
        visit(*v);
    }
}

int main() {
    //ios_base::sync_with_stdio(false);
   // freopen("keyboard.inp","r",stdin);
   // freopen("keyboard.out","w",stdout);
    scanf("%d%d", &m, &n);
    For(i, 1, m) scanf("%s\n", s[i]+1);
    For(i, 1, m) scanf("%s\n", dom[i]+1);
    init();
    cha[root] = root;
    dfs(root);
    if (sl2 < sl) cout << "NIE"; else {
        visit(root);
        cout << sum*2 - MAX;
    }
}
