#include <bits/stdc++.h>

using namespace std;

const int N = 1e5 + 10;
const long long MAX = 1e18;

int n, h[N], r[N];
long long W, L;


int main() {
try {
    ios_base::sync_with_stdio(0);
    //ifstream cin("in.txt");
    cin >> n >> W >> L;
    long long lo = 0, hi = MAX, ans, mid;
    for(int i = 0; i < n; i++) {
        cin >> h[i] >> r[i];
        if (h[i] >= W) {
            cout << 0;
            return 0;
        }
        hi = min(hi, (W - h[i])/r[i] + 1);
    }
    while (lo <= hi) {
        mid = (lo + hi) / 2;
        long long sum = 0;
        bool flag = false;
        for(int i = 0; i < n; i++) {
            long long H = (long long)h[i] + mid * r[i];
            if (H >= L) {
                if (sum >= W - H) {
                    flag = true; break;
                } else sum += H;
            }
        }
        if (flag) {
            ans = mid;
            hi = mid - 1;
        } else lo = mid + 1;
    }
    cout << ans;
} catch (exception()) {
    assert(1 > 2);
}
}
