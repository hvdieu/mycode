#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define N 100010
#define inf 1000000000

int n, m, d[N], jj[N];
vector<int> ke[N], w[N];
priority_queue< ii, vector<ii>, greater<ii> > heap;

void solve() {
    For(i, 1, n-1) d[i] = inf;
    For(i, 1, n) {
        sort(all(w[i])); jj[i] = sz(w[i])-1;
    }
    heap.push(ii(0, n));
    while (!heap.empty()) {
        int gt = heap.top().fi, u = heap.top().se;
        heap.pop();
        if (gt == d[u]) {
        For(j, 0, sz(ke[u])-1) {
            int v = ke[u][j];
            int x = d[u] + w[v][jj[v]]; jj[v]--;
            if (x < d[v]) {
                d[v] = x;
                heap.push(ii(d[v], v));
            }
        }
        }
    }
    cout << d[1];
}

int main() {
    freopen("ferries.inp","r",stdin);
   // freopen("ferries.out","w",stdout);
    scanf("%d%d", &n, &m);
    For(i, 1, m) {
        int u, v, l;
        scanf("%d%d%d", &u, &v, &l);
        ke[v].pb(u); w[u].pb(l);
    }
    solve();
}


