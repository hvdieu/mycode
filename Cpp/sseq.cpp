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
#define ld long double
#define pb push_back
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 1010
#define inf 1000000000

int m, a[N][N], n, vt[N], kq[N*N], deg[N*N];
bool dd[1000010];
vector<int> sau[N*N];
priority_queue< int, vector<int>, greater<int> > heap;

void solve() {
    For(i, 1, m) For(j, 1, a[i][0]) {
        dd[a[i][j]] = true;
        if (j < a[i][0]) {
            deg[a[i][j+1]]++;
            sau[a[i][j]].pb(a[i][j+1]);
        }
    }
    For(i, 1, 1000000) if (dd[i] && !deg[i]) heap.push(i);
    while (!heap.empty()) {
        int x = heap.top(); heap.pop();
        kq[++n] = x;
        For(j, 0, sz(sau[x])-1) {
            int y = sau[x][j];
            deg[y]--; if (!deg[y]) heap.push(y);
        }
    }
    For(i, 1, n) printf("%d ", kq[i]);
}

int main() {
    freopen("sseq.inp","r",stdin);
    freopen("sseq.out","w",stdout);
    scanf("%d", &m);
    For(i, 1, m) {
        scanf("%d", &a[i][0]);
        For(j, 1, a[i][0]) scanf("%d", &a[i][j]);
    }
    solve();
}
