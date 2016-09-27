#include <algorithm>
#include <cassert>
#include <cstdio>
#include <cstring>
#include <iostream>
#include <vector>

constexpr int N = 200010;
constexpr int SQRT = 450;
constexpr int MOD = 1e9 + 7;

long long a[N];

int main() {
    freopen("input.txt", "r", stdin);
    freopen("out.txt", "w", stdout);
    int n, m;
    scanf("%d %d", &n, &m);
    for (int i = 0; i < m; ++i) {
        int t, x, y;
        scanf("%d %d %d", &t, &x, &y);
        if (t == 1) {
            for (int i = x; i <= y; ++i) {
                int k = i - x + 1;
                a[i] += 1LL * k * (k + 1);
            }
        } else {
            long long sum = 0;
            for (int i = x; i <= y; ++i) {
                sum += a[i];
            }
            int answer = sum % MOD;
            printf("%d\n", answer);
        }
    }
}
