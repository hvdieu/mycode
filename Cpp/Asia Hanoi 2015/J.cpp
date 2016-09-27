#include <bits/stdc++.h>

using namespace std;

int nTest, n;

int main() {
    ios_base::sync_with_stdio(false);
    cin >> nTest;
    for(int iTest = 1; iTest <= nTest; iTest++) {
        cin >> n;
        long long sum = 0;
        long long maxA = 0;
        for(int i = 1; i <= n; i++) {
            long long x;
            cin >> x;
            sum += x;
            maxA = max(maxA, x);
        }
        long long ans = sum / (n - 1);
        if (sum % (n - 1)) ans++;
        cout << max(maxA, ans);
    }
}
