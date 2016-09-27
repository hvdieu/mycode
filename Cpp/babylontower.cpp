#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 201

struct triple {
    int x, y, z;
};

bool operator < (triple a, triple b) { return a.x < b.x; }

int a[N][3];
int n, f[N][3][3];

int cal(int i, int t1, int t2) {
    if (f[i][t1][t2] >= 0) return f[i][t1][t2];
    int res = 0, cp; For(j, 0, 2) if (j != t1 && j != t2) cp = a[i][j];
    For(j, 1, n) For(t3, 0, 2) For(t4, 0, 2) if (t3 != t4)
    if (a[j][t3] < a[i][t1] && a[j][t4] < a[i][t2]) res = max(res, cal(j, t3, t4) + cp);
    f[i][t1][t2] = max(res, cp);
    return f[i][t1][t2];
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    while (1) {
        cin >> n;
        if (!n) break;
        For(i, 1, n) cin >> a[i][0] >> a[i][1] >> a[i][2];
        int res = 0;
        reset(f, -1);
        For(i, 1, n) {
            For(t1, 0, 2) For(t2, 0, 2) if (t1 != t2) res = max(res, cal(i, t1, t2));
        }
        cout << res << endl;
    }
}
