#include <bits/stdc++.h>

using namespace std;

#define For(i, a, b) for(int i = a; i <= b; i++)

const int TT = 5000000 + 10;


int T, A, B;
bool was[TT];

int main() {
    freopen("feast.in", "r", stdin);
    freopen("feast.out", "w", stdout);
    cin >> T >> A >> B;
    was[0] = 1;
    For(i, 0, T) if (was[i]) {
        if (i + A <= T) was[i + A] = true;
        if (i + B <= T) was[i + B] = true;
        was[i >> 1] = true;
    }
    For(i, 0, T) if (was[i]) {
        if (i + A <= T) was[i + A] = true;
        if (i + B <= T) was[i + B] = true;
    }
    for(int i = T; i >= 0; i--) if (was[i]) {
        cout << i; return 0;
    }
}
