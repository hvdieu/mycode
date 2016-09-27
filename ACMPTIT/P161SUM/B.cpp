#include <bits/stdc++.h>

using namespace std;

#define For(i, a, b) for(int i = a; i <= b; i++)

const int N = 100 + 10;

int n, m;
int a[N], b[N];

int main() {
    cin >> n >> m;
    For(i, 0, n) cin >> a[i];
    For(i, 0, m) cin >> b[i];
    if (n > m) {
        if (a[0]*b[0] > 0) cout << "Infinity";
        else cout << "-Infinity";
    } else if (n < m) cout << "0/1";
    else {
        int x = __gcd(abs(a[0]), abs(b[0]));
        int p = a[0] / x, q = b[0] / x;
        if (q < 0) {
            p = -p; q = -q;
        }
        cout << p << "/" << q;
    }
}

