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
#define N 16
#define T 65536
#define inf 1000000000

int n, a[N], b[N], d[N][T], qx[N*T], qy[N*T], lef, righ, qi[N*T], qj[N*T], bot, top;
bool fr[N][T];
vector<int> ke[N];
void push(int i, int tt) {
    if (fr[i][tt]) {
        fr[i][tt] = false;
        qx[++righ] = i; qy[righ] = tt;
    }
}

int bat(int x, int i) {
    return x | (1 << i);
}

int tat(int x, int i) {
    return x & (~(1 << i));
}

int bit(int x, int i) {
    return (x >> i) & 1;
}

void push1(int i, int tt) {
    if (fr[i][tt]) {
        qi[++top] = i; qj[top] = tt;
        fr[i][tt] = false;
    }
}

void update(int i, int tt) {
        int t1;
        For(jj, 0, sz(ke[i]) - 1) {
            int j = ke[i][jj];
            if (bit(tt, j)) t1 = tat(tt, j);
            else t1 = bat(tt, j);
            if (d[i][t1] > d[i][tt] && bit(t1, i)) {
                d[i][t1] = d[i][tt]; push(i, t1);
            }
        }
        For(j, 0, n - 1) if (i != j && bit(tt, j)) {
            if (d[j][tt] > d[i][tt] + 1) {
                d[j][tt] = d[i][tt] + 1;
                push1(j, tt);
            }
        }
}

void solve() {
    int TT = (1 << n) - 1;
    For(i, 0, n-1) For(tt, 0, TT) d[i][tt] = inf;
    reset(fr, true);
    d[0][1] = 0; push(0, 1);
    while (1) {
        if (lef == righ && bot == top) break;
        if (lef < righ) {
            int i = qx[++lef], tt = qy[lef];
            update(i, tt);
        } else if (bot < top) {
            int i = qi[++bot], tt = qj[bot];
            update(i, tt);
        }
    }
    int res = d[n-1][bat(0,n-1)];
    if (res == inf) cout << -1; else cout << res;
}

int main() {
    freopen("switch.inp","r",stdin);
   // freopen("switch.out","w",stdout);
    int j;
    while (scanf("%d", &j) != -1) ke[j].pb(n++);
    solve();
}
