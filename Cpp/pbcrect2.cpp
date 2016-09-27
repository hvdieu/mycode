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

int m, n, a[M][N], dem[M], area, ways, h[N], sx[M], sy[M], top, sum[N], mm, head[M], next[M*N], qx[M*N], qy[M*N];
char s[N];
int sl;

void solve() {
    For(x, 1, mm) {
        int jj = head[x];
        while (jj) {
            int i = qx[jj], j = qy[jj];
            a[i][++dem[i]] = j;
            int r = x * (n - dem[i] + 1);
            if (r > area) {
                area = r; top = 0;
                sx[++top] = i; sy[top] = dem[i];
            } else if (r == area) {
                sx[++top] = i; sy[top] = dem[i];
            }
            jj = next[jj];
        }
    }
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

inline void push(int x, int i, int j) {
    sl++;
    qx[sl] = i; qy[sl] = j;
    next[sl] = head[x]; head[x] = sl;
}

int main() {
    freopen("pbcrect.inp","r",stdin);
    //freopen("pbcrect.out","w",stdout);
    scanf("%d %d\n", &m, &n);
    For(i, 1, m) {
        scanf("%s\n", (s+1));
        For(j ,1, n) {
            if (s[j] == '0') h[j] = 0; else h[j]++;
            int x = h[j];
            if (x > mm) mm = x;
            if (x) push(x, i, j); else dem[i]++;
        }
    }
    solve();
}



