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
#define N 10010

int n, a[2][N], res, b[N], c[2][2], dem[N];
int fr[2][N];
bool dd[N];
vector<ii> ke[N];

void dfs(int tt, int i) {
    fr[tt][i] = res;
    if (tt) dem[res]++; // tăng số cột phải thay đổi trong 1 miền.
    int sl = 0;
    int x = a[1-tt][i];
    For(jj, 0 ,sz(ke[x]) - 1) {
        int t = ke[x][jj].fi, j = ke[x][jj].se;
        if (!fr[t][j] && i != j) dfs(t, j);
    }
}

void solve() {
    For(i, 1, n) if (a[0][i] != a[1][i]) { // xây đồ thị, nối số với hàng và cột tương ứng.
        ke[a[0][i]].pb(ii(0,i));
        ke[a[1][i]].pb(ii(1,i));
    }
    reset(fr, 0);
    For(i, 1, n) if (a[0][i] != a[1][i]) For(tt, 0, 1) { // tính số miền
        if (!fr[tt][i]) {
            res++; // res = số miền.
            dfs(tt, i); // tt : giữ nguyên/thay đổi, i : cột.
        }
    }
    res = 1 << (res / 2); // kq = 1 shl (số miền / 2) = 2^(số miền).
    cout << res << ' ';
    res = 0;
    reset(dd, true);
    For(i, 1, n) if (a[0][i] != a[1][i] && dd[fr[0][i]] && dd[fr[1][i]]) { // nếu 1 cột chưa được đánh dấu đã tính vào kq
        int tt;
        if (dem[fr[0][i]] < dem[fr[1][i]]) tt = 0; else tt = 1; // quyết định xem có thay đổi hay không.
        dd[fr[tt][i]] = false; // đánh dấu miền theo trường hợp
        res += dem[fr[tt][i]];
    }
    cout << res;
}

int main() {
    freopen("double14.inp","r",stdin);
    freopen("double14.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d", &a[0][i]); // đọc hàng 0
    For(i, 1, n) scanf("%d", &a[1][i]); // đọc hàng 1
    solve();
}
