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
#define N 1010
#define M 10010
#define eps 0.0000001
#define inf 1000000000000LL

int n, m, dem;
vector<int> ke[N], w[N];
double d[N];
int fr[N], step[N];
int q[N*N];
double res;

bool check(double x) {
    int bound;
    if (n <= 100 || m <= 1000) bound = n;
    else bound = 1;
    For(i, 1, bound) {
        For(u, 1, n) d[u] = 0;
        dem++; d[i] = 0; fr[i] = dem;
        reset(step, 0);
        int lef = 0, righ = 0; q[++righ] = i;
        while (lef < righ) {
            int u = q[++lef]; fr[u] = dem-1;
            if (step[u] == n) return true;
            For(j, 0, sz(ke[u])-1) {
                int v = ke[u][j];
                double cp = d[u] + double(w[u][j]) - x + eps;
                if (d[v] > cp) {
                    d[v] = cp;
                    if (fr[v] != dem) {
                        fr[v] = dem; q[++righ] = v;
                        step[v]++;
                    }
                }
            }
        }
    }
    return false;
}

void solve() {
    double dau = 0, cuoi = 1000000000000LL, mid, ans = -1;
    while (dau <= cuoi - eps) {
        mid = (dau + cuoi) / 2;
        if (check(mid)) {
            ans = mid; cuoi = mid - eps;
        } else dau = mid + eps;
    }
    if (ans >= 0) printf("%.2lf", ans);
    else printf("NO TOUR");
}

int main() {
    freopen("tour.inp","r",stdin);
    //freopen("tour.out","w",stdout);
    scanf("%d%d", &n, &m);
    For(i, 1, m) {
        int u, v, l;
        scanf("%d%d%d", &u, &v, &l);
        ke[u].pb(v); w[u].pb(l);
    }
    solve();
}
