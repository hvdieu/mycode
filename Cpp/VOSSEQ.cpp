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
#define N 1000010

int n, m, k, last, deg[N], ma;
priority_queue< int, vector<int>, greater<int> > heap;
vector<int> ke[N];

int main() {
    //freopen("vosseq.inp","r",stdin);
    //freopen("vosseq.out","w",stdout);
    scanf("%d", &m);
    For(i, 1, m) {
        scanf("%d", &n); int x;
        For(i, 1, n) {
            scanf("%d", &x);
            ma = max(ma, x);
            if (i > 1) {
                ke[last].pb(x); deg[x]++;
            }
            last = x;
        }
    }
    For(i, 1, ma) if (!deg[i]) heap.push(i);
    while (!heap.empty()) {
        int u = heap.top(); heap.pop();
        printf("%d ", u);
        For(j, 0, sz(ke[u])-1) {
            int v = ke[u][j];
            deg[v]--;
            if (!deg[v]) heap.push(v);
        }
    }
}




