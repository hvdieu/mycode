#include <bits/stdc++.h>

using namespace std;

#define For(i, a, b) for(int i = a; i <= b; i++)

const int M = 1e6 + 3;

long long g1, g2, g3;
int n, k;

long long pw(long long a, long long n) {
    long long res = 1;
    while (n) {
        if (n & 1) res = (res * a) % M;
        n >>= 1;
        a = (a * a) % M;
    }
    return res;
}

int main() {
    cin >> n >> k;
    n += k;
    g1 = g2 = g3 = 1;
    For(i, 1, n) {
        if (i <= k) g1 = (g1 * i) % M;
        if (i <= n-k) g2 = (g2 * i) % M;
        g3 = (g3 * i) % M;
    }
    long long ans = (g3 * pw((g1*g2) % M, M-2)) % M;
    ans -= 1; if (ans < 0) ans += M;
    cout << ans;
}
