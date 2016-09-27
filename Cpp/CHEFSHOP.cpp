#include <bits/stdc++.h>

using namespace std;

const int N = 16;

int ntest, n, m, a[N], f[1 << N], k, id[N];
bool dd[N][1 << N];

int onbit(int x, int i) { return x | (1 << i); }

int bit(int x, int i) { return x & (1 << i); }

int main() {
    freopen("input.txt", "r", stdin);
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d", &n);
        int sum = 0;
        for(int i = 0; i < n; i++) scanf("%d", a + i), sum += a[i];
        sort(a + 0, a + n);
        memset(dd, false, sizeof(dd));
        scanf("%d", &m);
        for(int i = 0; i < m; i++) {
            scanf("%d", &k);
            int x = 0;
            for(int j = 0; j < k; j++) scanf("%d", id + j), x = onbit(x, id[j]-1);
            for(int j = 0; j < k; j++) dd[id[j]-1][x] = true;
        }
        for(int i = 0; i < n; i++)
            for(int tt = 0; tt < (1 << n); tt++) if (dd[i][tt])
            for(int j = 0; j < n; j++) if (!bit(tt, j)) dd[i][onbit(tt, j)] = true;
        memset(f, 0, sizeof(f));
        for(int tt = 0; tt < (1 << n); tt++) {
        	cout << tt << ' ' << f[tt] << endl;
            int inv_tt = 0;
            for(int j = 0; j < n; j++) if (!bit(tt, j)) inv_tt = onbit(inv_tt, j);
            int i = __builtin_popcount(tt);
            for(int j = 0; j < n; j++) if (!bit(tt, j)) {
                int cost = 0;
            //    cout << j << ' ' << inv_tt << ' ' << dd[j][inv_tt] << endl;
                if (dd[j][inv_tt]) cost = a[i];
                f[onbit(tt, j)] = max(f[onbit(tt, j)], f[tt] + cost);
            }
        }
        //cout << f[7] << endl;
        printf("%d\n", sum - f[(1 << n) - 1]);
    }
}
