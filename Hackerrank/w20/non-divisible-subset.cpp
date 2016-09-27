#include <bits/stdc++.h>

using namespace std;

const int K = 100;

int n, k, cnt[K];

int main() {
    cin >> n >> k;
    for(int i = 0; i < n; i++) {
        int x;
        cin >> x;
        cnt[x % k]++;
    }
    int ans = 0;
    for(int i = 0; i < (k+1)/2; i++) ans += max(cnt[i], cnt[k-i]);
    if (k % 2 == 0 && cnt[k / 2]) ans++;
    cout << ans;
}
