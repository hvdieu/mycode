#include <stdio.h>
#include <iostream>
#include <algorithm>
#include <math.h>
#include <vector>
#include <string>
#include <cstring>
#include <map>
#include <set>
#include <queue>
#include <stack>

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
#define N 110
#define inf 1000000

int n, m, d[N];
vector<int> ke[N], w[N];
bool fr[N];
queue<int> q;

int bfs(int s, int t) {
    reset(d, 0x7f);
    d[s] = 0;
    reset(fr, true);
    q.push(s);
    while (!q.empty()) {
        int u = q.front(); q.pop(); fr[u] = true;
        For(j, 0, sz(ke[u])-1) {
            int v = ke[u][j];
            if (d[v] > d[u] + w[u][j]) {
                d[v] = d[u] + w[u][j];
                if (fr[v]) {
                    q.push(v); fr[v] = false;
                }
            }
        }
    }
    return d[t];
}

void solve() {
    For(i, 0, n-1) {
        ke[i].pb(i+1); w[i].pb(1);
    }
    For(i, 1, n) {
        ke[i].pb(i-1); w[i].pb(0);
    }

    int lmax = bfs(0, n);
    int lmin = -bfs(n, 0);
    cout << lmin << ' ' << lmax;
}

int main() {
   // freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d", &n, &m);
    For(i, 1, m) {
        int u, v, c; scanf("%d%d%d", &u, &v, &c);
        u--;
        ke[u].pb(v); w[u].pb(c);
        ke[v].pb(u); w[v].pb(-c);
    }
    solve();
}




