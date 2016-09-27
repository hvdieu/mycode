#include <bits/stdc++.h>

using namespace std;

typedef pair<int, int> ii;

const int N = 110;
const int inf = 2*60000 + 10;

int n, a[N], ntest, res;
int f[2*60000 + 10];
priority_queue< ii, vector<ii>, greater<ii> > heap;

int main() {
    ios_base::sync_with_stdio(false);
    //freopen("input.txt", "r", stdin);
   // freopen("output.txt", "w", stdout);
    cin >> ntest;
    while (ntest) {
        ntest--;
        cin >> n;
        for(int i = 1; i <= n; i++) cin >> a[i];
        int g = a[1];
        for(int i = 2; i <= n; i++) g = __gcd(g, a[i]);
        int MAX = 0;
        for(int i = 1; i <= n; i++) a[i] /= g, MAX = max(MAX, a[i]);
        memset(f, 0x7f, sizeof f);
        for(int i = 1; i <= n; i++) {
            f[a[i]] = 1;
            for(int j = 1; j <= MAX; j++) if (f[j] <= n) {
                g = __gcd(j, a[i]); f[g] = min(f[g], f[j] + 1);
            }
        }
        cout << f[1] << endl;
    }
}
