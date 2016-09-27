#include <bits/stdc++.h>

using namespace std;

const long long inf = 1e18 + 10;
const int N = 1e5 + 10;

int ntest, n, a[N];
long long s[N], MAX[N];

int main() {
    cin >> ntest;
    while (ntest--) {
        cin >> n;
        for(int i = 1; i <= n; i++) {
            cin >> a[i];
            s[i] = s[i-1] + a[i];
        }
        MAX[n+1] = -inf;
        for(int i = n; i >= 1; i--) MAX[i] = max(MAX[i+1], s[i]);
        long long MIN = 0, ans = s[n];
        for(int i = 1; i <= n; i++) {
            ans = max(ans, s[i] - MIN);
            ans = max(ans, MAX[i+1] - MIN - a[i]);
            MIN = min(MIN, s[i]);
        }
        cout << ans << "\n";
    }
}
