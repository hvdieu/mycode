#include <algorithm>
#include <cassert>
#include <cstdio>
#include <cstring>
#include <iostream>
#include <queue>
#include <set>
#include <vector>

using namespace std;

const int N = 123456;

struct line {
    int a, b;
} L[N];

long double eval(long long k, const line& L) {
    return L.b + (long double)k / L.a;
}

int main() {
    freopen("input.txt", "r", stdin);
    freopen("output.out", "w", stdout);
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int tt;
    cin >> tt;
    while (tt--) {
        int n, m;
        cin >> n >> m;
        for (int i = 0; i < n; ++i) {
            cin >> L[i].a >> L[i].b;
        }
        for (int i = 0; i < m; ++i) {
            long long k;
            cin >> k;
            line& best = L[0];
            for (int j = 1; j < n; ++j)
                if (eval(k, best) > eval(k, L[j]))
                    best = L[j];
            long long x = (long long)best.b * best.a + k;
            long long y = best.a;
            long long g = __gcd(x, y);
            x /= g;
            y /= g;
            cout << x << '/' << y << '\n';
        }
    }
}
