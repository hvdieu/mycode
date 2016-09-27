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

int n, ntest, k, xmax, ymax, xmin, ymin;
ii p[N], a[2*N];
bool fr[N];
int sy[500], sl[500], sr[500], top;

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

bool check (ii O) {
    For(i, 1, n) if (ccw(p[i], O, p[i+1]) <= 0) return false;
    return true;
}

void solve() {
    top = 0;
    p[n+1] = p[1];
    Rep(y, ymax, ymin) {
        int l = xmax+1, r = xmin-1;
        bool ok = false;
        For(x, xmin, xmax) if (check(ii(x, y))) {
            ok = true; l = min(l, x); r = max(r, x);
        }
        if (ok) {
            sy[++top] = y; sl[top] = l; sr[top] = r;
        }
    }
}


int main() {
  //  freopen("input.txt","r",stdin);
  //  freopen("output.txt","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        int t;
        scanf("%d%d", &t, &n);
        xmax = ymax = -1000;
        xmin = ymin = 1000;
        For(i, 1, n) {
            scanf("%d%d", &p[i].x, &p[i].y);
            xmax = max(xmax, p[i].x); xmin = min(xmin, p[i].x);
            ymax = max(ymax, p[i].y); ymin = min(ymin, p[i].y);
        }
        solve();
        printf("%d %d\n", t, top);
        For(i, 1, top) printf("%d %d %d\n", sy[i], sl[i], sr[i]);
    }
}


