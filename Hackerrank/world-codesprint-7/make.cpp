#include <bits/stdc++.h>

using namespace std;

int main() {
    srand(time(NULL));
    freopen("in.txt", "w", stdout);
    int n = 10000, q = n;
    cout << n << ' ' << q << "\n";
    for(int i = 0; i < n; i++) cout << char('a'+rand() % 10); cout << "\n";
    for(int i = 0; i < q; i++) {
        int L = rand() % n + 1;
        int len = n - L + 1;
        int R = L + rand() % len;
        cout << L << ' ' << R << "\n";
    }
}
