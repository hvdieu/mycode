#include <bits/stdc++.h>

using namespace std;

int main() {
    ios_base::sync_with_stdio(false);
    long long n, m;
    int ntest;
    cin >> ntest;
    while (ntest--) {
        cin >> n >> m;
        if ((n * m) % 2) cout << "No\n"; else cout << "Yes\n";
    }
}
