#include <bits/stdc++.h>

using namespace std;

const int N = 100;

int n, k, a[N];

int main() {
    cin >> n >> k;
    for(int i = 0; i < n; i++) cin >> a[i];
    int ans = 0;
    for(int i = 0; i < n; i++)
        for(int j = i+1; j < n; j++)
            if ((a[i] + a[j]) % k == 0) ans++;
    cout << ans;
}
