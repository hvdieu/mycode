#include <bits/stdc++.h>

using namespace std;

const int N = 16;

int n, ntest, m, a[N];
int cnt, d[1 << N][2], f[1 << N];

int onbit(int x, int j) { return x | (1 << (j-1)); }
int bit(int x, int j) { return (x >> (j-1)) & 1; }

void push(int tt) {
    int t = 0;
    for(int i = 1; i <= n; i++) {
        int j = bit(tt, i);
        if (!d[t][j]) d[t][j] = ++cnt;
        t = d[t][j];
    }
}

void dfs(int t, int step, int t1, int t2) {
    if (step > n) {
        int i = __builtin_popcount(t1) + 1;
        int num = __builtin_popcount(t2);
        if (num > 1) f[t1 | t2] = max(f[t1 | t2], f[t1] + a[i]);
        else f[t1 | t2] = max(f[t1 | t2], f[t1]);
        return;
    }
    if (d[t][0]) dfs(d[t][0], step + 1, t1, t2);
    if (!bit(t1, step) && d[t][1]) dfs(d[t][1], step + 1, t1, onbit(t2, step));
}

int main() {
   // freopen("input.txt", "r", stdin);
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d", &n);
        int sum = 0;
        for(int i = 1; i <= n; i++) scanf("%d", a + i), sum += a[i];
        sort(a + 1, a + n + 1);
        scanf("%d", &m);
        memset(d, 0, sizeof(d));
        cnt = 0;
        for(int i = 1; i <= m; i++) {
            int k, tt = 0;
            scanf("%d", &k);
            for(; k; k--) {
                int j; scanf("%d", &j);
                tt = onbit(tt, j);
            }
            push(tt);
        }
        for(int i = 1; i <= n; i++) push(1 << (i-1));
        memset(f, 0, sizeof(f));
        for(int tt = 0; tt < (1 << n); tt++) {
            dfs(0, 1, tt, 0);
          //  for(int x = 0; x < (1 << n); x++) cout << f[x] << ' '; cout << endl;
        }
        printf("%d\n", sum - f[(1 << n)-1]);
    }
}
