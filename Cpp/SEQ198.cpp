#include <bits/stdc++.h>

#define bit(x, i) ((x >> (i-1)) & 1)
#define offbit(x, i) (x & (~(1 << (i-1))))
#define onbit(x, i) (x | (1 << (i-1)))

using namespace std;

const int N = 2000 + 10;
const int T = 1 << 9;

int n, a[N], m, c[N], f[2][T];

int main() {
    ios_base::sync_with_stdio(false);
    //ifstream cin("input.txt");
    //ofstream cout("output.txt");
    cin >> n;
    for(int i = 1; i <= n; i++) cin >> a[i];
    sort(a + 1, a + n + 1);
    a[0] = -1;
    for(int i = 1; i <= n; i++)
        if (a[i] != a[i-1]) {
            a[++m] = a[i]; c[m] = 1;
        } else c[m]++;
    int res = n;
    n = m;
    //for(int i = 1; i <= n; i++) cout << a[i] << ' ' << c[i] << "\n";
    memset(f, 0x7f, sizeof f);
    f[0][1] = 0; f[0][0] = c[1];
    int t = 0;
    for(int i = 2; i <= n; i++) {
       // cout << "\n";
        t = 1 - t;
        memset(f[t], 0x7f, sizeof f[t]);
        for(int tt = 0; tt < T; tt++) {
            bool ok = true;
            //cout << f[t][tt] << ' ';
            for(int j = max(i-9, 1); j <= i-1; j++)
                if ((a[i] - a[j] == 1 || a[i] - a[j] == 8 || a[i] - a[j] == 9) && (bit(tt, i-j))) ok = false;
            int newtt = offbit(tt, 9);
            newtt = (newtt << 1);
            f[t][newtt] = min(f[t][newtt], f[1-t][tt] + c[i]);
            if (i == n) {
                res = min(res, f[t][newtt]);
               // if (f[t][newtt] == 0) cout << t << ' ' << newtt << "\n";
            }
            if (ok) {
                newtt = newtt | 1;
                f[t][newtt] = min(f[t][newtt], f[1-t][tt]);
                if (i == n) {
                    res = min(res, f[t][newtt]);
                  //  if (f[t][newtt] == 0) cout << t << ' ' << newtt << "\n";
                }
            }
        }
    }
    cout << res;
}
