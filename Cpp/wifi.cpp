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
#define M 30010
#define N 1010

struct cir {
    int x, y, R, B;
};

int n, m, k, Bmax, Cmax, s[];
cir Q[N];

void solve() {

}

int main() {
    freopen("wifi.inp","r",stdin);
    freopen("wifi.out","w",stdout);
    cin >> m; cin >> n; cin >> k;
    For(i, 1, k) scanf("%d %d %d %d", &q[i].x, &q[i].y, &q[i].R, &q[i].B);
    solve();
}
