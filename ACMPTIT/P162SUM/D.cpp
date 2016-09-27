#include <bits/stdc++.h>

using namespace std;

const int N = 1e5 + 5;

int n, last, now;

int main() {
    cin >> n;
    long long ans = 0;
    last = -1;
    for(int i = 1; i <= n; i++) {
        cin >> now;
        if (now < last) ans += last - now;
        last = now;
    }
    cout << ans;
}
