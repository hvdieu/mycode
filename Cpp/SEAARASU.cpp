#include <bits/stdc++.h>

using namespace std;

const int N = 100000 + 10;

int n, ntest;

int main() {
    //freopen("input.txt", "r", stdin);
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d", &n);
        int res; scanf("%d", &res);
        for(int i = 2; i <= n; i++) {
            int x; scanf("%d", &x);
            res = __gcd(res, x);
        }
        printf("%lld\n", (long long)res * n);
    }
}
