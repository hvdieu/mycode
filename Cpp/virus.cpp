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
#define N 100010

int n, r1, r2, t[N], num[2][N], con[2][N], timer, a[N], p, vt[2][N];
ll res;
vector<int> ke[2][N];

void update(int i, int val) {
    while (i <= n) {
        t[i] += val;
        i += i & (-i);
    }
}

int get(int i) {
    int s = 0;
    while (i) {
        s += t[i];
        i -= i & (-i);
    }
    return s;
}

int sum(int i, int j) {
    return get(j) - get(i-1);
}

void dfs(int u, int t) {
    con[t][u] = 1; num[t][u] = ++timer; vt[t][timer] = u;
    For(j, 0, sz(ke[t][u]) - 1) {
        int v = ke[t][u][j];
        dfs(v, t);
        con[t][u] += con[t][v];
    }
}

bool cmp(int i,int j) {
    int l = num[0][i], r = num[0][i] + con[0][i] - 1;
    int L = num[0][j], R = num[0][j] + con[0][j] - 1;
    if ((l / p) != (L / p)) return (l / p) < (L / p);
    return r < R;
}

void solve() {
    timer = 0; dfs(r1,0);
    timer = 0; dfs(r2,1);
    For(i,1,n) a[i] = i;
    p = trunc(sqrt(n));
    sort(a+1, a+n+1, cmp);
    a[0] = -1;
    For(k,1,n) {
        int i = a[k];
        int j = a[k-1];
        int l, r, L, R;
        if (k == 1) l = r = n + 1;
        else {
            l = num[0][j]; r = num[0][j] + con[0][j] - 1;
        }

        L = num[0][i]; R = num[0][i] + con[0][i] - 1;

        if ((l / p) != (L / p)) {
            reset(t,0);
            For(jj,L,R) {
                j = vt[0][jj];
                update(num[1][j], 1);
            }
        } else {
            For(jj, r+1, R) {
                j = vt[0][jj];
                update(num[1][j], 1);
            }
            if (l < L)
                For(jj, l, L - 1) {
                    j = vt[0][jj];
                    update(num[1][j], -1);
                } else
                For(jj, L, l - 1) {
                    j = vt[0][jj];
                    update(num[1][j], 1);
                }
        }
        res += sum(num[1][i], num[1][i] + con[1][i] - 1) - 1;
    }
    cout << res;
}

int main() {
    freopen("virus.inp","r",stdin);
    freopen("virus.out","w",stdout);
    scanf("%d",&n);
    For(v,1,n) {
        int u;
        scanf("%d",&u);
        if (!u) r1 = v; else ke[0][u].pb(v);
    }

    For(v,1,n) {
        int u;
        scanf("%d",&u);
        if (!u) r2 = v; else ke[1][u].pb(v);
    }

    solve();
}
