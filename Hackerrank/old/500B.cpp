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
#define N 310

int n, a[N], kq[N];
char s[N][N];
vector<int> ke[N];
bool was[N];
vector<int> qa, qb;

void dfs(int u) {
    was[u] = true;
    qa.pb(u); qb.pb(a[u]);
    For(j, 0, sz(ke[u])-1) {
        int v = ke[u][j];
        if (!was[v]) dfs(v);

    }
}

void solve() {
    For(i, 1, n) For(j, 1, n) if (s[i][j] == '1') ke[i].pb(j);
    For(i, 1, n) if (!was[i]) {
        qa.clear(); qb.clear();
        dfs(i);
        sort(all(qa)); sort(all(qb));
        For(j, 0, sz(qa)-1) kq[qa[j]] = qb[j];
    }
    For(i, 1, n) cout << kq[i] << ' ';
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d\n", &n);
    For(i, 1, n) scanf("%d\n", &a[i]);
    For(i, 1, n) scanf("%s\n", s[i]+1);
    solve();
}




