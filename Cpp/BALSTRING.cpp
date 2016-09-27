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
#define N 100010

int n, f[N][8], sum[N][8], k, m;
char s[N], kk;
int T, id[N], vt[N], cs[N];
int a[N];

bool cmp(int i, int j) {
    For(jj, 0, kk-1) {
        if (f[i][jj] < f[j][jj]) return true;
        if (f[i][jj] > f[j][jj]) return false;
    }
    return i < j;
}

bool check(int i, int j) {
    For(jj, 0, kk-1) if (f[i][jj] != f[j][jj]) return false;
    return true;
}

int main() {
    freopen("balstring.inp","r",stdin);
    freopen("balstring.out","w",stdout);
    scanf("%s\n", s+1);
    n = strlen(s+1);
    For(i, 1, n) k = max(k, s[i] - 'a');
    For(i, 1, n)a[i] = s[i] - 'a';
    T = two(k+1)-1;
    int res = 0, u, v;
    For(tt, 1, T) {
        kk = -1;
        For(j, 0, k) if (bit(tt, j)) cs[j] = ++kk;
        int i = 1;
        while (i <= n) {
            if (!bit(tt, a[i])) i++;
            else {
                int j = i;
                while (j < n && bit(tt, a[j+1])) j++;
                For(jj, 0, kk) sum[i-1][jj] = f[i-1][jj] = 0;
                int m = 0; id[0] = i-1;
                For(ii, i, j) {
                    For(jj, 0, kk) sum[ii][jj] = sum[ii-1][jj];
                    sum[ii][cs[a[ii]]]++;
                    For(jj, 0, kk-1) {
                        f[ii][jj] = sum[ii][jj+1] - sum[ii][jj];
                 //       cout << f[ii][jj] << ' ';
                    }
                   // cout << endl;
                    id[++m] = ii;
                }
                sort(id, id+m+1, cmp);
               // For(i, 0, m) cout << id[i] << ' '; cout << endl;
                int ii = 0;
                while (ii <= m) {
                    int jj = ii;
                    while (jj < m && check(id[ii], id[jj+1])) jj++;
                    if (id[jj]-id[ii] > res) {
                        res = id[jj]-id[ii];
                        u = id[ii]+1; v = id[jj];
                    } else if (id[jj] - id[ii] == res && id[ii] < u) {
                        u = id[ii]+1; v = id[jj];
                    }
                    ii = jj+1;
                }
                i = j + 1;
            }
        }
    }
    cout << u-1 << ' ' << v-1;
}
