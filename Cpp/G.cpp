#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define REP(i, n) for(int i = 0; i < n; i++)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define x first
#define y second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define getbit(x, i) ((x >> (i-1)) & 1LL)
#define onbit(x, i) (x | (1LL << (i-1)))
#define offbit(x, i) (x & ~(1 << (i-1)))
#define N 51

int n, ntest, k;
ii p[N], a[2*N];

void operator -= (ii &A, ii &B) {
    A.x -= B.x;
    A.y -= B.y;
}

int ccw(ii O, ii A, ii B) {
    A -= O; B -= O;
    ll x = A.x*B.y - A.y*B.x;
    if (!x) return 0;
    else if (x < 0) return -1; else return 1;
}

bool cmp(ii A, ii B) {
    return (A.y > B.y) || ((A.y == B.y) && (A.x < B.x));
}

void solve() {
    sort(p+1, p+n+1, cmp);
    k = 0;
    For(i, 1, n) {
        while (k >= 2 && ccw(a[k-1], a[k], p[i]) >= 0) k--;
        a[++k] = p[i];
    }
    for(int i = n-1, t = k+1; i >= 1; i--) {
        while (k >= t && ccw(a[k-1], a[k], p[i]) >= 0) k--;
        a[++k] = p[i];
    }
    k--;
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        int t;
        scanf("%d%d", &t, &n);
        For(i, 1, n) scanf("%d%d", &p[i].x, &p[i].y);
        solve();
        printf("%d %d\n", t, k);
        For(i, 1, k) printf("%d %d\n", a[i].x, a[i].y);
    }
}


