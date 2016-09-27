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
#define N 11

struct rec {
    int x1, y1, x2, y2;
    rec(int a, int b, int c, int d) {
        x1 = a; y1 = b; x2 = c; y2 = d;
    }
};

int m, n, k, a[N], b[N], du;
bool flag;
vector<rec> l;

bool giao(rec a, rec b) {
    int x1 = max(a.x1, b.x1);
    int x2 = min(a.x2, b.x2);
    int y1 = max(a.y1, b.y1);
    int y2 = min(a.y2, b.y2);
    if (x1 <= x2 && y1 <= y2) return true;
    return false;
}

bool canplace(rec b) {
    For(i, 0, sz(l)-1) if (giao(l[i], b)) return false;
    return true;
}

void ql(int i) {
    if (i > k) {
        flag = true;
        return;
    }
    if (flag) return;
    For(ii, 1, m - a[i] + 1) For(jj, 1, n - b[i] + 1) {
        if (canplace(rec(ii, jj, ii+a[i]-1, jj+b[i]-1))) {
            l.pb(rec(ii, jj, ii+a[i]-1, jj+b[i]-1));
            ql(i+1);
            l.pop_back();
        }
    }
    if (flag) return;
    For(ii, 1, m - b[i] + 1) For(jj, 1, n - a[i] + 1) {
        if (canplace(rec(ii, jj, ii+b[i]-1, jj+a[i]-1))) {
            l.pb(rec(ii, jj, ii+b[i]-1, jj+a[i]-1));
            ql(i+1);
            l.pop_back();
        }
    }
}

bool check(int len) {
    For(i, 1, m - len + 1) For(j, 1, n - len + 1) {
        flag = false;
        l.clear();
        l.pb(rec(i, j, i+len-1, j+len-1));
        ql(1);
        if (flag) return true;
    }
    return false;
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("land.inp","r",stdin);
    freopen("land.out","w",stdout);
    cin >> m >> n >> k;
    du = m*n;
    For(i, 1, k) {
        cin >> a[i] >> b[i];
        du -= a[i]*b[i];
    }
    For(i, 1, k) For(j, i+1, k) if (a[i]*b[i] < a[j]*b[j]) {
        swap(a[i], a[j]); swap(b[i], b[j]);
    }
    int d = 1, c = min(int(sqrt(du)), min(m, n)), mid, ans = 0;
    while (d <= c) {
        int mid = (d + c) / 2;
        if (check(mid)) {
            ans = mid; d = mid + 1;
        } else c = mid - 1;
    }
    cout << ans * ans;
}
