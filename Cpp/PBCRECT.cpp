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
#define reset(f,x) memset(f,x,sizeof(f))
#define M 15001
#define N 1501

int m, n, a[M][N], h[N], sx[M], sy[M], top, sum[N], mm;
int area, ways;
char s[N];

void solve() {
    cout << area << endl;
    ways = n + 1;
    For(k, 1, top) {
        reset(sum, 0);
        int i = sx[k], j = sy[k], len = n - j + 1;
        For(jj, j, n) sum[a[i][jj]] = 1;
        For(jj, 1, n) {
            sum[jj] += sum[jj-1];
            if (jj >= len) ways = min(ways, len - (sum[jj] - sum[jj - len]));
        }
    }
    cout << ways;
}

int main() {
    freopen("pbcrect.inp","r",stdin);
    //freopen("pbcrect.out","w",stdout);
    scanf("%d %d\n", &m, &n);
    For(j, 1, n) a[0][j] = j;
    For(i, 1, m) {
        scanf("%s\n", (s+1));
        int dem = 0;
        For(j ,1, n) {
            if (s[j] == '0') h[j] = 0; else h[j]++;
            int x = h[j];
            if (!x) a[i][++dem] = j;
        }
        For(jj, 1, n) if (h[a[i-1][jj]]) {
            int j = a[i-1][jj];
            a[i][++dem] = j;
            int r = h[j] * (n - dem + 1);
            if (r > area) {
                area = r; top = 0; sx[++top] = i; sy[top] = dem;
            } else if (r == area) {
                sx[++top] = i; sy[top] = dem;
            }
        }
    }
    solve();
}



