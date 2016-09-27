#include <bits/stdc++.h>

using namespace std;

long long a, b, ans;

int main() {
    cin >> a >> b;
    while (b) {
        ans += a / b;
        a = a % b;
        swap(a, b);

    }
    cout << ans;
}
