#include <bits/stdc++.h>

using namespace std;

const int N = 1e4 + 10;

int n, ntest, a[N], b[N];

int main() {
    cin >> ntest;
    while (ntest--) {
        cin >> n;
        for(int i = 1; i <= n; i++) cin >> a[i];
        for(int i = 1; i <= n; i++) cin >> b[i];
        int ans = 0;
        for(int i = 1; i <= n; i++)
            ans += (a[i] - a[i-1] >= b[i]);
        cout << ans << "\n";
    }
}
