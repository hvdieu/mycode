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

int n, m, k, Bmax, Cmax, s[M];
cir Q[N];

int sqr(int x) {
    return x * x;
}

void solve() {
    For(x, 1, n) {
        reset(s, 0);
        For(i, 1, k) if (abs(x - Q[i].x) <= Q[i].R) {
            int RR = sqr(Q[i].R) - sqr(x - Q[i].x);
            int x1 = max(1, int(ceil(Q[i].y - sqrt(RR))));
            int x2 = min(m, int(floor(Q[i].y + sqrt(RR))));
            if (x1 <= m && x2 >= 0) {
                s[x1] += Q[i].B; s[x2+1] -= Q[i].B;
            }
        }
        For(y, 1, m) {
            s[y] += s[y-1];
            if (s[y] > Bmax) {
                Bmax = s[y]; Cmax = 1;
            } else if (s[y] == Bmax) Cmax++;
        }
    }
    cout << Bmax << endl; cout << Cmax;
}

int main() {
    freopen("wireless.inp","r",stdin);
    freopen("wireless.out","w",stdout);
    cin >> m; cin >> n; cin >> k;
    For(i, 1, k) scanf("%d %d %d %d", &Q[i].x, &Q[i].y, &Q[i].R, &Q[i].B);
    solve();
}
