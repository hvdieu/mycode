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
#define N 20001

int n, c[N], deg[N], m, res, dd[N], id[N], cnt;
vector<int> ke[N];

bool cmp1(int i, int j) {
    return c[i] < c[j];
}

bool cmp2(int i, int j) {
    return deg[i] > deg[j];
}

bool cmp3(int i, int j) {
    return c[i] * deg[j] < c[j] * deg[i];
}

int cal() {
    cnt = 0;
    reset(dd, 0);
    For(i, 1, n) {
        int u = id[i];
        if (!dd[u]) {
            bool flag = false;
            For(j, 0, sz(ke[u])-1) {
                int v = ke[u][j];
                if (dd[v]) flag = true;
            }
            if (!flag) {
                int temp = c[u], uu = u;
              /*  For(j, 0, sz(ke[u])-1) {
                    int v = ke[u][j];
                    if (c[v] < temp) {
                        temp = c[v]; uu = v;
                    }
                } */
                uu = rand() % (sz(ke[u]) + 1);
                if (uu == sz(ke[u])) uu = u; else uu = ke[u][uu];
                cnt += c[uu]; dd[uu] = 1;
            }
        }
    }
    return cnt;
}

int cal2() {
    For(u, 1, n) if (!dd[u]) {
        bool flag = false;
        For(j, 0, sz(ke[u])-1) {
            int v = ke[u][j];
            if (dd[v]) flag = true;
        }
        if (!flag) {
            cnt += c[u]; dd[u] = 1;
        }
    }
    return cnt;
}

void solve() {
    res = 2000000000; int cnt = 0;
    For(i, 1, n) id[i] = i;
    res = min(res, cal());
    sort(id+1, id+1+n, cmp1);
    res = min(res, cal());
    sort(id+1, id+1+n, cmp2);
    res = min(res, cal());
    sort(id+1, id+1+n, cmp3);
    res = min(res, cal());
    For(cc, 1, 700) {
        For(i, 1, n) {
            int j = rand() % n + 1;
            swap(id[i], id[j]);
        }
        res = min(res, cal());
    }
  /*  For(cc, 1, 100) {
        reset(dd, 0);
        cnt = 0;
        For(i, 1, n / n) {
            int j = rand() % n + 1;
            if (!dd[j]) {
                dd[j] = 1; cnt += c[j];
            }
        }
        res = min(res, cal2());
    } */
    cout << res;
}

int main() {
    freopen("graph7.inp","r",stdin);
   // freopen("graph7.out","w",stdout);
    scanf("%d %d", &n, &m);
    For(i, 1, n) scanf("%d", &c[i]);
    For(i, 1, m) {
        int u, v; scanf("%d %d", &u, &v);
        ke[u].pb(v); ke[v].pb(u);
        deg[u]++; deg[v]++;
    }
    solve();
}
