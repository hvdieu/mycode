#include <bits/stdc++.h>

using namespace std;

const int N = 1e5 + 10;

int n, k, ntest;
bool was[N];
int a[N];

void solve() {
    memset(was, false, sizeof was);
    int dau = 1;
    for(int i = 1; i <= n; i++) {
        int x = i + dau * k;
        if (x <= 0 || x > n || was[x]) {
            cout << -1 << "\n";
            return;
        }

        a[i] = x;
        was[x] = true;
        if (k != 0 && i % k == 0) dau *= -1;
    }
    for(int i = 1; i <= n; i++) cout << a[i] << ' '; cout << "\n";
}

int main() {
    cin >> ntest;
    while (ntest--) {
        cin >> n >> k;
        solve();
    }
}
