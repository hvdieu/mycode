#include <bits/stdc++.h>

using namespace std;

long long m;

const long long inf = 1e18;

long long count(long long x) {
    long long ans = 0;
    for(long long k = 2; k <= 1000000; k++) {
        long long K = k*k*k;
        if (K > x) break;
        if (ans > m - x / K) return m+1;
        ans += x / K;
    }
    return ans;
}

int main() {
    //ifstream cin("input.txt");
    cin >> m;
    long long l = 1, r = inf, mid, ans = -1;
    while (l <= r) {
        mid = (l + r) / 2;
        long long cnt = count(mid);
        if (cnt == m) {
            ans = mid;
            r = mid - 1;
        } else if (cnt > m) r = mid -1;
          else l = mid + 1;
    }
    cout << ans;
    //327846238462837
}
