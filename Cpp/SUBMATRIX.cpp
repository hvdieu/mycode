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
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 310

int m, n, a[N][N], dem[N*N], k, l, cnt;

void push(int x) { dem[x]++; if (dem[x]==1) cnt++; }
void pop(int x) { dem[x]--; if (!dem[x]) cnt--; }

void add(int x1, int x2, int y1, int y2) {
    For(i, x1, x2) For(j, y1, y2) push(a[i][j]);
}

void del(int x1, int x2, int y1, int y2) {
    For(i, x1, x2) For(j, y1, y2) pop(a[i][j]);
}

void cal(int i, int j, bool go) {
    if (i > m) return;
    while (1) {
        l++;
        if (i+l-1 <= m && j+l-1 <= n) {
            add(i+l-1, i+l-1, j, j+l-1);
			add(i, i+l-1, j+l-1, j+l-1);
			pop(a[i+l-1][j+l-1]);
            if (cnt > k) {
                del(i+l-1, i+l-1, j, j+l-1); del(i, i+l-1, j+l-1, j+l-1); push(a[i+l-1][j+l-1]);
                break;
            }
        } else break;
    }
    l--;
    if (go) {
        if (j < n-l+1) {
            del(i, i+l-1, j, j); add(i, i+l-1, j+l, j+l);
            cal(i, j+1, true);
        } else if (i < m-l+1) {
            del(i, i, j, j+l-1); add(i+l, i+l, j, j+l-1);
            cal(i+1, j, false);
        }
    } else {
        if (j > 1) {
            del(i, i+l-1, j+l-1, j+l-1); add(i, i+l-1, j-1, j-1);
            cal(i, j-1, false);
        } else if (i < m-l+1) {
            del(i, i, j, j+l-1); add(i+l, i+l, j, j+l-1);
            cal(i+1, j, true);
        }
    }
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("submatrix.inp","r",stdin);
    freopen("submatrix.out","w",stdout);
    cin >> m >> n >> k;
    For(i, 1, m) For(j, 1, n) cin >> a[i][j];
    dem[a[1][1]] = 1; cnt = 1; l = 1;
    cal(1, 1, 1);
    cout << l;
}
