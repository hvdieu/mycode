#include <bits/stdc++.h>

using namespace std;

const int N = 4000 + 5;

int n, a, b, c;
int f[N];

int main() {
    cin >> n >> a >> b >> c;
    f[0] = 0;
    for(int i = 1; i <= n; i++) {
        f[i] = -n;
        if (i >= a) f[i] = max(f[i], f[i-a]+1);
        if (i >= b) f[i] = max(f[i], f[i-b]+1);
        if (i >= c) f[i] = max(f[i], f[i-c]+1);
    }
    cout << f[n];
}
