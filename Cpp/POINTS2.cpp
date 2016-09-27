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
#define N 160

int ntest, n, m, d[2];
vector<int> ke[N];
int cha[N];
int sd[N], sc[N], C;
int fr[N];
int f[N][N][2];
int x[N*N], y[N*N], cnt;

void dfs(int u) {
    sd[cnt]++; fr[u] = cnt;
    For(j, 0, sz(ke[u])-1) {
        int v = ke[u][j];
        if (!fr[v]) dfs(v);
    }
}

int C2(int n) {
    return (n*(n-1))/2;
}

int cal(int a, int b, int c) {
    if (f[a][b][c] >= 0) return f[a][b][c];
    if (a + b == 1) return 0;
    int res = 0;
    if (a >= 2) if (!cal(a-1, b, 1-c)) res = 1;
    if (b >= 2) if (!cal(a+1, b-2, c)) res = 1;
    if (a && b) if (!cal(a-1, b, 1-c)) res = 1;
    if (c && !cal(a, b, 0)) res = 1;
    f[a][b][c] = res;
    return res;
}

int main() {
    ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> ntest;
    For(test, 1, ntest) {
        cin >> n >> m;
        For(i, 1, n) ke[i].clear(); d[0] = d[1] = 0;
        C = 0;
        For(i, 1, m) {
            int u, v; cin >> u >> v;
            ke[u].pb(v); ke[v].pb(u);
            x[i] = u; y[i] = v;
        }
        reset(sd, 0); reset(sc, 0);
        reset(fr, 0); cnt = 0;
        For(i, 1, n) if (!fr[i]) {
            cnt++;
            dfs(i);
            d[sd[cnt] % 2]++;
        }
        For(i, 1, m) sc[fr[x[i]]]++;
        For(i, 1, cnt) C += C2(sd[i]) - sc[i];
        reset(f, -1);
       // cout << d[0] << ' ' << d[1] << ' ' << C << endl;
        if (cal(d[0], d[1], C % 2)) cout << "Theodor" << endl;
        else cout << "Maxim" << endl;
    }
}
