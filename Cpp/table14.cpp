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
#define N 1000001

int n, r, c;
ii p[N];

bool cmp(ii a, ii b) {
    if (a.fi != b.fi) return a.fi < b.fi;
    return a.se < b.se;
}

int main() {
    freopen("table14.inp","r",stdin);
    freopen("table14.out","w",stdout);
    cin >> n >> r >> c;
    r = (r - 1) * n + c;
    n *= n;
    p[1].se = 1;
    For(i, 2, n) {
        if (!p[i].fi) For(j, 1, n / i) p[i * j].fi++;
        p[i].se = i;
    }

    sort(p + 1, p + n + 1, cmp);
    cout << p[r].se;
}
