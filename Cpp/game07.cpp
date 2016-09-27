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

int n, x[N], y[N];
bool dd[N];

double dis(int i, int j) {
    int xx = abs(x[i] - x[j]), yy = (y[i] - y[j]);
    return sqrt(xx * xx + yy * yy);
}

int main() {
    freopen("game07.inp","r",stdin);
    freopen("game07.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d %d", &x[i], &y[i]);
    reset(dd, true);
    int dem = n;
    while (dem > 1)
    For(i, 1, n) if (dd[i]) {
        double temp = 1000000000;
        int u = 0;
        For(j, 1, n) if (dd[j] && j != i && dis(i, j) < temp) {
            temp = dis(i, j); u = j;
        }
        dd[u] = false; dem--;
    }
    For(i, 1, n) if (dd[i]) cout << i;
}
