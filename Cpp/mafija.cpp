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
#define reset(f,x) memset(f,x,sizeof(f))
#define all(x) x.begin(), x.end()
#define N 500010

int n, a[N], deg[N], st[N], righ, lef, res, dem;
bool del[N];

void solve() {
    For(i, 1, n) if (!deg[i]) st[++righ] = i;
    while (lef < righ) {
        int u = st[++lef]; del[u] = true; res++;
        int v = a[u];
        if (!del[v]) {
            del[v] = true; deg[a[v]]--;
            if (!deg[a[v]]) st[++righ] = a[v];
        }
    }
    For(i, 1, n) if (!del[i]) dem++;
    cout << res + dem / 2;
}

int main() {
    freopen("mafija.inp","r",stdin);
    //freopen("mafija.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) {
        scanf("%d", &a[i]); deg[a[i]]++;
    }
    solve();
}


